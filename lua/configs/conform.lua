local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    python = { "ruff_format" },
    cpp = { "clang-format" },
    sql = { "sleek" },
    terraform = { "terraform" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },

  formatters = {
    terraform = {
      command = "terraform",
      args = { "fmt", "$FILENAME" },
      stdin = false,
    },
  },
}

return options
