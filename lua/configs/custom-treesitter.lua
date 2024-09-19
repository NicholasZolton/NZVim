pcall(function()
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "treesitter")
end)

local options = {
  ensure_installed = {
    "lua",
    "luadoc",
    "printf",
    "vim",
    "vimdoc",
    "python",
    "java",
    "markdown",
    "markdown_inline",
    "cpp",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<C-n>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
}
