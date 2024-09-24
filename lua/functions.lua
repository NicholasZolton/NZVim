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
