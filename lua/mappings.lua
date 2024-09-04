require "nvchad.mappings"

local map = vim.keymap.set

-- default mappings
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- personal mappings
map("n", "<tab>", "za")
map("n", "<leader>qs", "<CMD>wq<CR>", { desc = "Close file save" })
map("n", "<leader>qq", "<CMD>q<CR>", { desc = "Close file nosave" })
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fg", "<CMD>lua require('telescope.builtin').live_grep()<CR>", { desc = "Find word" })
map("n", "<leader>fb", "<CMD>lua require('telescope.builtin').buffers()<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<CMD>lua require('telescope.builtin').help_tags()<CR>", { desc = "Find help" })
map("n", "<leader>fk", "<CMD>lua require('telescope.builtin').keymaps()<CR>", { desc = "Find keymaps" })
map("v", "<leader>fk", "<CMD>lua require('telescope.builtin').keymaps()<CR>", { desc = "Find keymaps" })
map(
  "n",
  "<leader>fr",
  "<CMD>lua require('telescope').extensions.recent_files.pick()<CR>",
  { desc = "Find recent files" }
)
map("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
map("n", "<leader>pi", "<CMD>Lazy install<CR>", { desc = "Install plugins" })
map("n", "<leader>pu", "<CMD>Lazy update<CR>", { desc = "Update plugins" })
map("n", "<leader>pc", "<CMD>Lazy clean<CR>", { desc = "Clean plugins" })
map("n", "<leader>ps", "<CMD>Lazy sync<CR>", { desc = "Sync plugins" })
map("n", "<leader>pk", "<CMD>Lazy check<CR>", { desc = "Check plugins" })
map("n", "<leader>wh", "<C-W>h", { desc = "Switch to left window" })
map("n", "<leader>wl", "<C-W>l", { desc = "Switch to right window" })
map("n", "<leader>wj", "<C-W>j", { desc = "Switch to down window" })
map("n", "<leader>wk", "<C-W>k", { desc = "Switch to up window" })
map("n", "<leader>gg", "<CMD>Neogit<CR>", { desc = "Open Neogit" })

-- open commands
map("n", "<leader>gn", "<CMD>NvimTreeOpen ~/orgfiles/<CR>", { desc = "Open Notes" })
local conf_path = vim.fn.stdpath "config"
map("n", "<leader>gc", "<CMD>NvimTreeOpen " .. conf_path .. "<CR>", { desc = "Open Config" })
local data_path = vim.fn.stdpath "data"
map("n", "<leader>god", "<CMD>NvimTreeOpen " .. data_path .. "<CR>", { desc = "Open Nvim Data" })
map("n", "<leader>g.", "<CMD>NvimTreeOpen .<CR>", { desc = "Open Here" })
map("n", "<leader>gd", "<CMD>Dashboard<CR>", { desc = "Open Neogit" })

-- neorg dates
map("i", "<leader>id", "<Plug>(neorg.tempus.insert-date.insert-mode)", { desc = "Insert Date" })
map("n", "<leader>id", "<Plug>(neorg.tempus.insert-date)", { desc = "Insert Date" })

-- tab/window management
map("n", "<leader>tn", "<CMD>tab split<CR>", { desc = "Tab Split" })
map("n", "<leader>ts", "<CMD>tab split<CR>", { desc = "Tab Split" })
map("n", "<leader>tk", "<CMD>tab close<CR>", { desc = "Tab Close" })
map("n", "<leader>tl", "<CMD>tabnext<CR>", { desc = "Tab Next" })
map("n", "<leader>th", "<CMD>tabprevious<CR>", { desc = "Tab Previous" })
map("n", "<leader>wv", "<CMD>vsplit<CR>", { desc = "Window VSplit" })
map("n", "<leader>ws", "<CMD>split<CR>", { desc = "Window Split" })
map("n", "<leader>wk", "<CMD>close<CR>", { desc = "Window Kill" })
map("n", "<leader>wO", "<CMD>only<CR>", { desc = "Window Kill Others" })

-- make some mappings friendly to term
map("i", "<C-BS>", "<C-W>", { noremap = false, silent = true })
map("n", "<C-/>", "<C-_>", { noremap = false, silent = true })
map("v", "<C-/>", "<C-_>", { noremap = false, silent = true })
map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- remap nvchad tabs
map("n", "<leader>bh", function()
  require("nvchad.tabufline").prev()
end, { desc = "buffer goto prev" })

map("n", "<leader>bl", function()
  require("nvchad.tabufline").next()
end, { desc = "buffer goto next" })

map("n", "<leader>bk", function()
  require("nvchad.tabufline").close_buffer()
end, { desc = "buffer close" })

map("n", "<leader>bn", "<cmd>enew<CR>", { desc = "buffer new" })

-- add comment.nvim mappings
map("v", "<C-/>", "<Plug>(comment_toggle_linewise_visual)", { desc = "Toggle Comment (Visual)" })
map("n", "<C-/>", "<Plug>(comment_toggle_linewise_current)", { desc = "Toggle Comment" })

-- old mappings
map("n", "<C-p>", '<CMD>lua require"telescope.builtin".commands() <CR>', { desc = "Search commands" })
map("n", "<C-f>", "<CMD>Telescope live_grep<CR>", { desc = "Search files" })
