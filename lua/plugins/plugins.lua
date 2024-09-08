local plugins = {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  { "ggandor/leap.nvim", commit = "c6bfb191f1161fbabace1f36f578a20ac6c7642c" },
  { "rasulomaroff/telepath.nvim", commit = "2879da05463db7bdc8824b13cccd8e8920c62a55" }, -- basically leap addon, needs leap to work
  { "tpope/vim-speeddating", commit = "c17eb01ebf5aaf766c53bab1f6592710e5ffb796" },
  { "tpope/vim-repeat", commit = "65846025c15494983dafe5e3b46c8f88ab2e9635" },
  { "nvim-lua/plenary.nvim", tag = "v0.1.4" },
  { "haya14busa/is.vim", commit = "d393cb346dcdf733fecd7bbfc45b70b8c05e9eb4" },
  { "github/copilot.vim", tag = "v1.39.0", lazy = false },
  { "BurntSushi/ripgrep", tag = "14.1.0" },
  { "sindrets/diffview.nvim", commit = "4516612fe98ff56ae0415a259ff6361a89419b0a" },
  {
    "NeogitOrg/neogit",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
    commit = "6af8fc6b03210d0ac99398f8eff27c5be7b2ba8a",
  },
  {
    "nvim-neorg/neorg",
    tag = "v9.1.1",
    lazy = false,
    opts = {
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/orgfiles",
            },
            default_workspace = "notes",
            index = "dashboard.norg",
          },
        },
        ["core.export"] = {}, -- Allows for the exporting of documents using the ":Neorg export file_path" command
        ["core.export.markdown"] = {}, -- Allows for the exporting of documents using the ":Neorg export file_path" command
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        }, -- Allows for the exporting of documents using the ":Neorg export file_path" command
        ["core.esupports.metagen"] = {
          config = {
            author = "NicholasZolton",
            type = "auto",
          },
        },
        ["core.integrations.nvim-cmp"] = {},
      },
    },
    dependencies = {
      { "nvim-lua/plenary.nvim" },
    },
  },
  {
    "numToStr/Comment.nvim",
    tag = "v0.8.0",
    lazy = false,
    opts = {},
  },
  {
    "nvimdev/dashboard-nvim",
    commit = "fabf5feec96185817c732d47d363f34034212685",
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
    commit = "d250c63aa13ead745e3a40f61fdd3470efde3923",
  },
  { "rcarriga/nvim-notify", tag = "v3.13.5" },
  {
    "goerz/jupytext.vim",
    commit = "ec8f337bd5799e16a02816d04b7c91b9555d79c2",
    lazy = false,
  },
  {
    "ahmedkhalf/project.nvim",
    commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb",
    lazy = "VeryLazy",
    config = function()
      require("project_nvim").setup {
        show_hidden = false,
      }
    end,
  },
  { "nvim-telescope/telescope-fzy-native.nvim", commit = "282f069504515eec762ab6d6c89903377252bf5b", lazy = false },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    commit = "c5a14e0550699a7db575805cdb9ddc969ba0f1f5",
  },
  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerRun", "OverseerToggle" },
    commit = "236e60cdac6410dd95ea5cecafdb801a304d6a41",
    config = function()
      require("overseer").setup()
    end,
  },
  { "mfussenegger/nvim-dap", tag = "0.8.0" },
  {
    "robitx/gp.nvim",
    config = function()
      local conf = require "configs.gpt"
      require("gp").setup(conf)
    end,
    tag = "v3.9.0",
    cmd = { "GpChatNew" },
  },
  {
    "3rd/image.nvim",
    -- Disable on Windows system
    cond = function()
      return vim.fn.has "win32" ~= 1
    end,
    dependencies = {
      "leafo/magick",
    },
    opts = {
      -- image.nvim config
    },
  },
  -- these are overrides (nvchad configures some of this already, we are just modifying it)
  {
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "nvchad.configs.telescope"
      conf.defaults.file_ignore_patterns = { ".git", "node_modules", ".venv" }
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
    end,
  },
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeOpen" },
    opts = function()
      local conf = require "nvchad.configs.nvimtree"
      conf.renderer.root_folder_label = true
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
      },
    },
    opts = function()
      local conf = require "nvchad.configs.cmp"
      local cmp = require "cmp"
      conf.mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<Tab>"] = cmp.mapping.confirm {
          behavior = cmp.ConfirmBehavior.Insert,
          select = true,
        },

        ["<C-j"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").expand_or_jumpable() then
            require("luasnip").expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources {
          { name = "path" },
          { name = "cmdline" },
        },
        matching = { disallow_symbol_nonprefix_matching = false },
      })

      return conf
    end,
  },
}

return plugins
