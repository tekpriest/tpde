return {
  'sourcegraph/sg.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', --[[ "nvim-telescope/telescope.nvim ]]
  },
  events = 'VeryLazy',
  opts = {},
  setup = function(_, opts)
    require('sg').setup(opts)
  end,
  keys = {
    {
      '<leader>sc',
      [[<cmd>lua require('sg.extensions.telescope').fuzzy_search_results()<cr>]],
      desc = 'fuzzy search code',
    },
  },
}
