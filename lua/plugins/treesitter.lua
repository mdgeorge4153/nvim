return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Pinned to master: the default branch is now `main`, whose rewrite drops
    -- the `nvim-treesitter.configs` module this setup call uses. Without this
    -- the whole config block below throws and none of it takes effect.
    branch = "master",
    build = ":TSUpdate",
    config = function()
      -- Registered before `setup`, so that "move" below is a known parser by
      -- the time `ensure_installed` is processed.
      --
      -- Grammar derived from Sui's own, at
      -- sui/external-crates/move/tooling/tree-sitter. Highlighting also needs
      -- queries/move/highlights.scm on the runtimepath; nvim-treesitter only
      -- ships queries for the parsers it knows about, and Move isn't one.
      local parsers = require("nvim-treesitter.parsers").get_parser_configs()
      parsers["move"] = {
        filetype = "move",
        maintainers = {},
        install_info = {
          url = "https://github.com/0xangelo/tree-sitter-move",
          branch = "main",
          files = { "src/parser.c" },
          generate_requires_npm = false, -- if stand-alone parser without npm dependencies
          requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
        },
      }

      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "c",
          "clojure",
          "fennel",
          "fish",
          "graphql",
          "go",
          "gomod",
          "gowork",
          "lua",
          "markdown",
          "markdown_inline",
          "move",
          "python",
          "rust",
          "scheme",
          "sql",
          "tsx",
          "typescript",
          "vim",
        },

        modules = {},
        -- Grammars that must be generated from source, which this branch drives
        -- with a `tree-sitter generate --no-bindings` invocation the current CLI
        -- rejects. Without this, auto_install errors on every such buffer.
        ignore_install = { "latex" },
        sync_install = false,
        auto_install = true,

        highlight = {
          enable = true,
          disable = { "gitcommit" },
        },
      }
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
