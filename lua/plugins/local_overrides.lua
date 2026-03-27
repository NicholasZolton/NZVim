-- Reads local_config.json (gitignored) and disables plugins per-machine.
-- Example local_config.json:
-- { "disabled_plugins": ["yetone/avante.nvim", "zbirenbaum/copilot.lua"] }

local config_path = vim.fn.stdpath("config") .. "/local_config.json"
local f = io.open(config_path, "r")
if not f then
  return {}
end

local ok, config = pcall(vim.json.decode, f:read("*a"))
f:close()
if not ok or not config.disabled_plugins then
  return {}
end

local overrides = {}
for _, name in ipairs(config.disabled_plugins) do
  table.insert(overrides, { name, enabled = false })
end
return overrides
