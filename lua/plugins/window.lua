return {
  {
    "christoomey/vim-tmux-navigator",
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    keys = {
      { "<c-w>h", "<cmd>TmuxNavigateLeft<cr>", desc = "Navigate left (tmux-aware)" },
      { "<c-w>j", "<cmd>TmuxNavigateDown<cr>", desc = "Navigate down (tmux-aware)" },
      { "<c-w>k", "<cmd>TmuxNavigateUp<cr>", desc = "Navigate up (tmux-aware)" },
      { "<c-w>l", "<cmd>TmuxNavigateRight<cr>", desc = "Navigate right (tmux-aware)" },
      { "<c-w>\\", "<cmd>TmuxNavigatePrevious<cr>", desc = "Navigate previous (tmux-aware)" },
    },
  },
  {
    "sindrets/winshift.nvim",
    version = "*",
    opts = {
      keymaps = {
        win_move_mode = {
          ["s"] = "swap",
        },
      },
    },
    keys = {
      {
        "<C-w><C-w>",
        mode = { "i", "n" },
        [[<CMD>WinShift<CR>]],
        desc = "WinShift Mode (WinShift)",
      },
      {
        "<C-w>x",
        mode = { "i", "n" },
        [[<CMD>WinShift swap<CR>]],
        desc = "Swap windows (WinShift)",
      },
    },
  },
}
