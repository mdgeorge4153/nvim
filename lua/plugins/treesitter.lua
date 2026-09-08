return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- Upstream does not support lazy-loading.
    lazy = false,
    build = ":TSUpdate",

    init = function()
      -- Parsers not shipped by upstream are registered from a `User TSUpdate`
      -- autocommand, which must exist before `:TSUpdate` runs. The Move
      -- grammar derives from Sui's own, at
      -- sui/external-crates/move/tooling/tree-sitter; queries for it live in
      -- queries/move/ in this config, since upstream ships none.
      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          require("nvim-treesitter.parsers").move = {
            install_info = {
              url = "https://github.com/0xangelo/tree-sitter-move",
            },
          }
        end,
      })
    end,

    config = function()
      require("nvim-treesitter").install {
        "c",
        "fish",
        "graphql",
        "latex",
        "lua",
        "markdown",
        "markdown_inline",
        "move",
        "python",
        "rust",
        "sql",
        "tsx",
        "typescript",
        "vim",
      }

      -- Highlighting is opt-in per filetype. Starting it for every buffer that
      -- has a parser keeps that automatic; `pcall` absorbs the ones that don't.
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          if vim.bo[args.buf].filetype == "gitcommit" then return end
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    version = "*",
    opts = {
      separator = "┄",
    },
  },
}
