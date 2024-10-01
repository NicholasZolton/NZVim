-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE - default server setups
local servers = { "html", "cssls", "jdtls", "clangd" } -- ruff and pyright below
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- -- some credit to https://github.com/neovim/nvim-lspconfig/issues/500, adjusted for cross-platform
-- local util = require "lspconfig/util"
-- local path = util.path
--
-- local function get_python_path(workspace)
--   if vim.fn.has "win32" == 1 then
--     -- use activated virtualenv on windows
--     if vim.env.VIRTUAL_ENV then
--       print("Using activated virtualenv", vim.env.VIRTUAL_ENV)
--       return path.join(vim.env.VIRTUAL_ENV, "Scripts", "python.exe")
--     end
--
--     -- find and use virtualenv in workspace directory
--     for _, pattern in ipairs { "*", ".*" } do
--       local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
--       if match ~= "" then
--         print("Using workspace virtualenv", path.dirname(match))
--         return path.join(path.dirname(match), "Scripts", "python.exe")
--       end
--     end
--
--     -- fallback to system python
--     print "Using system python"
--     return "python"
--   else
--     -- Use activated virtualenv.
--     if vim.env.VIRTUAL_ENV then
--       print("Using activated virtualenv", vim.env.VIRTUAL_ENV)
--       return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
--     end
--
--     -- Find and use virtualenv in workspace directory.
--     for _, pattern in ipairs { "*", ".*" } do
--       local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
--       if match ~= "" then
--         print("Using workspace virtualenv", path.dirname(match))
--         return path.join(path.dirname(match), "bin", "python")
--       end
--     end
--
--     -- Fallback to system Python.
--     print "Using system python"
--     return "python3"
--   end
-- end

lspconfig.pyright.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  -- before_init = function(_, config)
  --   config.settings.python.pythonPath = get_python_path(config.root_dir)
  -- end,
  -- settings = {
  --   pyright = {
  --     -- Using Ruff's import organizer
  --     disableOrganizeImports = true,
  --   },
  --   python = {
  --     analysis = {
  --       -- Ignore all files for analysis to exclusively use Ruff for linting
  --       ignore = { "*" },
  --     },
  --   },
  -- },
}

-- lspconfig.ruff.setup {
--   on_attach = function(client, _)
--     if client.name == "ruff" then
--       client.server_capabilities.hoverProvider = false
--     end
--   end,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
