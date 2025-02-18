local ENABLE_AI = true
local ENABLE_FUN = true
local plugins = {
  {
    "olimorris/codecompanion.nvim",
    enabled = ENABLE_AI,
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup {
        strategies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "copilot",
          },
        },
      }
    end,
  },
  {
    "yetone/avante.nvim",
    enabled = false,
    event = "VeryLazy",
    lazy = false,
    version = "*", -- set this to "*" if you want to always pull the latest change, false to update on release
    opts = {
      provider = "copilot", -- Recommend using Claude
    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        "zbirenbaum/copilot.lua",
        config = function()
          require("copilot").setup()
        end,
      },
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        event = "VeryLazy",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
  {
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
    "lervag/vimtex",
    ft = "tex",
    init = function()
      vim.g.vimtex_view_general_viewer = "okular"
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
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
    "direnv/direnv.vim",
    lazy = false,
    cond = function()
      return vim.fn.has "win32" ~= 1
    end,
  },
  {
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
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {}
    end,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- optional
      "nvim-tree/nvim-web-devicons", -- optional
    },
  },
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    opts = {},
    ft = "typescript",
  },
  {
    "stevearc/conform.nvim",
    version = "*",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  { "ggandor/leap.nvim" },
  { "rasulomaroff/telepath.nvim" }, -- basically leap addon, needs leap to work
  { "tpope/vim-speeddating" },
  { "tpope/vim-repeat" },
  { "nvim-lua/plenary.nvim" },
  { "haya14busa/is.vim" },
  {
    "supermaven-inc/supermaven-nvim",
    enabled = ENABLE_AI,
    opts = {
      disable_inline_completion = false, -- disables inline completion for use with cmp
      disable_keymaps = true, -- disables keymaps so you can set them yourself (see mappings.lua)
    },
  },
  { "BurntSushi/ripgrep", version = "*" },
  { "sindrets/diffview.nvim" },
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit", "NeogitCommit", "NeogitPush", "NeogitPull" },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
  },
  -- {
  --   "nvim-neorg/neorg",
  --   tag = "v9.1.1",
  --   lazy = false,
  --   opts = require "configs.neorg",
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim" },
  --   },
  -- },
  {
    "numToStr/Comment.nvim",
    version = "*",
    opts = {},
  },
  {
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
    "hrsh7th/cmp-cmdline",
  },
  { "rcarriga/nvim-notify", lazy = false, version = "*", opts = { background_colour = "#000000" } },
  {
    "goerz/jupytext.vim",
    event = "BufReadPre *.ipynb",
  },
  {
    "ahmedkhalf/project.nvim",
    lazy = "VeryLazy",
    config = function()
      require("project_nvim").setup {
        show_hidden = false,
      }
    end,
  },
  { "nvim-telescope/telescope-fzy-native.nvim", lazy = false },
  { "nvim-telescope/telescope-frecency.nvim" },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "stevearc/overseer.nvim",
    version = "*",
    cmd = { "OverseerRun", "OverseerToggle" },
    config = function()
      require("overseer").setup {
        templates = { "builtin", "run_file" },
      }
    end,
  },
  { "mfussenegger/nvim-dap", lazy = false },
  {
    "robitx/gp.nvim",
    enabled = false, -- avante supersedes
    lazy = "VeryLazy",
    config = function()
      local conf = require "configs.gpt"
      require("gp").setup(conf)
    end,
    cmd = { "GpChatNew", "GpChatRespond", "GpExplain" },
    version = "*",
  },
  {
    "3rd/image.nvim",
    -- Disable on Windows system
    lazy = false,
    cond = function()
      -- return false
      return vim.fn.has "win32" ~= 1
    end,
    opts = {},
    dependencies = {
      "leafo/magick",
    },
  },
  -- {
  --   "tadmccorkle/markdown.nvim",
  --   ft = "markdown",
  -- },
  {
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
    },
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    cond = false,
    lazy = "VeryLazy",
  },
  {
    "yorickpeterse/nvim-window",
    lazy = false,
    keys = {},
    config = true,
  },
  { "pteroctopus/faster.nvim", event = "BufReadPre" },
  {
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
    "nvim-telescope/telescope-ui-select.nvim",
    event = "VeryLazy",
  },
  {
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
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    opts = function()
      local conf = require "nvchad.configs.nvimtree"
      conf.renderer.root_folder_label = true
      conf.filters = { dotfiles = false, git_ignored = false }
      return conf
    end,
  },
  {
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
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "supermaven-inc/supermaven-nvim",
      },
    },
    opts = require "configs.cmpopts",
  },
  {
    "folke/which-key.nvim",
    enabled = true,
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
