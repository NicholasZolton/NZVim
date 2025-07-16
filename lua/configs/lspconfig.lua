-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- check for the servers in https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local servers = {
  -- "html",
  -- "cssls",
  -- "jsonls",
  -- "svelte",
  -- "astro",
  "biome",
  "clangd",
  "rnix",
  "pyright",
  "tflint",
  "tailwindcss",
  "gdscript",
  "harper_ls",
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  if lsp == "harper_ls" then
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
      filetypes = { "markdown", "txt" },
    }
  else
    lspconfig[lsp].setup {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    }
  end
end
