return {
  {
    "amnn/lsp-echohint.nvim",
    opts = {},
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    version = "*",
    dependencies = {
      "hrsh7th/nvim-cmp",
    },
    opts = {},
  },
  {
    "hrsh7th/nvim-cmp",
    version = "*",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "petertriho/cmp-git",
    },
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        snippet = {
          expand = function(args) vim.snippet.expand(args.body) end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert(),

        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
        }),
      }

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
  {
    "j-hui/fidget.nvim",
    version = "*",
    opts = {
      notification = {
        window = {},
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    version = "*",
    -- Loads eagerly on purpose: deferring to VeryLazy can miss the FileType
    -- event for the buffer nvim was started with, leaving it unattached.
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      -- Defaults merged into every server's configuration.
      vim.lsp.config("*", {
        capabilities = vim.tbl_deep_extend(
          "force",
          require("cmp_nvim_lsp").default_capabilities(),
          {
            workspace = {
              didChangeWatchedFiles = {
                -- Disable workspace/didChangeWatchedFiles. It causes issues in
                -- large projects, where the file watcher opens too many files.
                dynamicRegistration = false,
              },
            },
          }
        ),
      })

      -- Ignore server-cancelled diagnostics, which rust-analyzer produces and
      -- neovim doesn't know how to handle (yet).
      for _, method in ipairs {
        "textDocument/diagnostic",
        "workspace/diagnostic",
      } do
        local default_handler = vim.lsp.handlers[method]
        vim.lsp.handlers[method] = function(err, res, ctx, cfg)
          if err ~= nil and err.code == -32802 then return end
          return default_handler(err, res, ctx, cfg)
        end
      end

      -- move-analyzer ships no stock configuration, so describe it in full.
      vim.lsp.config("move", {
        cmd = { "move-analyzer" },
        filetypes = { "move" },
        root_markers = { "Move.toml" },
      })

      vim.lsp.config("lua_ls", {
        on_init = function(client)
          local path = client.workspace_folders[1].name

          if
            vim.uv.fs_stat(path .. "/.luarc.json")
            or vim.uv.fs_stat(path .. "/.luarc.jsonc")
          then
            return
          end

          -- Copy all the runtime path directories, so we can add luv.
          local library = vim.tbl_deep_extend(
            "keep",
            vim.api.nvim_get_runtime_file("", true),
            {}
          )

          table.insert(library, "${3rd}/luv/library")

          client.config.settings.Lua =
            vim.tbl_deep_extend("force", client.config.settings.Lua, {
              runtime = {
                version = "LuaJIT",
              },
              -- Make the server aware of Neovim runtime files
              workspace = {
                checkThirdParty = false,
                library = library,
              },
            })
        end,

        settings = {
          Lua = {
            hint = { enable = true },
          },
        },
      })

      vim.lsp.config("clangd", {
        settings = {
          clangd = {
            InlayHints = {
              Enabled = true,
              Designators = true,
              ParameterNames = true,
              DeducedTypes = true,
            },
          },
        },
      })

      local ts_hints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }

      vim.lsp.config("ts_ls", {
        settings = {
          typescript = {
            inlayHints = ts_hints,
          },
          javascript = {
            inlayHints = ts_hints,
          },
        },
      })

      -- Register FileType autocmds that start each server on demand. Servers
      -- needing no overrides (gopls, rust_analyzer) only appear here.
      vim.lsp.enable {
        "clangd",
        "gopls",
        "lua_ls",
        "move",
        "rust_analyzer",
        "ts_ls",
      }
    end,
  },
  {
    "petertriho/cmp-git",
    version = "*",
    opts = {},
  },
  {
    "stevearc/conform.nvim",
    version = "*",
    opts = {
      formatters_by_ft = {
        c = { "clang-format" },
        cpp = { "clang-format" },
        clojure = { "cljfmt" },
        go = { "gofmt" },
        javascript = { "prettier" },
        lua = { "stylua" },
        move = { "prettier-move" },
        python = { "black" },
        rust = { "rustfmt" },
        typescript = { "prettier" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_format = "fallback",
      },
      formatters = {
        cljfmt = {
          command = "cljfmt",
          args = { "fix", "$FILENAME" },
          stdin = false,
        },
        ["prettier-move"] = {
          command = "prettier-move",
          args = { "--stdin-filepath", "$FILENAME" },
          range_args = function(_, ctx)
            local util = require "conform.util"
            local lo, hi = util.get_offsets_from_range(ctx.buf, ctx.range)
            return {
              "--stdin-filepath",
              "$FILENAME",
              "--range-start=" .. lo,
              "--range-end=" .. hi,
            }
          end,
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    version = "*",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      automatic_installation = true,
    },
  },
  {
    "williamboman/mason.nvim",
    version = "*",
    opts = {},
  },
}
