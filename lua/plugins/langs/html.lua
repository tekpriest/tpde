return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'html', 'css' })
    end,
  },
  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'prettierd' })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    opts = {
      -- make sure mason installs the server
      servers = {
        -- html
        html = {},
        -- Emmet
        emmet_ls = {
          init_options = {
            html = {
              options = {
                -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
                ['bem.enabled'] = true,
              },
            },
          },
        },
        -- CSS
        cssls = {},
      },
    },
  },
  -- {
  --   'jose-elias-alvarez/null-ls.nvim',
  --   opts = function(_, opts)
  --     local nls = require 'null-ls'
  --     table.insert(opts.sources, nls.builtins.formatting.prettierd)
  --   end,
  -- },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      defaults = {
        ['<leader>z'] = { name = '+System' },
        ['<leader>zC'] = { name = '+Color' },
      },
    },
  },
  {
    'uga-rosa/ccc.nvim',
    opts = {},
    cmd = {
      'CccPick',
      'CccConvert',
      'CccHighlighterEnable',
      'CccHighlighterDisable',
      'CccHighlighterToggle',
    },
    keys = {
      { '<leader>zCp', '<cmd>CccPick<cr>',              desc = 'Pick' },
      { '<leader>zCc', '<cmd>CccConvert<cr>',           desc = 'Convert' },
      { '<leader>zCh', '<cmd>CccHighlighterToggle<cr>', desc = 'Toggle Highlighter' },
    },
  },
  {
    'ec965/mjml-preview.nvim',
    ft = { 'mjml' },
    build = 'cd app && npm install',
    init = function()
      -- Set the main syntax to 'mjml'
      vim.cmd "let main_syntax = 'mjml'"

      -- Include HTML syntax
      vim.cmd 'runtime! syntax/html.vim'

      -- Add '-' to iskeyword
      vim.cmd 'setlocal iskeyword+=-'

      -- Define syntax keywords for various MJML tags
      vim.cmd 'syntax keyword htmlTagName contained mjml'
      vim.cmd 'syntax keyword htmlTagName contained mj-head mj-body mj-include'
      vim.cmd 'syntax keyword htmlTagName contained mj-attributes mj-breakpoint mj-font mj-html-attributes mj-preview mj-style mj-title'
      vim.cmd 'syntax keyword htmlTagName contained mj-accordion mj-button mj-carousel mj-column mj-divider mj-group mj-hero mj-image mj-navbar mj-raw mj-section mj-social mj-spacer mj-table mj-text mj-wrapper'
      vim.cmd 'syntax keyword htmlTagName contained mj-chart mj-qr-code mjml-msobutton'

      -- Define syntax for HTML attributes
      vim.cmd 'syntax match   htmlArg     contained /\\k\\+=\\@=/'

      -- Define syntax region for MJML style
      vim.cmd 'syntax region cssMjStyle start=+<mj-style[^>]*>+ keepend end=+</mj-style>+ contains=@htmlCss,htmlTag,htmlEndTag,htmlCssStyleComment,@htmlPreproc'

      -- Set current syntax to 'mjml'
      vim.cmd "let b:current_syntax = 'mjml'"
      vim.cmd 'unlet main_syntax'
    end,
  },
}
