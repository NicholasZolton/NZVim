local output = {
  -- open_browser_app = "xdg-open-2", -- specify your browser app; default for macOS is "open", Linux "xdg-open" and Windows "powershell.exe"
  -- open_browser_args = { "1>/dev/null", "2>&1" }, -- specify any arguments, such as --background for macOS' "open".
  handlers = {
    plugin = true, -- open plugin links in lua (e.g. packer, lazy, ..)
    github = true, -- open github issues
    brewfile = true, -- open Homebrew formulaes and casks
    package_json = true, -- open dependencies from package.json
    search = true, -- search the web/selection on the web if nothing else is found
    go = true, -- open pkg.go.dev from an import statement (uses treesitter)
    jira = { -- custom handler to open Jira tickets (these have higher precedence than builtin handlers)
      name = "jira", -- set name of handler
      handle = function(mode, line, _)
        local ticket = require("gx.helper").find(line, mode, "(%u+-%d+)")
        if ticket and #ticket < 20 then
          return "http://jira.company.com/browse/" .. ticket
        end
      end,
    },
    rust = { -- custom handler to open rust's cargo packages
      name = "rust", -- set name of handler
      filetype = { "toml" }, -- you can also set the required filetype for this handler
      filename = "Cargo.toml", -- or the necessary filename
      handle = function(mode, line, _)
        local crate = require("gx.helper").find(line, mode, "(%w+)%s-=%s")

        if crate then
          return "https://crates.io/crates/" .. crate
        end
      end,
    },
  },
  handler_options = {
    search_engine = "bing", -- you can select between google, bing, duckduckgo, ecosia and yandex
    select_for_search = false, -- if your cursor is e.g. on a link, the pattern for the link AND for the word will always match. This disables this behaviour for default so that the link is opened without the select option for the word AND link
    git_remotes = { "upstream", "origin" }, -- list of git remotes to search for git issue linking, in priority
    git_remote_push = false, -- use the push url for git issue linking,
  },
}

if vim.fn.has "win32" ~= 1 then
  local file = io.open("/proc/version", "r")
  output.open_browser_app = "xdg-open-2"
  if file then
    local content = file:read "*all"
    file:close()
    if content:find "WSL" then
      output.open_browser_app = "wslview"
    end
  end
end

return output
