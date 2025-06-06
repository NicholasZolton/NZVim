local conf = require "nvchad.configs.cmp"
local cmp = require "cmp"
conf.mapping = {
  ["<C-Space>"] = cmp.mapping.complete(),
  ["<C-e>"] = cmp.mapping.close(),
  -- ["<Tab>"] = cmp.mapping.confirm {
  --   behavior = cmp.ConfirmBehavior.Insert,
  --   select = true,
  -- },
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.confirm()
    elseif require("luasnip").jumpable(1) then
      require("luasnip").jump(1)
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if require("luasnip").jumpable(-1) then
      require("luasnip").jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
  ["<C-j>"] = cmp.mapping(function(fallback)
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
conf.sources = {
  { name = "nvim_lsp" },
  { name = "luasnip" },
  { name = "nvim_lua" },
  { name = "buffer" },
  { name = "path" },
}
cmp.setup.cmdline({ "/", "?" }, {
  mapping = {
    ["<C-e>"] = {
      c = cmp.mapping.abort(),
    },
    ["<Tab>"] = {
      c = cmp.mapping.confirm { select = false },
    },
    ["<C-j>"] = {
      c = function()
        local cmp = require "cmp"
        if cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end,
    },

    ["<C-k>"] = {
      c = function()
        local cmp = require "cmp"
        if cmp.visible() then
          cmp.select_prev_item()
        else
          cmp.complete()
        end
      end,
    },
  },
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = {
    ["<C-e>"] = {
      c = cmp.mapping.abort(),
    },
    ["<Tab>"] = {
      c = cmp.mapping.confirm { select = false },
    },
    ["<C-j>"] = {
      c = function()
        local cmp = require "cmp"
        if cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end,
    },

    ["<C-k>"] = {
      c = function()
        local cmp = require "cmp"
        if cmp.visible() then
          cmp.select_prev_item()
        else
          cmp.complete()
        end
      end,
    },
  },
  sources = cmp.config.sources {
    { name = "path" },
    { name = "cmdline" },
  },
  matching = { disallow_symbol_nonprefix_matching = false },
})

cmp.setup.filetype({ "sql", "mysql", "plsql", "pl" }, {
  sources = {
    { name = "cmp-dbee" },
    { name = "vim-dadbod-completion" },
    { name = "buffer" },
  },
})

return conf
