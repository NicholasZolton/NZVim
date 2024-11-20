local autocmd = vim.api.nvim_create_autocmd

-- define some global constants for user name and email, etc.
NZVIM_USER_NAME = "Nicholas Zolton"
NZVIM_USER_EMAIL = "nicholaszolton@gmail.com"
NZVIM_USER_URL = "https://nicholaszolton.dev"

function Messagify(msg)
  local lines = {}
  local line = ""
  for word in msg:gmatch "%S+" do
    -- Check if adding this word would exceed the character limit
    if #line + #word + 1 > 60 then
      -- Trim any leading/trailing whitespace and add the line to lines
      table.insert(lines, line:match "^%s*(.-)%s*$")
      line = word -- Start a new line with the current word
    else
      -- Add the word to the current line (with a space if the line is non-empty)
      line = (line == "" and word) or (line .. " " .. word)
    end
  end

  -- Add any remaining text in `line` to the lines table
  if line ~= "" then
    table.insert(lines, line:match "^%s*(.-)%s*$")
  end

  -- Join all lines with newline characters
  return table.concat(lines, "\n")
end

-- Function to count words in the current file
function CountWordsInFile()
  local filename = vim.fn.expand "%:p" -- Get the current file path
  local file = io.open(filename, "r") -- Open the file in read mode
  if not file then
    print("Error: Could not open file " .. filename)
    return
  end

  local content = file:read "*all" -- Read the entire file
  file:close()

  -- Count words using string.gmatch
  local wordCount = 0
  for word in content:gmatch "%S+" do
    wordCount = wordCount + 1 -- Increase count for each word found
  end

  print("Number of words in " .. filename .. ": " .. wordCount) -- Print the count
end

-- sigmoid function
function Sigmoid(x)
  return 1 / (1 + math.exp(-x))
end

-- Define a command :WordCount
vim.cmd "command! WordCount lua CountWordsInFile()"

-- Manually add a function that updates treesitter when the buffer changes
autocmd({ "TextChanged", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("AutoTresitterParseMan", {}),
  callback = (function()
    local timer
    return function()
      if timer and timer:is_active() then
        timer:close()
      end
      timer = vim.defer_fn(function()
        if vim.b._last_parse_changedtick ~= vim.b.changedtick then
          vim.b._last_parse_changedtick = vim.b.changedtick
          pcall(function()
            vim.treesitter.get_parser():parse()
          end)
        end
      end, 200)
    end
  end)(),
})

