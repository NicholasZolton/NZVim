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
    "svelte",
  },

  markdown = {
    enable = true,
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },

  -- incremental_selection = {
  --   enable = true,
  --   keymaps = {
  --     init_selection = "<C-i>",
  --     node_incremental = "<C-i>",
  --     scope_incremental = false,
  --     node_decremental = "<bs>",
  --   },
  -- },
}

return options
