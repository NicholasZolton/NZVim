return {
  {
    "markonm/traces.vim",
    event = "VeryLazy",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
      local map = vim.keymap.set
      map("n", "Y", "<Plug>(nvim-surround-normal)", { desc = "Add Surround (Normal)", remap = true })
      map("x", "Y", "<Plug>(nvim-surround-visual)", { desc = "Add Surround (Visual)", remap = true })
      map("n", "C", "<Plug>(nvim-surround-change)", { desc = "Change Surround (Normal)", remap = true })
      map("n", "X", "<Plug>(nvim-surround-delete)", { desc = "Delete Surround (Normal)", remap = true })
    end,
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "stevearc/oil.nvim",
    version = "*",
    cmd = { "Oil" },
    config = function()
      function _G.get_oil_winbar()
        local dir = require("oil").get_current_dir()
        if dir then
          return vim.fn.fnamemodify(dir, ":~")
        else
          return vim.api.nvim_buf_get_name(0)
        end
      end

      local opts = require "configs.oilopts"
      require("oil").setup(opts)
      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
    end,
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  { "karb94/neoscroll.nvim", enabled = false },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    cond = not vim.g.vscode,
    ---@type Flash.Config
    opts = {
      modes = {
        search = { enabled = true },
      },
    },
    keys = {
      {
        "c",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "r",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "R",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<c-s>",
        mode = { "c" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
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
    "haya14busa/is.vim",
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "yorickpeterse/nvim-window",
    lazy = false,
    keys = {},
    config = function()
      vim.keymap.set(
        "n",
        "<leader>wj",
        "<cmd>lua require('nvim-window').pick()<cr>",
        { desc = "Window Jump to Window" }
      )
    end,
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    cond = not vim.g.vscode,
    ---@type snacks.Config
    keys = {
      {
        "<leader>go",
        function()
          Snacks.gitbrowse()
        end,
        mode = { "n", "v" },
        desc = "Git Browse",
      },
      {
        "<leader>gb",
        function()
          Snacks.git.blame_line()
        end,
        desc = "Git Blame Line",
      },
      {
        "<leader>gi",
        function()
          Snacks.picker.gh_issue()
        end,
        desc = "GitHub Issues (open)",
      },
      {
        "<leader>gI",
        function()
          Snacks.picker.gh_issue { state = "all" }
        end,
        desc = "GitHub Issues (all)",
      },
      {
        "<leader>gp",
        function()
          Snacks.picker.gh_pr()
        end,
        desc = "GitHub PRs (open)",
      },
      {
        "<leader>gP",
        function()
          Snacks.picker.gh_pr { state = "all" }
        end,
        desc = "GitHub PRs (all)",
      },
      {
        "<leader>bn",
        function()
          Snacks.scratch()
        end,
        desc = "Scratch Buffer",
      },
      {
        "<leader>bs",
        function()
          Snacks.scratch.select()
        end,
        desc = "Select Scratch Buffer",
      },
    },
    init = function()
      vim.api.nvim_create_user_command("Notifications", function()
        Snacks.notifier.show_history()
      end, {})
    end,
    opts = {
      bigfile = { enabled = true },
      notifier = { enabled = true },
      gitbrowse = { enabled = true },
      picker = {
        enabled = true,
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
            actions = {
              yank_relative = function(picker, item)
                if item then
                  local abs = Snacks.picker.util.path(item) or item.file
                  local cwd = (picker:cwd() or ""):gsub("/+$", "")
                  local rel = abs
                  if cwd ~= "" and abs:sub(1, #cwd + 1) == cwd .. "/" then
                    rel = abs:sub(#cwd + 2)
                  end
                  vim.fn.setreg("+", rel)
                  Snacks.notify("Copied: " .. rel)
                end
              end,
              yank_filename = function(_, item)
                if item then
                  local abs = Snacks.picker.util.path(item) or item.file
                  local name = vim.fn.fnamemodify(abs, ":t")
                  vim.fn.setreg("+", name)
                  Snacks.notify("Copied: " .. name)
                end
              end,
              yank_absolute = function(_, item)
                if item then
                  local path = Snacks.picker.util.path(item) or item.file
                  vim.fn.setreg("+", path)
                  Snacks.notify("Copied: " .. path)
                end
              end,
            },
            win = {
              list = {
                keys = {
                  ["y"] = { "yank_relative", mode = { "n", "x" }, desc = "Yank relative path" },
                  ["Y"] = { "yank_filename", desc = "Yank filename" },
                  ["gy"] = { "yank_absolute", desc = "Yank absolute path" },
                },
              },
            },
          },
        },
      },
      explorer = { enabled = false },
      gh = {},
      scroll = { enabled = true },
      scratch = {
        ft = "markdown",
        win = {
          style = "scratch",
          keys = {
            ["nav_h"] = { "<C-h>", "<nop>", desc = "Disable nav" },
            ["nav_j"] = { "<C-j>", "<nop>", desc = "Disable nav" },
            ["nav_k"] = { "<C-k>", "<nop>", desc = "Disable nav" },
            ["nav_l"] = { "<C-l>", "<nop>", desc = "Disable nav" },
            ["nav_wh"] = { "<C-w>h", "<nop>", desc = "Disable nav" },
            ["nav_wj"] = { "<C-w>j", "<nop>", desc = "Disable nav" },
            ["nav_wk"] = { "<C-w>k", "<nop>", desc = "Disable nav" },
            ["nav_wl"] = { "<C-w>l", "<nop>", desc = "Disable nav" },
          },
        },
      },
      dashboard = {
        preset = {
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files()" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.picker.grep()" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.picker.recent()" },
            { icon = " ", key = "p", desc = "Projects", action = ":lua Snacks.picker.projects()" },
            { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
          { icon = " ", title = "Recent Files", section = "recent_files", limit = 5, indent = 2, padding = 1 },
          { icon = " ", title = "Projects", section = "projects", limit = 8, indent = 2, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "chrishrb/gx.nvim",
    keys = { { "gx", "<cmd>Browse<cr>", mode = { "n", "x" } } },
    cmd = { "Browse" },
    init = function()
      vim.g.netrw_nogx = 1
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local opts = require "configs.gxopen"
      require("gx").setup(opts)
    end,
    submodules = false,
  },
}
