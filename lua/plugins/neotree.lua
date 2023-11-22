return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
    {
      -- only needed if you want to use the commands with "_with_window_picker" suffix
      's1n7ax/nvim-window-picker',
      config = function()
        require('window-picker').setup {
          autoselect_one = true,
          include_current = false,
          filter_rules = {
            -- filter using buffer options
            bo = {
              -- if the file type is one of following, the window will be ignored
              filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },

              -- if the buffer type is one of following, the window will be ignored
              buftype = { 'terminal', 'quickfix' },
            },
          },
          other_win_hl_color = '#e35e4f',
        }
      end,
    },
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
