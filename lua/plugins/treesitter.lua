-- if true then return {} end
return {
  {

    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      {
        'nvim-treesitter/playground',
        cmd = 'TSPlaygroundToggle',
      },
      {
        'windwp/nvim-ts-autotag',
        config = function()
          require('nvim-ts-autotag').setup()
        end,
      },
    },
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      sync_install = false,
      auto_install = true,
      ensure_installed = {
        'lua',
        'json',
        'typescript',
        'javascript',
        'query',
        'regex',
        'sql',
        'html',
        'vim',
        'vimdoc',
        'yaml',
        'dart',
        'elixir',
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = { enable = true, disable = { 'dart' } },
      -- context_commentstring = { enable = true, enable_autocmd = false },
      incremental_selection = {
        enable = true,
        keymaps = {
          -- mappings for incremental selection (visual mappings)
          init_selection = '<CR>',   -- maps in normal mode to init the node/scope selection
          node_incremental = 'grn',  -- increment to the upper named parent
          scope_incremental = 'grc', -- increment to the upper scope (as defined in locals.scm)
          node_decremental = 'grm',  -- decrement to the previous node
        },
      },
      matchup = { enable = true },
      playground = { enable = true },
      query_linter = { enable = true },
    },
    config = function(_, opts)
      if type(opts.ensure_installed == 'table') then
        -- @type table<string,boolean>
        local added = {}
        opts.ensure_installed = vim.tbl_filter(function(lang)
          if added[lang] then
            return false
          end
          added[lang] = true
          return true
        end, opts.ensure_installed)
      end
      require('nvim-treesitter.configs').setup(opts)
      require('ts_context_commentstring').setup()
    end,
    init = function()
      vim.g.skip_ts_context_commentstring_mdule = true
    end,
  },
  {
    'RRethy/vim-illuminate',
    init = function ()
      vim.cmd[[hi link IlluminateWordText Visual ]]
      vim.cmd[[hi link IlluminateWordRead Visual ]]
      vim.cmd[[hi link IlluminateWordWrite Visual ]]
    end
  }
}
