local ENABLE_AI = true
local map = vim.keymap.set

local plugins = {
  {
    "amitds1997/remote-nvim.nvim",
    cmd = { "RemoteStart", "RemoteStop", "RemoteInfo", "RemoteCleanup", "RemoteConfigDel", "RemoteLog" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- For standard functions
      "MunifTanjim/nui.nvim", -- To build the plugin UI
      "nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
    },
    opts = {
      ssh_config = {
        scp_binary = "rsync --perms --chmod=u+rwx,g+rwx,o+rwx",
      },
    },
    config = true,
    cond = not vim.g.vscode,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = false,
    enabled = true,
    cond = not vim.g.vscode,
  },
  {
    "stevearc/dressing.nvim",
    lazy = false,
    enabled = true,
    cond = not vim.g.vscode,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "MunifTanjim/nui.nvim",
    lazy = false,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    -- Make sure to set this up properly if you have lazy=true
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    opts = {
      file_types = { "markdown", "Avante", "CodeCompanion" },
    },
    ft = { "markdown", "Avante", "CodeCompanion" },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    ft = "java",
    "mfussenegger/nvim-jdtls",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        "lazy.nvim",
      },
    },
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
    "yetone/avante.nvim",
    enabled = true,
    event = "VeryLazy",
    version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
    cond = function()
      return not vim.g.vscode
    end,
    build = function()
      -- conditionally use the correct build system for the current OS
      if vim.fn.has "win32" == 1 then
        return "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      else
        return "make"
      end
    end,
    ---@module 'avante'
    ---@type avante.Config
    opts = {
      provider = "copilot", -- Recommend using Claude
      providers = {
        copilot = {
          model = "gpt-4.1",
        },
      },
      behaviour = {
        auto_suggestions = false,
        enable_cursor_planning_mode = true,
      },
      windows = {
        edit = {
          border = "rounded",
          start_insert = true, -- Start insert mode when opening the edit window
        },
      },
    },
    config = function(_, opts)
      require("avante").setup(opts)
      vim.keymap.set("n", "<leader>ccn", "<CMD>AvanteChat<CR>", { desc = "Avante Chat" })
      vim.keymap.set("n", "<leader>cce", "<CMD>AvanteEdit<CR>", { desc = "Avante Edit" })
      vim.keymap.set("n", "<leader>cca", "<CMD>AvanteAsk<CR>", { desc = "Avante Ask" })
    end,
    cmd = { "AvanteChat", "AvanteEdit", "AvanteAsk" },
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      {
        "zbirenbaum/copilot.lua",
        config = function()
          require("copilot").setup()
        end,
      },
    },
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
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_execute_on_save = 0 --disable auto-execution on save
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "stevearc/oil.nvim",
    version = "*",
    cmd = { "Oil" },
    config = function()
      -- Declare a global function to retrieve the current directory
      function _G.get_oil_winbar()
        local dir = require("oil").get_current_dir()
        if dir then
          return vim.fn.fnamemodify(dir, ":~")
        else
          -- If there is no current directory (e.g. over ssh), just show the buffer name
          return vim.api.nvim_buf_get_name(0)
        end
      end

      local opts = require "configs.oilopts"
      require("oil").setup(opts)
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
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
    "karb94/neoscroll.nvim",
    event = "BufReadPre *",
    config = function()
      require("neoscroll").setup {
        mappings = {},
        easing = "quadratic",
      }
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "nvimdev/lspsaga.nvim",
    opts = {
      finder = {
        keys = {
          toggle_or_open = "<CR>",
          quit = "<ESC>",
        },
      },
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)
      map("n", "K", "<CMD>Lspsaga hover_doc<CR>", { desc = "Hover Doc", remap = true, silent = true })
      map("n", "<leader>ra", "<CMD>Lspsaga lsp_rename ++project<CR>", { desc = "Rename", remap = true, silent = true })
      map("n", "<leader>ca", "<CMD>Lspsaga code_action<CR>", { desc = "Code Action", remap = true })
      map("n", "<C-.>", "<CMD>Lspsaga code_action<CR>", { desc = "Code Action", remap = true })
      map("n", "<C-]>", "<CMD>Lspsaga finder<CR>", { desc = "Code Action", remap = true })
      map(
        "n",
        "[e",
        '<CMD>lua require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }<CR>',
        { desc = "Prev Error" }
      )
      map(
        "n",
        "]e",
        '<CMD>lua require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }<CR>',
        { desc = "Next Error" }
      )
      map(
        "n",
        "[d",
        '<CMD>lua require("lspsaga.diagnostic"):goto_prev()<CR>',
        { desc = "Prev Diagnostic", remap = true }
      )
      map(
        "n",
        "]d",
        '<CMD>lua require("lspsaga.diagnostic"):goto_next()<CR>',
        { desc = "Next Diagnostic", remap = true }
      )
    end,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
  -- {
  -- enabled = true,
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  --   ft = "typescript",
  -- },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "stevearc/conform.nvim",
    version = "*",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "ggandor/leap.nvim",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "rasulomaroff/telepath.nvim",
  }, -- basically leap addon, needs leap to work
  {
    enabled = true,
    cond = not vim.g.vscode,
    "tpope/vim-speeddating",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "tpope/vim-repeat",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "nvim-lua/plenary.nvim",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "haya14busa/is.vim",
  },
  {
    "supermaven-inc/supermaven-nvim",
    enabled = ENABLE_AI and true,
    opts = {
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = true, -- disables keymaps so you can set them yourself (see mappings.lua)
    },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "BurntSushi/ripgrep",
    version = "*",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewFileHistory",
      "DiffviewFocusFiles",
      "DiffviewToggleFiles",
      "DiffviewRefresh",
    },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "NeogitOrg/neogit",
    cmd = { "Neogit", "NeogitCommit", "NeogitPush", "NeogitPull" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
  },
  -- {
  -- enabled = true,
  --   "nvim-neorg/neorg",
  --   tag = "v9.1.1",
  --   lazy = false,
  --   opts = require "configs.neorg",
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim" },
  --   },
  -- },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "numToStr/Comment.nvim",
    version = "*",
    opts = {},
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    config = function()
      if vim.g.vscode then
        print "vscode!"
      else
        require("dashboard").setup {
          theme = "hyper",
          config = {
            week_header = {
              enable = true,
            },
            packages = { enable = true },
            project = { enable = true, limit = 8, icon = "", label = "", cwd_only = false },
            mru = { limit = 5 },
            footer = {},
            disable_move = false,
          },
        }
      end
    end,
    dependencies = { { "nvim-tree/nvim-web-devicons" } },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "hrsh7th/cmp-cmdline",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "rcarriga/nvim-notify",
    lazy = false,
    version = "*",
    opts = { background_colour = "#000000" },
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
    "nvim-telescope/telescope-fzy-native.nvim",
    lazy = false,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "nvim-telescope/telescope-frecency.nvim",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "stevearc/overseer.nvim",
    version = "*",
    cmd = { "OverseerRun", "OverseerToggle" },
    config = function()
      require("overseer").setup {
        templates = { "builtin", "run_file" },
      }
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
    "3rd/image.nvim",
    -- Disable on Windows system
    lazy = false,
    cond = function()
      -- return false
      return vim.fn.has "win32" ~= 1 and not vim.g.vscode
    end,
    opts = {},
    dependencies = {
      "leafo/magick",
    },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = {
      -- Required.
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
      -- see below for full list of options 👇
      daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "PeriodicNotes/DailyNotes",
        -- Optional, if you want to change the date format for the ID of daily notes.
        date_format = "%Y-%m-%d",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
        -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
        template = "DailyTemplate.md",
      },
      -- Optional, completion of wiki links, local markdown links, and tags using nvim-cmp.
      completion = {
        nvim_cmp = true,
      },

      -- Optional, configure key mappings. These are the defaults. If you don't want to set any keymappings this
      -- way then set 'mappings = {}'.
      mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        -- ["gf"] = {
        --   action = function()
        --     return require("obsidian").util.gf_passthrough()
        --   end,
        --   opts = { noremap = false, expr = true, buffer = true },
        -- },
      },

      -- Either 'wiki' or 'markdown'.
      preferred_link_style = "wiki",

      -- Optional, boolean or a function that takes a filename and returns a boolean.
      -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
      disable_frontmatter = false,

      -- Optional, for templates (see below).
      templates = {
        folder = "Templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
      },

      -- Optional, set to true if you use the Obsidian Advanced URI plugin.
      -- https://github.com/Vinzent03/obsidian-advanced-uri
      use_advanced_uri = true,
      -- Optional, set to true to force ':ObsidianOpen' to bring the app to the foreground.
      open_app_foreground = true,
      picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {},
        tag_mappings = {},
      },
      -- Optional, sort search results by "path", "modified", "accessed", or "created".
      -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
      -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
      sort_by = "modified",
      sort_reversed = true,

      -- Set the maximum number of lines to read from notes on disk when performing certain searches.
      search_max_lines = 1000,

      -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
      ---@return string
      image_name_func = function()
        return string.format("%s", os.time())
      end,

      -- Optional, determines how certain commands open notes. The valid options are:
      -- 1. "current" (the default) - to always open in the current window
      -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
      -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
      open_notes_in = "current",

      -- Specify how to handle attachments.
      attachments = {
        img_folder = "Assets/imgs", -- This is the default
        confirm_img_paste = false,
      },

      ui = {
        enable = false,
      },
    },
  },
  {
    enabled = true,
    "nvim-treesitter/nvim-treesitter-context",
    cond = false,
    lazy = "VeryLazy",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "yorickpeterse/nvim-window",
    lazy = false,
    keys = {},
    config = true,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "pteroctopus/faster.nvim",
    event = "BufReadPre",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    -- cond = function()
    --   return vim.fn.has "win32" ~= 1
    -- end,
    init = function()
      vim.g.netrw_nogx = 1 -- disable netrw gx
    end,
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required for Neovim < 0.10.0
    -- you can specify also another config if you want
    config = function()
      local opts = require "configs.gxopen"
      require("gx").setup(opts)
    end,
    submodules = false, -- not needed, submodules are required only for tests
  },
  -- {
  -- enabled = true,
  --   "kndndrj/nvim-dbee",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  --   build = function()
  --     -- Install tries to automatically detect the install method.
  --     -- if it fails, try calling it with one of these parameters:
  --     --    "curl", "wget", "bitsadmin", "go"
  --     require("dbee").install()
  --   end,
  --   config = function()
  --     require("dbee").setup(--[[optional config]])
  --   end,
  -- },
  -- these are overrides (nvchad configures some of this already, we are just modifying it)
  {
    enabled = true,
    cond = not vim.g.vscode,
    "nvim-treesitter/nvim-treesitter",
    lazy = true,
    config = function()
      local opts = require "configs.custom-treesitter"
      require("nvim-treesitter.configs").setup(opts)
    end,
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        config = function()
          local options = require "configs.treesitter-textobjects"
          require("nvim-treesitter.configs").setup(options)
          -- map repeats for textobjects
          local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

          -- vim way: ; goes to the direction you were moving.
          vim.keymap.set({ "n", "x", "o" }, "'", ts_repeat_move.repeat_last_move)
          vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_opposite)
          vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
          vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
          vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
          vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end,
      },
    },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "nvchad.configs.telescope"
      local actions = require "telescope.actions"
      conf.defaults.file_ignore_patterns = { ".git", "node_modules", ".venv" }
      conf.defaults.mappings.i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-v>"] = false,
      }
      return conf
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

      -- load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
      require("telescope").load_extension "projects"
      require("telescope").load_extension "fzy_native"
      require("telescope").load_extension "file_browser"
      require("telescope").load_extension "frecency"
      require("telescope").load_extension "ui-select"
    end,
    event = "VeryLazy",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    opts = function()
      local conf = require "nvchad.configs.nvimtree"
      conf.renderer.root_folder_label = true
      conf.filters = { dotfiles = false, git_ignored = false }
      return conf
    end,
  },
  -- {
  -- enabled = true,
  --   "saghen/blink.cmp",
  --   enabled = true,
  --   build = "cargo build --release",
  --   event = "InsertEnter",
  --   dependencies = {
  --     {
  --       -- snippet plugin
  --       "L3MON4D3/LuaSnip",
  --       dependencies = "rafamadriz/friendly-snippets",
  --       opts = { history = true, updateevents = "TextChanged,TextChangedI" },
  --       config = function(_, opts)
  --         require("luasnip").config.set_config(opts)
  --         require "nvchad.configs.luasnip"
  --       end,
  --     },
  --   },
  --
  --   ---@module 'blink.cmp'
  --   ---@type blink.cmp.Config
  --   opts = {
  --     keymap = {
  --       preset = "none",
  --
  --       ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
  --       ["<C-e>"] = { "hide" },
  --       ["<Tab>"] = { "select_and_accept", "fallback" },
  --
  --       ["<Up>"] = { "select_prev", "fallback" },
  --       ["<Down>"] = { "select_next", "fallback" },
  --
  --       ["<C-k>"] = { "select_prev", "fallback_to_mappings" },
  --       ["<C-j>"] = { "select_next", "fallback_to_mappings" },
  --
  --       ["<C-b>"] = { "scroll_documentation_up", "fallback" },
  --       ["<C-f>"] = { "scroll_documentation_down", "fallback" },
  --     },
  --
  --     snippets = { preset = "luasnip" },
  --
  --     appearance = {
  --       -- Sets the fallback highlight groups to nvim-cmp's highlight groups
  --       -- Useful for when your theme doesn't support blink.cmp
  --       -- Will be removed in a future release
  --       use_nvim_cmp_as_default = true,
  --       -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
  --       -- Adjusts spacing to ensure icons are aligned
  --       nerd_font_variant = "mono",
  --     },
  --
  --     sources = {
  --       default = { "snippets", "lsp", "path", "buffer" },
  --     },
  --
  --     fuzzy = { implementation = "rust" },
  --
  --     cmdline = {
  --       keymap = {
  --         -- recommended, as the default keymap will only show and select the next item
  --         ["<Tab>"] = { "show", "accept" },
  --       },
  --       completion = {
  --         menu = { auto_show = true },
  --       },
  --     },
  --
  --     completion = {
  --
  --       keyword = { range = "full" },
  --
  --       accept = { auto_brackets = { enabled = true,
  --
  --       menu = {
  --         -- Don't automatically show the completion menu
  --         auto_show = true,
  --
  --         -- nvim-cmp style menu
  --         -- draw = {
  --         --   columns = {
  --         --     { "label", "label_description", gap = 1 },
  --         --     { "kind_icon", "kind" },
  --         --   },
  --         -- },
  --       },
  --       documentation = { auto_show = true, auto_show_delay_ms = 100 },
  --     },
  --   },
  --   opts_extend = { "sources.default" },
  -- },
  -- {
  --   "windwp/nvim-autopairs",
  --   event = "InsertEnter",
  --   opts = {
  --     fast_wrap = {},
  --     disable_filetype = { "TelescopePrompt", "vim" },
  --   },
  --   config = function(_, opts)
  --     require("nvim-autopairs").setup(opts)
  --   end,
  -- },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "nvchad.configs.luasnip"
          require "lua_snippets.snippets"
        end,
      },

      -- autopairing of (){}[] etc
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
      },

      -- cmp sources plugins
      {
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "saadparwaiz1/cmp_luasnip" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
      },
    },
    opts = require "configs.cmpopts",
  },
  {
    enabled = true,
    "folke/which-key.nvim",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    lazy = false,
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "whichkey")
      require("which-key").setup(opts)
    end,
  },
}

return plugins
