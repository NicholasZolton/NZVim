return {
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
    ft = "lua",
    opts = {
      library = {
        "lazy.nvim",
      },
    },
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
      local map = Snacks.keymap.set
      local lsp = { lsp = {} }
      map("n", "K", "<CMD>Lspsaga hover_doc<CR>", vim.tbl_extend("force", lsp, { desc = "Hover Doc", remap = true }))
      map("n", "<leader>ra", "<CMD>Lspsaga lsp_rename ++project<CR>", vim.tbl_extend("force", lsp, { desc = "Rename", remap = true }))
      map("n", "<leader>ca", "<CMD>Lspsaga code_action<CR>", vim.tbl_extend("force", lsp, { desc = "Code Action", remap = true }))
      map("n", "<C-.>", "<CMD>Lspsaga code_action<CR>", vim.tbl_extend("force", lsp, { desc = "Code Action", remap = true }))
      map("n", "<C-]>", "<CMD>Lspsaga finder<CR>", vim.tbl_extend("force", lsp, { desc = "Finder", remap = true }))
      map(
        "n",
        "[e",
        '<CMD>lua require("lspsaga.diagnostic"):goto_prev { severity = vim.diagnostic.severity.ERROR }<CR>',
        vim.tbl_extend("force", lsp, { desc = "Prev Error" })
      )
      map(
        "n",
        "]e",
        '<CMD>lua require("lspsaga.diagnostic"):goto_next { severity = vim.diagnostic.severity.ERROR }<CR>',
        vim.tbl_extend("force", lsp, { desc = "Next Error" })
      )
      map(
        "n",
        "[d",
        '<CMD>lua require("lspsaga.diagnostic"):goto_prev()<CR>',
        vim.tbl_extend("force", lsp, { desc = "Prev Diagnostic", remap = true })
      )
      map(
        "n",
        "]d",
        '<CMD>lua require("lspsaga.diagnostic"):goto_next()<CR>',
        vim.tbl_extend("force", lsp, { desc = "Next Diagnostic", remap = true })
      )
    end,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    enabled = true,
    cond = not vim.g.vscode,
    "stevearc/conform.nvim",
    version = "*",
    event = "BufWritePre",
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
}
