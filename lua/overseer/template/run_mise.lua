local log = require "overseer.log"
local overseer = require "overseer"

---@param name string
---@return boolean
local function is_misefile(name)
  name = name:lower()
  return name == "mise.toml" or name == ".mise.toml"
end

---@param opts overseer.SearchParams
---@return nil|string
local function get_mise_file(opts)
  return vim.fs.find(is_misefile, { upward = true, path = opts.dir })[1]
end

---@type overseer.TemplateFileProvider
local provider = {
  cache_key = function(opts)
    return get_mise_file(opts)
  end,
  generator = function(opts, cb)
    if vim.fn.executable "mise" == 0 then
      return 'Command "mise" not found'
    end
    local misefile = get_mise_file(opts)
    if not misefile then
      return "No mise.toml found"
    end
    local cwd = vim.fs.dirname(misefile)
    local ret = {}
    overseer.builtin.system(
      { "mise", "tasks", "--json" },
      { cwd = cwd, text = true },
      vim.schedule_wrap(function(out)
        if out.code ~= 0 then
          cb(out.stderr or out.stdout or "Error running 'mise tasks'")
          return
        end
        local ok, data = pcall(vim.json.decode, out.stdout, { luanil = { object = true } })
        if not ok then
          log.error("mise produced invalid json: %s", out.stdout)
          cb(string.format("mise produced invalid json: %s", data))
          return
        end
        assert(data)
        for _, task in pairs(data) do
          table.insert(ret, {
            name = string.format("mise %s", task.name),
            desc = task.description ~= "" and task.description or nil,
            builder = function()
              return {
                cmd = { "mise", "run", task.name },
                cwd = cwd,
              }
            end,
          })
        end
        cb(ret)
      end)
    )
  end,
}

return provider
