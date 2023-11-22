return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'proto' })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'buf-language-server', 'buf', 'protolint' })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require 'null-ls'
      table.insert(opts.sources, nls.builtins.diagnostics.protolint)
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        bufls = {},
      },
    },
  },
}
