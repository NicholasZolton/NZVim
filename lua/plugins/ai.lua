local ENABLE_AI = true

return {
  {
    "ravitemer/mcphub.nvim",
    cmd = { "MCPHub" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "bun add -g mcp-hub@latest",
    config = function()
      require("mcphub").setup()
    end,
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    version = false,
    cond = function()
      return not vim.g.vscode
    end,
    build = function()
      if vim.fn.has "win32" == 1 then
        return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      else
        return "make"
      end
    end,
    config = function()
      local cached_local_instructions = (function()
        local path = vim.fs.joinpath(vim.fn.stdpath "config", "prompts", "global_instructions.txt")
        local file = io.open(path, "r")
        if not file then
          return ""
        end
        local content = file:read "*a"
        file:close()
        return content
      end)()
      require("avante").setup {
        provider = "copilot",
        providers = {
          copilot = {
            model = "gpt-4.1",
          },
          acp_providers = {
            ["opencode"] = {
              command = "opencode",
              args = { "acp" },
            },
          },
          openai = {
            endpoint = "https://api.openai.com/v1",
            model = "gpt-5",
            timeout = 30000,
            extra_request_body = {
              temperature = 1,
              max_completion_tokens = 20480,
            },
          },
        },
        behaviour = {
          auto_suggestions = false,
          enable_cursor_planning_mode = true,
        },
        windows = {
          edit = {
            border = "rounded",
            start_insert = true,
          },
        },
        disabled_tools = {
          "web_search",
          "dispatch_agent",
        },
        system_prompt = function()
          local hub = require("mcphub").get_hub_instance()
          local mcp_prompt = hub and hub:get_active_servers_prompt() or ""
          local final_prompt = mcp_prompt .. "\n" .. cached_local_instructions
          return final_prompt
        end,
        custom_tools = function()
          return {
            require("mcphub.extensions.avante").mcp_tool(),
          }
        end,
      }
      vim.keymap.set("n", "<leader>ccn", "<CMD>AvanteChat<CR>", { desc = "Avante Chat" })
      vim.keymap.set("n", "<leader>cce", "<CMD>AvanteEdit<CR>", { desc = "Avante Edit" })
      vim.keymap.set("n", "<leader>cca", "<CMD>AvanteAsk<CR>", { desc = "Avante Ask" })
    end,
    cmd = { "AvanteChat", "AvanteEdit", "AvanteAsk" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "zbirenbaum/copilot.lua",
    server = {
      type = "binary",
    },
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {}
    end,
  },
  {
    "supermaven-inc/supermaven-nvim",
    enabled = ENABLE_AI and true,
    opts = {
      disable_inline_completion = false,
      disable_keymaps = true,
    },
    config = function(_, opts)
      require("supermaven-nvim").setup(opts)
      local preview = require "supermaven-nvim.completion_preview"
      vim.keymap.set("i", "<Tab>", preview.on_accept_suggestion, { noremap = true, silent = true })
      vim.keymap.set("i", "<C-l>", preview.on_accept_suggestion_word, { noremap = true, silent = true })
      vim.keymap.set("i", "<C-e>", preview.on_dispose_inlay, { noremap = true, silent = true })
    end,
  },
}
