require "nvchad.mappings"

local map = vim.keymap.set
if vim.g.vscode == 1 then
  -- personal remappings for vscode
  map("n", "<leader>h", function()
    require("vscode").action "workbench.action.terminal.toggleTerminal"
  end, { desc = "Quick Open", remap = true })

  map("n", "<leader>e", function()
    require("vscode").action "workbench.action.toggleSidebarVisibility"
  end, { desc = "Toggle Side Bar", remap = true })

  map("n", "<leader>ra", function()
    require("vscode").action "editor.action.rename"
  end, { desc = "Rename Symbol", remap = true })

  map("n", "<leader>bk", function()
    require("vscode").action "workbench.action.closeActiveEditor"
  end, { desc = "Buffer Kill" })

  map("n", "<leader>ae", function()
    require("vscode").action "inlineChat.start"
  end, { desc = "Open Inline Chat" })

  map("n", "<leader>aa", function()
    require("vscode").action "workbench.action.chat.openAgent"
  end, { desc = "Open Chat" })
else
  -- personal remappings
  map("n", "<tab>", "za")
  map("n", "<leader>qs", "<CMD>wq<CR>", { desc = "Close file save" })
  map("n", "<leader>qq", "<CMD>q<CR>", { desc = "Close file nosave" })
  map("n", "<C-a>", "ggVG", { desc = "Select all" })

  -- telescope mappings
  map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
  map("n", "<leader>fw", "<CMD>lua require('telescope.builtin').live_grep()<CR>", { desc = "Find word" })
  map("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>", { desc = "Find buffers" })
  map("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>", { desc = "Find help" })
  map("n", "<leader>fk", "<CMD>lua require('telescope.builtin').keymaps()<CR>", { desc = "Find keymaps" })
  map("v", "<leader>fk", "<CMD>lua require('telescope.builtin').keymaps()<CR>", { desc = "Find keymaps" })
  map("n", "<leader>fr", "<CMD>Telescope frecency<CR>", { desc = "Find recent files" })
  map("n", "<leader>fc", '<CMD>lua require"telescope.builtin".commands()<CR>', { desc = "Find commands" })
  map("n", "<leader>fp", "<CMD>Telescope projects<CR>", { desc = "Find projects" })
  map("n", "<leader>fb", "<CMD>Telescope file_browser<CR>", { desc = "Find projects" })
  map("n", "<leader>fs", "<CMD>lua require('telescope.builtin').treesitter()<CR>", { desc = "Find symbols" })

  map("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { desc = "Toggle file explorer", remap = true })
  map("n", "<leader>pi", "<CMD>Lazy install<CR>", { desc = "Install plugins" })
  map("n", "<leader>pu", "<CMD>Lazy update<CR>", { desc = "Update plugins" })
  map("n", "<leader>pc", "<CMD>Lazy clean<CR>", { desc = "Clean plugins" })
  map("n", "<leader>ps", "<CMD>Lazy sync<CR>", { desc = "Sync plugins" })
  map("n", "<leader>pk", "<CMD>Lazy check<CR>", { desc = "Check plugins" })

  map("n", "<leader>wh", "<C-h>", { desc = "Switch to left window" })
  map("n", "<leader>wl", "<C-l>", { desc = "Switch to right window" })
  map("n", "<leader>wj", "<C-j>", { desc = "Switch to down window" })
  map("n", "<leader>wk", "<C-k>", { desc = "Switch to up window" })

  -- open commands
  map("n", "<leader>gn", "<CMD>NvimTreeOpen ~/orgfiles/<CR>", { desc = "Open Notes" })
  local conf_path = vim.fn.stdpath "config"
  map("n", "<leader>gc", "<CMD>NvimTreeOpen " .. conf_path .. "<CR>", { desc = "Open Config" })
  local data_path = vim.fn.stdpath "data"
  map("n", "<leader>god", "<CMD>NvimTreeOpen " .. data_path .. "<CR>", { desc = "Open Nvim Data" })
  map("n", "<leader>g.", "<CMD>NvimTreeOpen .<CR>", { desc = "Open Here" })
  map("n", "<leader>gd", "<CMD>Dashboard<CR>", { desc = "Open Dashboard" })

  -- tab/window management
  map("n", "<C-h>", "<CMD>TmuxNavigateLeft<CR>", { desc = "Navigate Left", remap = true, silent = true })
  map("n", "<C-j>", "<CMD>TmuxNavigateDown<CR>", { desc = "Navigate Down", remap = true, silent = true })
  map("n", "<C-k>", "<CMD>TmuxNavigateUp<CR>", { desc = "Navigate Up", remap = true, silent = true })
  map("n", "<C-l>", "<CMD>TmuxNavigateRight<CR>", { desc = "Navigate Right", remap = true, silent = true })
  map("n", "<leader><tab>n", "<CMD>tab split<CR>", { desc = "Tab Split" })
  map("n", "<leader><tab>s", "<CMD>tab split<CR>", { desc = "Tab Split" })
  map("n", "<leader><tab>k", "<CMD>tab close<CR>", { desc = "Tab Close" })
  map("n", "<leader><tab>l", "<CMD>tabnext<CR>", { desc = "Tab Next" })
  map("n", "<leader><tab>h", "<CMD>tabprevious<CR>", { desc = "Tab Previous" })
  map("n", "<leader>wv", "<CMD>vsplit<CR>", { desc = "Window VSplit" })
  map("n", "<leader>ws", "<CMD>split<CR>", { desc = "Window Split" })
  map("n", "<leader>wk", "<CMD>close<CR>", { desc = "Window Kill" })
  map("n", "<leader>wO", "<CMD>only<CR>", { desc = "Window Kill Others" })

  -- make some mappings friendly to term
  map("i", "<C-BS>", "<C-W>", { noremap = false, silent = true })
  map("c", "<C-BS>", "<C-W>", { noremap = false, silent = false })
  map("n", "<C-/>", "<C-_>", { noremap = false, silent = true })
  map("v", "<C-/>", "<C-_>", { noremap = false, silent = true })
  map("t", "<Esc>", "<C-\\><C-n>", { noremap = false })
  map("t", "<C-Esc>", "<Esc>", { noremap = false })

  -- remap nvchad tabs
  map("n", "<S-h>", function()
    require("nvchad.tabufline").prev()
  end, { desc = "buffer goto prev" })

  map("n", "<S-l>", function()
    require("nvchad.tabufline").next()
  end, { desc = "buffer goto next" })

  map("n", "<leader>bk", function()
    require("nvchad.tabufline").close_buffer()
  end, { desc = "buffer close" })

  map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })

  -- add comment.nvim mappings
  map("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle Comment (Visual)" })
  map("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle Comment" })
  map("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle Comment (Visual)" })
  map("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle Comment" })


  -- lsp mappings
  map("n", "<S-d>", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show Error", noremap = false })

  -- map paste for command/terminal mode
  map("c", "<C-v>", "substitute(getreg('+'), '\\n', '', 'g') .. ''", { noremap = true, silent = false, expr = true })
  map("t", "<C-v>", "substitute(getreg('+'), '\\n', '', 'g') .. ''", { noremap = false, silent = false, expr = true })

  -- map ctrl-backspace for terminal mode
  map("t", "<C-BS>", "<C-W>", { noremap = false, silent = false })

  -- fix mappings in tmux
  map("t", "<C-H>", "<C-W>", { noremap = false, silent = false })
  map("i", "<C-H>", "<C-W>", { noremap = false, silent = false })

  -- map very magicness (basically default magic mode, quite hacky)
  map("n", "/", "/\\v", { noremap = true })
  -- map("c", "%s/", "s/\\v", { noremap = true })

  -- map paste for insert mode
  map("i", "<C-v>", "<C-r>+")


  -- eval mappings
  map("x", "<leader>el", ":EvalLua<CR>", { desc = "Eval Lua", silent = true })
  map("x", "<leader>ep", ":PyBlock<CR>", { desc = "Eval Python (Linewise)", silent = true })
  map("x", "<leader>eml", ":LuaMath<CR>", { desc = "Eval Math Lua", silent = true })
  map("x", "<leader>emp", ":PyMath<CR>", { desc = "Eval Math Python", silent = true })

  -- replace inside visual mode
  function FindReplaceVisual()
    -- prompt user for a search term
    local search = vim.fn.input "Search for (magic): "
    if search == nil or search == "" then
      return
    end

    -- prompt user for a replace term
    local replace = vim.fn.input "Replace with: "
    if replace == nil or replace == "" then
      return
    end

    -- execute the search and replace
    vim.cmd("'<,'>s/\\%V\\v" .. search .. "/" .. replace .. "/g")
  end
  map("x", "<C-r>", ":lua FindReplaceVisual()<CR>", { noremap = false, silent = true })

  -- personal remappings
  map("n", "<tab>", "za")
  map("n", "<C-a>", "ggVG", { desc = "Select all" })

  -- add comment.nvim mappings
  map("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle Comment (Visual)" })
  map("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle Comment" })
  map("v", "<C-_>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle Comment (Visual)" })
  map("n", "<C-_>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle Comment" })

  map("c", "<C-v>", "substitute(getreg('+'), '\\n', '', 'g') .. ''", { noremap = true, silent = false, expr = true })
  map("t", "<C-v>", "substitute(getreg('+'), '\\n', '', 'g') .. ''", { noremap = false, silent = false, expr = true })

  -- map ctrl-backspace for terminal mode
  map("t", "<C-BS>", "<C-W>", { noremap = false, silent = false })

  -- map very magicness (basically default magic mode, quite hacky)
  map("n", "/", "/\\v", { noremap = true })

  -- map paste for insert mode
  map("i", "<C-v>", "<C-r>+")

  -- eval mappings
  map("x", "<leader>el", ":EvalLua<CR>", { desc = "Eval Lua", silent = true })
  map("x", "<leader>ep", ":PyBlock<CR>", { desc = "Eval Python (Linewise)", silent = true })
  map("x", "<leader>eml", ":LuaMath<CR>", { desc = "Eval Math Lua", silent = true })
  map("x", "<leader>emp", ":PyMath<CR>", { desc = "Eval Math Python", silent = true })
end
