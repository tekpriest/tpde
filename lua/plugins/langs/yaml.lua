return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'yaml' })
      end
    end,
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'b0o/SchemaStore.nvim',
    },
    opts = {
      servers = {
        jsonls = {
          settings = {
            yaml = { keyOrdering = false },
          },
        },
      },
    },
  },
}
