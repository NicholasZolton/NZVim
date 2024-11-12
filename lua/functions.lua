local autocmd = vim.api.nvim_create_autocmd

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
  vim.notify(rangeString .. " = " .. result)
  return result
end

vim.cmd "command! -range Math lua Math()"
