return {
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
    keys = {
      { "<leader>dv", "<CMD>DiffviewOpen<CR>", desc = "Open Diffview" },
    },
    config = function()
      require("diffview").setup {
        keymaps = {
          view = { { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Close Diffview" } } },
          file_panel = { { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Close Diffview" } } },
          file_history_panel = { { "n", "q", "<CMD>DiffviewClose<CR>", { desc = "Close Diffview" } } },
        },
      }

      local hl = vim.api.nvim_set_hl
      hl(0, "DiffAdd", { bg = "#1f3a2c" })
      hl(0, "DiffChange", { bg = "#1a2840" })
      hl(0, "DiffDelete", { fg = "#c94f6d", bg = "#3a1f2c" })
      hl(0, "DiffText", { bg = "#2a4a35" })
      hl(0, "DiffviewDiffDeleteDim", { bg = "#3d2230" })
      hl(0, "DiffviewDiffAddAsDelete", { bg = "#5c2d3e" })
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "NeogitOrg/neogit",
    cmd = { "Neogit", "NeogitCommit", "NeogitPush", "NeogitPull" },
    keys = {
      { "<leader>gg", "<CMD>Neogit<CR>", desc = "Open Neogit" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("neogit").setup()

      local hl = vim.api.nvim_set_hl
      hl(0, "NeogitDiffAdd", { fg = "#8ebaa4", bg = "#1a2e25" })
      hl(0, "NeogitDiffAddHighlight", { fg = "#a8d4be", bg = "#1f3a2c" })
      hl(0, "NeogitDiffDelete", { fg = "#c94f6d", bg = "#2e1a22" })
      hl(0, "NeogitDiffDeleteHighlight", { fg = "#e26886", bg = "#3a1f2c" })

      hl(0, "NeogitDiffAddCursor", { fg = "#a8d4be", bg = "#243d30" })
      hl(0, "NeogitDiffDeleteCursor", { fg = "#e26886", bg = "#3d2231" })
      hl(0, "NeogitDiffContextCursor", { fg = "#cdcecf", bg = "#2a2e33" })
      hl(0, "NeogitHunkHeaderCursor", { fg = "#71839b", bg = "#2a2e33" })
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    dir = "~/Documents/Projects/NeoJJ",
    cmd = { "Neojj" },
    keys = {
      { "<leader>gj", "<CMD>Neojj<CR>", desc = "Open Neojj" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("neojj").setup {
        filewatcher = {
          enabled = true,
          poll_interval = 500,
        },
        integrations = {
          telescope = false,
          fzf_lua = false,
          mini_pick = false,
          snacks = true,
          diffview = true,
        },
        sections = {
          recent = { folded = false },
          bookmarks = { folded = false },
        },
        workspace_open_command = "tmux new-window -c {path} 'mise trust && $SHELL'",
      }

      local hl = vim.api.nvim_set_hl
      hl(0, "NeojjDiffAdd", { fg = "#8ebaa4", bg = "#1a2e25" })
      hl(0, "NeojjDiffAddHighlight", { fg = "#a8d4be", bg = "#1f3a2c" })
      hl(0, "NeojjDiffDelete", { fg = "#c94f6d", bg = "#2e1a22" })
      hl(0, "NeojjDiffDeleteHighlight", { fg = "#e26886", bg = "#3a1f2c" })
      hl(0, "NeojjDiffAddCursor", { fg = "#a8d4be", bg = "#243d30" })
      hl(0, "NeojjDiffDeleteCursor", { fg = "#e26886", bg = "#3d2231" })
      hl(0, "NeojjDiffContextCursor", { fg = "#cdcecf", bg = "#2a2e33" })
      hl(0, "NeojjHunkHeaderCursor", { fg = "#71839b", bg = "#2a2e33" })
    end,
  },
}
