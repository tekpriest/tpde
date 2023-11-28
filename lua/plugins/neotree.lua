return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'MunifTanjim/nui.nvim',
  },
  cmd = { 'NeoTreeToggle', 'NeoTreeFocus', 'Neotree' },
  init = function()
    vim.g.neo_tree_remove_legacy_commands = true
  end,
  opts = {
    auto_clean_after_session_restore = true,
    filesystem = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = { 'node_modules', '.git', '.cache', '_build' },
      follow_current_file = {
        enable = true,
      },
      hijack_netrw_behavior = 'open_current',
    },
    window = {
      position = 'right',
      width = 30,
    },
    default_component_configs = {
      icon = {
        folder_empty = '󰜌',
        folder_empty_open = '󰜌',
      },
      git_status = {
        symbols = {
          renamed = '󰁕',
          unstaged = '󰄱',
        },
      },
    },
  },
  keys = {
    { '<leader>e', '<cmd>Neotree toggle<cr>', 'toggle explorer' },
    { '<leader>o', '<cmd>Neotree reveal<cr>', 'focus file' },
  },
}
