vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- session management
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,winsize,winpos,terminal"

-- Check for Firenvim and VSCode
if vim.g.started_by_firenvim or vim.g.vscode then
  _G.auto_session_enabled = false
else
  _G.auto_session_enabled = true
end

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

vim.notify = require "notify"

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

vim.notify "NvChad Loaded!"

local xdg_session = os.getenv "XDG_SESSION_TYPE"
local cmd_output = io.popen "wl-paste --list-types"
vim.notify(
  string.format(
    "wl-paste available: %d, xclip available: %d, OS: %s, cmd_output: %s",
    vim.fn.executable "wl-paste",
    vim.fn.executable "xclip",
    xdg_session,
    cmd_output[0]
  )
)
