return {
  {
    "nicholaszolton/fancymd.nvim",
    -- Local checkout for now; drop `dir` once it's pushed to GitHub.
    dir = "/Users/nicholas/Documents/Projects/fancymd",
    enabled = true,
    cond = not vim.g.vscode,
    cmd = {
      "TodoAgenda",
      "TodoCreate",
      "TodoToggle",
      "TodoSchedule",
      "TodoDeadline",
      "ClockIn",
      "ClockOut",
      "ClockCancel",
      "ClockGoto",
      "ClockEffort",
      "ClockReport",
    },
    keys = {
      { "<leader>ta", "<CMD>TodoAgenda<CR>", desc = "Todo Agenda" },
      { "<leader>tn", "<CMD>TodoCreate<CR>", desc = "Todo New" },
      { "<leader>tx", "<CMD>TodoToggle<CR>", desc = "Todo Toggle" },
      { "<leader>ts", "<CMD>TodoSchedule<CR>", desc = "Todo Schedule" },
      { "<leader>td", "<CMD>TodoDeadline<CR>", desc = "Todo Deadline" },
      { "<leader>ci", "<CMD>ClockIn<CR>", desc = "Clock In" },
      { "<leader>co", "<CMD>ClockOut<CR>", desc = "Clock Out" },
      { "<leader>cx", "<CMD>ClockCancel<CR>", desc = "Clock Cancel" },
      { "<leader>cg", "<CMD>ClockGoto<CR>", desc = "Clock Goto" },
      { "<leader>ce", "<CMD>ClockEffort<CR>", desc = "Clock Effort" },
      { "<leader>cr", "<CMD>ClockReport<CR>", desc = "Clock Report" },
    },
    opts = {
      root = vim.fn.expand "~/Documents/Projects/ObsidianVault",
      report = {
        kind = "tab",
        scope = "file",
      },
    },
  },
}
