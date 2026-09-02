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

      local function apply_diff_hl()
        local hl = vim.api.nvim_set_hl
        hl(0, "DiffAdd", { bg = "#1f3a2c" })
        hl(0, "DiffChange", { bg = "#1a2840" })
        hl(0, "DiffDelete", { fg = "#5a3a44", bg = "#3a1f2c" })
        hl(0, "DiffText", { bg = "#2a4a35" })
        hl(0, "DiffviewDiffDeleteDim", { bg = "#3d2230" })
        hl(0, "DiffviewDiffAddAsDelete", { bg = "#5c2d3e" })
      end
      apply_diff_hl()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DiffviewDiffBufWinEnter",
        callback = apply_diff_hl,
      })
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
      hl(0, "NeogitDiffAdd", { bg = "#1a2e25" })
      hl(0, "NeogitDiffAddHighlight", { bg = "#1f3a2c" })
      hl(0, "NeogitDiffDelete", { bg = "#2e1a22" })
      hl(0, "NeogitDiffDeleteHighlight", { bg = "#3a1f2c" })

      hl(0, "NeogitDiffAddCursor", { bg = "#243d30" })
      hl(0, "NeogitDiffDeleteCursor", { bg = "#3d2231" })
      hl(0, "NeogitDiffContextCursor", { bg = "#2a2e33" })
      hl(0, "NeogitHunkHeaderCursor", { bg = "#2a2e33" })
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
      local function tmux(args)
        local argv = { "tmux" }
        for _, a in ipairs(args) do
          table.insert(argv, a)
        end
        local r = vim.system(argv, { text = true }):wait()
        return r.stdout and vim.trim(r.stdout) or ""
      end

      local function in_tmux()
        return vim.env.TMUX ~= nil and vim.env.TMUX ~= ""
      end

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

        workspace_initialize_command = function(ctx)
          vim.system({ "jj", "git", "fetch" }, { cwd = ctx.path }):wait()
          vim.system({ "jj", "new", "trunk()" }, { cwd = ctx.path }):wait()
        end,

        workspace_open_command = function(ctx)
          if not in_tmux() then
            vim.notify("neojj: not inside tmux, skipping workspace window", vim.log.levels.WARN)
            return
          end

          local name = vim.fn.fnamemodify(ctx.path:gsub("/$", ""), ":t")
          if name == "" then
            name = "workspace"
          end

          local win_id = tmux {
            "new-window",
            "-n",
            name,
            "-c",
            ctx.path,
            "-P",
            "-F",
            "#{window_id}",
            "nvim",
            ".",
          }
          tmux { "set-window-option", "-t", win_id, "@neojj-workspace-path", ctx.path }
          tmux { "set-window-option", "-t", win_id, "automatic-rename", "off" }
        end,

        workspace_delete_command = function(ctx)
          if not in_tmux() then
            return
          end
          local r = vim
            .system({ "tmux", "list-windows", "-a", "-F", "#{window_id} #{@neojj-workspace-path}" }, { text = true })
            :wait()
          for line in (r.stdout or ""):gmatch "[^\n]+" do
            local win_id, path = line:match "^(%S+)%s+(.+)$"
            if path == ctx.path then
              vim.system({ "tmux", "kill-window", "-t", win_id }):wait()
            end
          end
        end,
      }

      local hl = vim.api.nvim_set_hl
      hl(0, "NeojjDiffAdd", { bg = "#1a2e25" })
      hl(0, "NeojjDiffAddHighlight", { bg = "#1f3a2c" })
      hl(0, "NeojjDiffDelete", { bg = "#2e1a22" })
      hl(0, "NeojjDiffDeleteHighlight", { bg = "#3a1f2c" })
      hl(0, "NeojjDiffAddCursor", { bg = "#243d30" })
      hl(0, "NeojjDiffDeleteCursor", { bg = "#3d2231" })
      hl(0, "NeojjDiffContextCursor", { bg = "#2a2e33" })
      hl(0, "NeojjHunkHeaderCursor", { bg = "#2a2e33" })
    end,
  },
}
