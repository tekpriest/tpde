return {
  'Exafunction/codeium.vim',
  event = 'BufEnter',
  keys = {
    {
      '<C-.>',
      function()
        return vim.fn['codeium#Accept']()
      end,
      desc = 'accept suggestion',
    },
    {
      '<c-;>',
      function()
        return vim.fn['codeium#CycleCompletions'](1)
      end,
      desc = 'next suggestion',
    },
    {
      '<c-,>',
      function()
        return vim.fn['codeium#CycleCompletions'](-1)
      end,
      desc = 'previous suggestion',
    },
    {
      '<c-x>',
      function()
      return vim.fn['codeium#Clear']()
      end,
      desc = 'clear suggestion',
    },
  },
}
