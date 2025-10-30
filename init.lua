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

if vim.g.vscode then
  vim.notify = require("vscode").notify
else
  vim.notify = require "notify"
end

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"
require "functions"

vim.schedule(function()
  require "mappings"
end)

vim.opt.conceallevel = 2
vim.opt.clipboard = "unnamedplus"

-- Prepend mise shims to PATH
vim.env.PATH = vim.env.HOME .. "/.local/share/mise/shims:" .. vim.env.PATH
