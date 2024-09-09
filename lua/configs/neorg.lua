local options = {
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
}
if vim.fn.has "win32" == 1 then
else
  -- add the latex renderer
  -- options.load["core.latex.renderer"] = {
  --   render_on_enter = false,
  -- }
end
return options
