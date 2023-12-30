return {
  'epwalsh/obsidian.nvim',
  version = '*',
  event = 'VeryLazy',
  -- ft = 'markdown',
  depends = { 'plenary.nvim' },
  opts = {
    workspaces = {
      {
        name = 'personal',
        path = '~/notes/personal',
      },
    },
  },
}
