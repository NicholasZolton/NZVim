require "nvchad.mappings"

local map = vim.keymap.set

-- default mappings
map("i", "jk", "<ESC>")

-- personal remappings
map("n", "<tab>", "za")
map("n", "<leader>qs", "<CMD>wq<CR>", { desc = "Close file save" })
map("n", "<leader>qq", "<CMD>q<CR>", { desc = "Close file nosave" })
map("n", "<C-a>", "ggVG", { desc = "Select all" })

-- telescope mappings
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", { desc = "Find word" })
map("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>", { desc = "Find help" })
map("n", "<leader>fk", "<CMD>lua require('telescope.builtin').keymaps()<CR>", { desc = "Find keymaps" })
map("v", "<leader>fk", "<CMD>lua require('telescope.builtin').keymaps()<CR>", { desc = "Find keymaps" })
map("n", "<leader>fr", "<CMD>Telescope frecency<CR>", { desc = "Find recent files" })
map("n", "<leader>fc", '<CMD>lua require"telescope.builtin".commands()<CR>', { desc = "Find commands" })
map("n", "<leader>fp", "<CMD>Telescope projects<CR>", { desc = "Find projects" })
map("n", "<leader>fb", "<CMD>Telescope file_browser<CR>", { desc = "Find projects" })
map("n", "<leader>fs", "<CMD>lua require('telescope.builtin').treesitter()<CR>", { desc = "Find symbols" })
map("n", "<leader>fo", "<CMD>ObsidianSearch<CR>", { desc = "Find Obsidian", remap = true })

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
map("n", "<leader>gg", "<CMD>Neogit<CR>", { desc = "Open Neogit" })

-- neorg dates
map("n", "<leader>id", "<Plug>(neorg.tempus.insert-date)", { desc = "Insert Date" })

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
map("x", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle Comment (Visual)" })
map("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle Comment" })

-- leap mapping
map("n", "c", function()
  require("leap").leap { target_windows = { vim.api.nvim_get_current_win() } }
end)

-- gpt mappings
-- map("n", "<leader>ccn", "<CMD>GpChatNew vsplit<CR>", { desc = "Chat New" })
-- map("n", "<leader>ccr", "<CMD>GpChatRespond<CR>", { desc = "Chat Respond" })
-- map("n", "<leader>cct", "<CMD>GpChatToggle<CR>", { desc = "Chat Toggle" })
-- local chat_path = data_path .. "/gp/chats/"
-- map(
--   "n",
--   "<leader>ccf",
--   "<CMD>Telescope live_grep search_dirs=" .. chat_path .. " default_text=topic: <CR>",
--   { desc = "Chat Find" }
-- )
-- map("n", "<leader>ccd", "<CMD>GpChatDelete<CR>", { desc = "Chat Delete" })
-- map("n", "<leader>ccp", "<CMD>GpPopup<CR>", { desc = "Chat Popup" })
-- map("n", "<leader>cah", "<CMD>GpAgent<CR>", { desc = "Agent Help" })
-- map("n", "<leader>can", "<CMD>GpNextAgent<CR>", { desc = "Agent Next" })
-- map("x", "<leader>ccn", "<CMD>GpExplain vsplit<CR>", { desc = "Chat Selection" })

-- avante mappings
map("n", "<leader>ccn", "<CMD>AvanteChat<CR>", { desc = "Avante Chat" })
map("n", "<leader>cce", "<CMD>AvanteEdit<CR>", { desc = "Avante Edit" })
map("n", "<leader>cca", "<CMD>AvanteAsk<CR>", { desc = "Avante Ask" })

-- overseer mappings
map("n", "<leader>tr", "<CMD>OverseerRun<CR>", { desc = "Task Run" })
map("n", "<leader>tt", "<CMD>OverseerToggle<CR>", { desc = "Task Run" })

-- neorg mappings
map("n", "<CR>", "<Plug>(neorg.esupports.hop.hop-link)", { noremap = false, silent = true })
map("n", "<leader>md", "<Plug>(neorg.qol.todo-items.todo.task-done)", { desc = "Mark Task Done" })
map("n", "<leader>mu", "<Plug>(neorg.qol.todo-items.todo.task-undone)", { desc = "Mark Task Undone" })

