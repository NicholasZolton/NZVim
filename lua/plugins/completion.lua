return {
  {
    "saghen/blink.cmp",
    version = "*",
    build = "cargo build --release",
    event = { "InsertEnter", "CmdlineEnter" },
    cond = not vim.g.vscode,
    dependencies = {
      {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require("luasnip").config.set_config(opts)
          require "nvchad.configs.luasnip"
          require "lua_snippets.snippets"
        end,
      },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)
        end,
      },
    },
    opts = {
      keymap = {
        preset = "none",
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide" },
        ["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      },
      snippets = { preset = "luasnip" },
      appearance = { nerd_font_variant = "normal" },
      sources = {
        default = { "lsp", "snippets", "path", "buffer" },
      },
      completion = {
        accept = { auto_brackets = { enabled = true } },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = { border = "single" },
        },
        menu = require("nvchad.blink").menu,
      },
      cmdline = {
        keymap = {
          preset = "none",
          ["<Tab>"] = { "accept", "fallback" },
          ["<C-e>"] = { "hide", "fallback" },
          ["<C-j>"] = { "select_next", "fallback" },
          ["<C-k>"] = { "select_prev", "fallback" },
        },
        completion = { menu = { auto_show = true } },
      },
    },
    config = function(_, opts)
      dofile(vim.g.base46_cache .. "blink")
      require("blink.cmp").setup(opts)
    end,
  },
  -- Disable nvim-cmp and its sources
  { "hrsh7th/nvim-cmp", enabled = false },
  { "hrsh7th/cmp-cmdline", enabled = false },
  { "hrsh7th/cmp-nvim-lua", enabled = false },
  { "hrsh7th/cmp-nvim-lsp", enabled = false },
  { "saadparwaiz1/cmp_luasnip", enabled = false },
  { "hrsh7th/cmp-buffer", enabled = false },
  { "hrsh7th/cmp-path", enabled = false },
}
