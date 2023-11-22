return {
  'nvim-telescope/telescope.nvim',
  dependencies = { { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' } },
  cmd = 'Telescope',
  opts = {
    defaults = {
      mappings = {
        -- i = {
        --   ['<CR>'] = function(...)
        --     local actions = require 'telescope.actions'
        --     require('telescope.actions').select_default() + require('telescope.actions').center()
        --     -- actions.select_default() + actions.center()
        --   end,
        -- },
        n = {
          ['q'] = function(...)
            require('telescope.actions').close(...)
          end,
        },
      },
    },
  },
  config = function(_, opts)
    local telescope = require 'telescope'
    telescope.setup(opts)
    telescope.load_extension 'fzf'
  end,
  keys = {
    { '<leader><space>', '<cmd>Telescope find_files<cr>', desc = 'find files' },
    {
      '<leader>fw',
      '<cmd>Telescope live_grep<cr>',
      desc = 'live text search',
    },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'list buffers' },
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
    { '<leader>fg', '<cmd>Telescope git_files<cr>', desc = 'Git Files' },
  },
}
