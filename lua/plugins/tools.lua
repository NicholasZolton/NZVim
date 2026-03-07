return {
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    enabled = true,
    cond = not vim.g.vscode,
  },
  {
    "amitds1997/remote-nvim.nvim",
    cmd = { "RemoteStart", "RemoteStop", "RemoteInfo", "RemoteCleanup", "RemoteConfigDel", "RemoteLog" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
    cond = not vim.g.vscode,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "andythigpen/nvim-coverage",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("coverage").setup {
        auto_reload = true,
      }
      vim.keymap.set("n", "<leader>vc", ":Coverage<CR>", { desc = "View Coverage" })
      vim.keymap.set("n", "<leader>cs", ":CoverageSummary<CR>", { desc = "View Coverage Summary" })
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "christoomey/vim-tmux-navigator",
    lazy = false,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_view_general_viewer = "okular"
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0
      vim.keymap.set("n", "<leader>db", "<CMD>DBUIToggle<CR>", { desc = "DB Open" })
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "nvim-pack/nvim-spectre",
    cmd = { "Spectre" },
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("spectre").setup()
    end,
  },
  {
    enabled = true,
    "direnv/direnv.vim",
    lazy = false,
    cond = function()
      return vim.fn.has "win32" ~= 1 and not vim.g.vscode
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "stevearc/overseer.nvim",
    version = "*",
    cmd = { "OverseerRun", "OverseerToggle" },
    config = function()
      require("overseer").setup {
        templates = { "builtin", "run_file", "run_mise" },
      }
      vim.keymap.set("n", "<leader>tr", "<CMD>OverseerRun<CR>", { desc = "Task Run" })
      vim.keymap.set("n", "<leader>tt", "<CMD>OverseerToggle<CR>", { desc = "Task Toggle" })
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "mfussenegger/nvim-dap",
    lazy = false,
    config = function()
      require "configs.dap"
      vim.keymap.set("n", "<leader>dc", function()
        require("dap").continue()
      end, { desc = "Debug Continue" })
      vim.keymap.set("n", "<leader>so", function()
        require("dap").step_over()
      end, { desc = "Debug Step Over" })
      vim.keymap.set("n", "<leader>si", function()
        require("dap").step_into()
      end, { desc = "Debug Step Into" })
      vim.keymap.set("n", "<leader>st", function()
        require("dap").step_out()
      end, { desc = "Debug Step Out" })
      vim.keymap.set("n", "<Leader>bt", function()
        require("dap").toggle_breakpoint()
      end, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>dl", function()
        require("dap").run_last()
      end, { desc = "Run Last Debug" })
      vim.keymap.set({ "n", "v" }, "<Leader>dh", function()
        require("dap.ui.widgets").hover()
      end, { desc = "Debug Hover" })
      vim.keymap.set({ "n", "v" }, "<Leader>dp", function()
        require("dap.ui.widgets").preview()
      end, { desc = "Debug Preview" })
    end,
    dependencies = {
      "mfussenegger/nvim-dap-python",
      "rcarriga/nvim-dap-ui",
    },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = { "nvim-neotest/nvim-nio" },
    config = function()
      require("dapui").setup()

      local dap, dapui = require "dap", require "dapui"

      vim.keymap.set("n", "<leader>do", function()
        dapui.toggle()
      end, { desc = "Debug Open" })

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "goerz/jupytext.vim",
    event = "BufReadPre *.ipynb",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "ahmedkhalf/project.nvim",
    lazy = "VeryLazy",
    config = function()
      require("project_nvim").setup {
        show_hidden = false,
        detection_methods = { "pattern" },
        patterns = { "!^.git", "!^.hg", ".git", ".hg", "Makefile" },
      }
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "BurntSushi/ripgrep",
    version = "*",
  },
  {
    enabled = false,
    cond = not vim.g.vscode,
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = function()
            if vim.fn.has "win32" ~= 1 then
              return vim.fn.expand "~" .. "/Documents/Projects/ObsidianVault"
            else
              return vim.fn.expand "~" .. "\\Documents\\Projects\\ObsidianVault"
            end
          end,
        },
      },
      daily_notes = {
        folder = "PeriodicNotes/DailyNotes",
        date_format = "%Y-%m-%d",
        default_tags = { "daily-notes" },
        template = "DailyTemplate.md",
      },
      completion = {
        nvim_cmp = true,
      },
      mappings = {},
      preferred_link_style = "wiki",
      disable_frontmatter = false,
      templates = {
        folder = "Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
      },
      use_advanced_uri = true,
      open_app_foreground = true,
      picker = {
        name = "telescope.nvim",
        note_mappings = {},
        tag_mappings = {},
      },
      sort_by = "modified",
      sort_reversed = true,
      search_max_lines = 1000,
      ---@return string
      image_name_func = function()
        return string.format("%s", os.time())
      end,
      open_notes_in = "current",
      attachments = {
        img_folder = "Assets/imgs",
        confirm_img_paste = false,
      },
      ui = {
        enable = false,
      },
    },
    config = function(_, opts)
      require("obsidian").setup(opts)
      Snacks.keymap.set("n", "<leader>fo", "<CMD>ObsidianSearch<CR>", { desc = "Find Obsidian", remap = true, ft = "markdown" })
      Snacks.keymap.set("n", "<leader>op", "<cmd>ObsidianPasteImg<cr>", { desc = "Obsidian Paste Image", ft = "markdown" })
    end,
  },
}
