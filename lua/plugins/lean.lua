return {
  {
    "Julian/lean.nvim",
    -- Deliberately unpinned: tagged releases lag main by months (the latest,
    -- v2026.4.1, predates self-activation and neovim 0.12 support), and their
    -- READMEs document the now-deprecated `setup` call. lazy-lock.json still
    -- pins an exact commit.
    --
    -- `event` rather than `ft`, because lean.nvim supplies the filetype
    -- detection for *.lean itself, so `ft = "lean"` would never fire.
    event = { "BufReadPre *.lean", "BufNewFile *.lean" },

    -- `init` (not `config`/`opts`): lean.nvim reads the `vim.g.lean_config`
    -- global and self-activates on Lean buffers, so the config must be in
    -- place before the plugin loads. `opts` would route through the
    -- deprecated `require("lean").setup`.
    init = function()
      ---@type lean.Config
      vim.g.lean_config = {
        mappings = true,
      }
    end,
  },
}
