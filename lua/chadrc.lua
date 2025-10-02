-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "blossom_light",

  -- hl_override = {
  -- 	Comment = { italic = true },
  -- 	["@comment"] = { italic = true },
  -- },
}

M.mason = {
  cmd = true,
  pkgs = {
    "ruff",
    "ruff-lsp",
    "stylua",
    "lua-language-server",
    "jdtls",
    "css-lsp",
    "html-lsp",
    "clang-format",
    "clangd",
    "prettier",
    "pyright",
    "rnix-lsp",
    "svelte-language-server",
  },
}

return M