-- print given range
function GetGivenRange()
  -- Get the start and end positions of the visual selection
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local lnum1, col1 = start_pos[2], start_pos[3]
  local lnum2, col2 = end_pos[2], end_pos[3]

  -- Get all the lines in the selected range
  local lines = vim.api.nvim_buf_get_lines(0, lnum1 - 1, lnum2, false)
  lines[#lines] = string.sub(lines[#lines], 1, col2 - (vim.o.selection == "inclusive" and 0 or 1))
  lines[1] = string.sub(lines[1], col1)
  local selectedText = table.concat(lines, "\n")

  -- print
  return selectedText
end

-- Define a command :GetGivenRange
vim.cmd "command! -range GetGivenRange lua GetGivenRange()"

-- Define a command :EvalLua
function EvalLua()
  local rangeString = GetGivenRange()
  if not rangeString then
    return nil
  end
  local f = load("return " .. rangeString)
  if not f then
    return nil
  end
  local result = f()
  if result then
    vim.notify(Messagify(result))
  end
  return result
end

vim.cmd "command! -range EvalLua lua EvalLua()"

-- Define a command :Math
function Math()
  local rangeString = GetGivenRange()
  if not rangeString then
    return nil
  end

  -- Prepare the math environment
  local math_env = {}
  for k, v in pairs(math) do
    math_env[k] = v
  end

  -- Use load() with the math environment
  local result = load("return " .. rangeString, "temp", "t", math_env)()
  vim.notify(Messagify(rangeString .. " = " .. result))
  return result
end

vim.cmd "command! -range Math lua Math()"

function CountWordsInRange()
  local rangeString = GetGivenRange()
  if not rangeString then
    return nil
  end

  -- count words by splitting the string on whitespace
  local words = {}
  for word in rangeString:gmatch "%S+" do
    table.insert(words, word)
  end
  vim.notify("Number of words: " .. #words)
  return #words
end

vim.cmd "command! -range CountWordsInRange lua CountWordsInRange()"

function SpeakingTimeRegion()
  -- Get the substring within the specified range
  local text = GetGivenRange()

  -- Count lines
  local lines = select(2, text:gsub("\n", "\n")) + 1

  -- Count words by splitting on whitespace
  local words = 0
  for _ in text:gmatch "%S+" do
    words = words + 1
  end

  -- Character count
  local chars = #text

  -- Reading time calculations
  local minutes = math.floor(words / 125)
  local seconds = math.floor(((words % 125) / 125) * 60)

  -- Display message
  vim.notify(
    Messagify(
      string.format(
        "%d line%s, %d word%s, %d character%s, and will take %d minute%s and %d second%s to read.",
        lines,
        (lines == 1 and "" or "s"),
        words,
        (words == 1 and "" or "s"),
        chars,
        (chars == 1 and "" or "s"),
        minutes,
        (minutes == 1 and "" or "s"),
        seconds,
        (seconds == 1 and "" or "s")
      )
    )
  )
end

vim.cmd "command! -range SpeakingTimeRegion lua SpeakingTimeRegion()"

-- Define a command to evaluate a region with python
function EvaluatePython(pystring)
  -- Escape double quotes in the Python string
  pystring = pystring:gsub('"', '\\"')
  -- pystring = pystring:gsub("'", "\\'")
  -- Construct the Python command
  local command = { "python", "-c", "print(" .. pystring .. ")" }
  -- Run the command
  local result = vim.system(command, { text = true }):wait()
  -- Return stdout or nil if there was an error
  if result.code ~= 0 then
    print("Error: " .. (result.stderr or "Unknown error"))
    return nil
  end
  return result.stdout
end

function PyMath()
  local rangeString = GetGivenRange()
  if not rangeString then
    return nil
  end

  -- Escape double quotes in the Python string
  rangeString = rangeString:gsub('"', '\\"')
  -- pystring = pystring:gsub("'", "\\'")
  -- Construct the Python command
  local command =
    { "python", "-c", "from math import *; from itertools import *; import bisect; print(" .. rangeString .. ")" }
  -- Run the command
  local result = vim.system(command, { text = true }):wait()
  -- Return stdout or nil if there was an error
  if result.code ~= 0 then
    vim.notify(Messagify("Error: " .. (result.stderr or "Unknown error")))
    return nil
  end
  vim.notify(Messagify(result.stdout))
  vim.fn.setreg("+", result.stdout)
end

vim.cmd "command! -range PyMath lua PyMath()"
-- [5*i + 3 for i in range(20)]

function PyBlock()
  local start_pos = vim.fn.getpos "'<"
  local end_pos = vim.fn.getpos "'>"
  local lnum1, _ = start_pos[2], start_pos[3]
  local lnum2, _ = end_pos[2], end_pos[3]
  local lines = vim.api.nvim_buf_get_lines(0, lnum1 - 1, lnum2, false)

  -- join the lines with "; " instead of "\n"
  local rangeString = table.concat(lines, "; ")
  rangeString = rangeString:gsub('"', '\\"')

  -- Construct the Python command
  local command = {
    "python",
    "-c",
    "from math import *; from itertools import *; import bisect; from collections import *; " .. rangeString,
  }
  -- Run the command
  local result = vim.system(command, { text = true }):wait()
  -- Return stdout or nil if there was an error
  if result.code ~= 0 then
    vim.notify(Messagify("Error: " .. (result.stderr or "Unknown error")))
    return nil
  end
  -- vim.notify(Messagify(result.stdout))
  vim.notify(result.stdout)
  vim.fn.setreg("+", result.stdout)
end

vim.cmd "command! -range PyBlock lua PyBlock()"