-- window jump
map("n", "<leader>wj", "<cmd>lua require('nvim-window').pick()<cr>", { desc = "Window Jump to Window" })

--obsidian mappings
map("n", "<leader>op", "<cmd>ObsidianPasteImg<cr>", { desc = "Obsidian Paste Image" })

-- lsp mappings
map("n", "<S-d>", "<cmd>lua vim.diagnostic.open_float()<CR>", { desc = "Show Error", noremap = false })

-- map paste for command/terminal mode
map("c", "<C-v>", "substitute(getreg('+'), '\\n', '', 'g') .. ''", { noremap = true, silent = false, expr = true })
map("t", "<C-v>", "substitute(getreg('+'), '\\n', '', 'g') .. ''", { noremap = false, silent = false, expr = true })

-- map ctrl-backspace for terminal mode
map("t", "<C-BS>", "<C-W>", { noremap = false, silent = false })

-- map very magicness (basically default magic mode, quite hacky)
map("n", "/", "/\\v", { noremap = true })
-- map("c", "%s/", "s/\\v", { noremap = true })

-- map paste for insert mode
map("i", "<C-v>", "<C-r>+")

-- supermaven mappings
map("i", "<Tab>", require("supermaven-nvim.completion_preview").on_accept_suggestion, { noremap = true, silent = true })
map(
  "i",
  "<C-l>",
  require("supermaven-nvim.completion_preview").on_accept_suggestion_word,
  { noremap = true, silent = true }
)
map("i", "<C-e>", require("supermaven-nvim.completion_preview").on_dispose_inlay, { noremap = true, silent = true })

-- db mappings
map("n", "<leader>db", "<CMD>DBUIToggle<CR>", { desc = "DB Open" })

-- eval mappings
map("x", "<leader>el", ":EvalLua<CR>", { desc = "Eval Lua", silent = true })
map("x", "<leader>ep", ":PyBlock<CR>", { desc = "Eval Python (Linewise)", silent = true })
map("x", "<leader>eml", ":LuaMath<CR>", { desc = "Eval Math Lua", silent = true })
map("x", "<leader>emp", ":PyMath<CR>", { desc = "Eval Math Python", silent = true })

-- lspsaga mappings
map("n", "K", "<CMD>Lspsaga hover_doc<CR>", { desc = "Hover Doc", remap = true, silent = true })
map("n", "<leader>ra", "<CMD>Lspsaga lsp_rename ++project<CR>", { desc = "Rename", remap = true, silent = true })
map("n", "<C-.>", vim.lsp.buf.code_action, { desc = "Code Action", remap = true })
map(
  "n",
  "[e",
  '<CMD>lua require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }<CR>',
  { desc = "Prev Error" }
)
map(
  "n",
  "]e",
  '<CMD>lua require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }<CR>',
  { desc = "Next Error" }
)
map("n", "[d", '<CMD>lua require("lspsaga.diagnostic"):goto_prev()<CR>', { desc = "Prev Diagnostic", remap = true })
map("n", "]d", '<CMD>lua require("lspsaga.diagnostic"):goto_next()<CR>', { desc = "Next Diagnostic", remap = true })

-- remap scroll to add zz after
map(
  "n",
  "<C-u>",
  "<CMD>lua require('neoscroll').scroll(-0.8, { duration = 400 })<CR>",
  { noremap = false, silent = true }
)
map(
  "n",
  "<C-d>",
  "<CMD>lua require('neoscroll').scroll(0.8, { duration = 400 })<CR>",
  { noremap = false, silent = true }
)

-- oil mappings
map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

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

-- surround mappings
map("n", "Y", "<Plug>(nvim-surround-normal)", { desc = "Add Surround (Normal)", remap = true })
map("x", "Y", "<Plug>(nvim-surround-visual)", { desc = "Add Surround (Visual)", remap = true })
map("n", "C", "<Plug>(nvim-surround-change)", { desc = "Change Surround (Normal)", remap = true })
map("n", "X", "<Plug>(nvim-surround-delete)", { desc = "Delete Surround (Normal)", remap = true })
