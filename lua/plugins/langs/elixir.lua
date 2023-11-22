return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        'elixir',
        'heex',
        'eex',
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function(_, opts)
      local nls = require 'null-ls'
      table.insert(opts.sources, nls.builtins.diagnostics.credo)
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        elixirls = {},
      },
    },
  },
}
