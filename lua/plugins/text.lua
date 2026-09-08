return {
  {
    "HiPhish/rainbow-delimiters.nvim",
    version = "*",
    config = function()
      local rainbow_delimiters = require "rainbow-delimiters"
      require("rainbow-delimiters.setup").setup {
        strategy = {
          [""] = rainbow_delimiters.strategy["global"],
        },
        query = {
          [""] = "rainbow-delimiters",
        },
      }
    end,
  },
  {
    "cappyzawa/trim.nvim",
    version = "*",
    opts = {},
  },
  {
    "folke/todo-comments.nvim",
    version = "*",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      highlight = {
        before = "",
        after = "",
        keyword = "fg",
        pattern = [[.*<(KEYWORDS)>]],
      },
      search = {
        pattern = [[\b(KEYWORDS)\b]],
      },
    },
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {},
  },
  {
    "m4xshen/autoclose.nvim",
    version = "*",
    opts = {
      keys = {
        ["'"] = { escape = true, close = false, pair = "''" },
        ["`"] = { escape = true, close = false, pair = "``" },
      },
      options = {
        pair_spaces = true,
        disabled_filetypes = {
          "gitcommit",
          "markdown",
          "text",
          "typescript",
          "typescriptreact",
        },
      },
    },
  },
}
