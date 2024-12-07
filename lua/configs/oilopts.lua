return {
  delete_to_trash = true,
  --watch_for_changes = true,
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["g?"] = { "actions.show_help", mode = "n" },
    ["<CR>"] = { "actions.select", mode = "n" },
    ["ov"] = { "actions.select", opts = { vertical = true }, mode = "n" },
    ["oh"] = { "actions.select", opts = { horizontal = true }, mode = "n" },
    ["ot"] = { "actions.select", opts = { tab = true }, mode = "n" },
    ["p"] = { "actions.preview", mode = "n" },
    ["q"] = { "actions.close", mode = "n" },
    ["r"] = { "actions.refresh", mode = "n" },
    ["-"] = { "actions.parent", mode = "n" },
    ["_"] = { "actions.open_cwd", mode = "n" },
    ["`"] = { "actions.cd", mode = "n" },
    ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
    ["S"] = { "actions.change_sort", mode = "n" },
    ["s"] = { "actions.open_external", mode = "n" },
    ["g."] = { "actions.toggle_hidden", mode = "n" },
    ["g\\"] = { "actions.toggle_trash", mode = "n" },
  },
  -- Set to false to disable all of the above keymaps
  use_default_keymaps = false,
}
