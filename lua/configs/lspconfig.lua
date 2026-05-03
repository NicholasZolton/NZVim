require("nvchad.configs.lspconfig").defaults()

local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  html = {},
  cssls = {},
  jsonls = {},
  vtsls = {},
  clangd = {},
  rnix = {},
  basedpyright = {},
  tflint = {},
  tailwindcss = {},
  gdscript = {},
  rust_analyzer = {},
  kotlin_lsp = {
    cmd = { vim.fn.stdpath "data" .. "/mason/bin/intellij-server", "--stdio" },
    filetypes = { "kotlin" },
    root_markers = { "build.gradle", "build.gradle.kts", "pom.xml", "mvnw", ".git" },
  },
  harper_ls = {
    filetypes = { "markdown", "txt" },
  },
}

for name, opts in pairs(servers) do
  opts.on_attach = nvlsp.on_attach
  opts.on_init = nvlsp.on_init
  opts.capabilities = nvlsp.capabilities
  vim.lsp.config(name, opts)
end

vim.lsp.enable(vim.tbl_keys(servers))
