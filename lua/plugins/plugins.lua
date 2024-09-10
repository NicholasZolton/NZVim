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
    opts = require "configs.neorg",
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
    lazy = "VeryLazy",
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
    ft = { "markdown", "md" },
    cond = function()
      return false
      -- return vim.fn.has "win32" ~= 1
    end,
    dependencies = {
      "leafo/magick",
    },
    opts = {
      backend = "kitty",
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
        },
        neorg = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "norg" },
        },
        html = {
          enabled = false,
        },
        css = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = nil,
      max_height_window_percentage = 50,
      window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
      tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
    },
  },
  {
    "rmagatti/auto-session",
    commit = "a90aa7730efa60fdcc7e00497a8f36d94a6da709",
    lazy = false,
    opts = function()
      local home_dir = vim.fn.expand "~"
      return { suppressed_dirs = { home_dir } }
    end,
    config = function()
      require("auto-session").setup {
        auto_session_root_dir = vim.fn.stdpath "data" .. "/sessions/",
      }
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "epwalsh/obsidian.nvim",
    tag = "v3.9.0", -- recommended, use latest release instead of latest commit
    lazy = true,
    cond = function()
      return vim.fn.isdirectory(vim.fn.expand "~" .. "/Documents/Projects/ObsidianVault")
    end,
    event = function()
      local vault_path = vim.fn.expand "~" .. "/Documents/Projects/ObsidianVault"
      return {
        "BufReadPre " .. vault_path .. "/*.md",
        "BufNewFile " .. vault_path .. "/*.md",
      }
    end,
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",

      -- see below for full list of optional dependencies 👇
    },
    opts = {
      workspaces = {
        {
          name = "personal",
          path = function()
            return vim.fn.expand "~" .. "/Documents/Projects/ObsidianVault"
          end,
        },
      },
      -- see below for full list of options 👇
      log_level = vim.log.levels.INFO,
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
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true },
        },
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

      -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
      -- URL it will be ignored but you can customize this behavior here.
      ---@param url string
      follow_url_func = function(url)
        -- Open the URL in the default web browser.
        -- vim.fn.jobstart({"open", url})  -- Mac OS
        -- vim.fn.jobstart({"xdg-open", url})  -- linux
        -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
        vim.ui.open(url) -- need Neovim 0.10.0+
      end,
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
        note_mappings = {
          -- Create a new note from your query.
          new = "<C-x>",
          -- Insert a link to the selected note.
          insert_link = "<C-l>",
        },
        tag_mappings = {
          -- Add tag(s) to current note.
          tag_note = "<C-x>",
          -- Insert a tag at the current location.
          insert_tag = "<C-l>",
        },
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
  { "nvim-treesitter/nvim-treesitter-context", commit = "895ec44f5c89bc67ba5440aef3d1f2efa3d59a41" },
  {
    "michaelb/sniprun",
    tag = "v1.3.15",
    cond = function()
      return vim.fn.has "win32" ~= 1
    end,
    cmd = { "SnipRun", "SnipReset", "SnipInfo" },
    config = function()
      require("sniprun").setup {
        display = { "Terminal" },
      }
    end,
    mappings = {},
  },
  {
    "yorickpeterse/nvim-window",
    lazy = false,
    commit = "81f29840ac3aaeea6fc2153edfabebd00d692476",
    keys = {},
    config = true,
  },
  -- these are overrides (nvchad configures some of this already, we are just modifying it)
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      local conf = require "nvchad.configs.treesitter"
      conf.highlight.additional_vim_regex_highlighting = { "markdown", "markdown_inline" }
      return conf
    end,
  },
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
