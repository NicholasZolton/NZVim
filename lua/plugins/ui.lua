return {
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
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    opts = {
      file_types = { "markdown", "Avante", "CodeCompanion" },
    },
    ft = { "markdown", "Avante", "CodeCompanion" },
  },
  { "nvimdev/dashboard-nvim", enabled = false },
  { "rcarriga/nvim-notify", enabled = false },
  {
    enabled = true,
    "3rd/image.nvim",
    lazy = false,
    cond = function()
      return vim.fn.has "win32" ~= 1 and not vim.g.vscode
    end,
    opts = {},
    dependencies = {
      "leafo/magick",
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
          local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

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
    "nvim-telescope/telescope.nvim",
    opts = function()
      local conf = require "nvchad.configs.telescope"
      local actions = require "telescope.actions"
      conf.defaults.file_ignore_patterns = {
        ".git/",
        "node_modules",
        ".venv",
        "%_snapshot.json",
        "bun.lock",
        "package-lock.json",
        ".llm-docs",
        ".ruff_cache",
        "__pycache__",
        "%.pyc",
        "dist/",
        "build/",
        "%.min%.js",
        "%.min%.css",
        "target/",
        "%.class",
        "coverage/",
        "yarn.lock",
        "pnpm%-lock.yaml",
        ".next/",
        ".nuxt/",
        ".cache/",
        "%.DS_Store",
        "logs.log",
        "%_tabular_2025.xml",
      }
      conf.defaults.mappings.i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-v>"] = false,
      }
      conf.pickers = conf.pickers or {}
      conf.pickers.find_files = { no_ignore = true }
      return conf
    end,
    config = function(_, opts)
      local telescope = require "telescope"
      telescope.setup(opts)

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
