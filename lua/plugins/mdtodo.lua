return {
  {
    "nicholaszolton/mdtodo.nvim",
    -- Local checkout for now; drop `dir` once it's pushed to GitHub.
    dir = "/Users/nicholas/Documents/Projects/mdtodo",
    enabled = true,
    cond = not vim.g.vscode,
    cmd = { "TodoAgenda", "TodoCreate", "TodoToggle", "TodoSchedule", "TodoDeadline" },
    keys = {
      { "<leader>ta", "<CMD>TodoAgenda<CR>", desc = "Todo Agenda" },
      { "<leader>tn", "<CMD>TodoCreate<CR>", desc = "Todo New" },
      { "<leader>tx", "<CMD>TodoToggle<CR>", desc = "Todo Toggle" },
      { "<leader>ts", "<CMD>TodoSchedule<CR>", desc = "Todo Schedule" },
      { "<leader>td", "<CMD>TodoDeadline<CR>", desc = "Todo Deadline" },
    },
    opts = {},
  },
}
