return {
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
    },
    build = 'make install_jsregexp',
    opts = {
      history = true,
      delete_check_events = 'TextChanged',
    },
    -- stylua: ignore
    keys = {
      {
        "<C-j>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<C-j>"
        end,
        expr = true,
        remap = true,
        silent = true,
        mode = "i",
      },
      { "<C-j>", function() require("luasnip").jump(1) end,  mode = "s" },
      { "<C-k>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
    config = function(_, opts)
      require('luasnip').setup(opts)
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'hrsh7th/cmp-nvim-lua',
      'amarakon/nvim-cmp-buffer-lines',
      'jcha0713/cmp-tw2css',
    },
    init = function()
      vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'preview' }
      -- gray
      vim.api.nvim_set_hl(
        0,
        'CmpItemAbbrDeprecated',
        { bg = 'NONE', strikethrough = true, fg = '#808080' }
      )
      -- blue
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg = 'NONE', fg = '#569CD6' })
      vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link = 'CmpIntemAbbrMatch' })
      -- light blue
      vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg = 'NONE', fg = '#9CDCFE' })
      vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link = 'CmpItemKindVariable' })
      vim.api.nvim_set_hl(0, 'CmpItemKindText', { link = 'CmpItemKindVariable' })
      -- pink
      vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg = 'NONE', fg = '#C586C0' })
      vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link = 'CmpItemKindFunction' })
      -- front
      vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg = 'NONE', fg = '#D4D4D4' })
      vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link = 'CmpItemKindKeyword' })
      vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link = 'CmpItemKindKeyword' })
    end,
    opts = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      local Utils = require 'core.utils'

      return {
        -- completion = { completeopt = 'menu,menuone,noinsert,preview' },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { 'kind', 'abbr' },
          format = function(_, item)
            item.kind = Utils.cmp_kinds[item.kind] or ''
            return item
          end,
        },
        experimental = {
          hl_group = 'LspCodeLens',
          ghost_text = {},
        },
        mapping = {
          ['<CR>'] = cmp.mapping.confirm { select = false, beahvior = cmp.ConfirmBehavior.Insert },
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif Utils.has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.expand_or_jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        window = {
          completion = cmp.config.window.bordered(),
          --   {
          --   winhighlight = 'NormalFloat:NormalFloat,FloatBorder:TelescopeBorder',
          --   col_offset = -3,
          --   side_padding = 0,
          -- },
          documentation = cmp.config.window.bordered(),
          -- format = function(entry, item)
          --   local menu_icon = {
          --     nvim_lsp = 'λ',
          --     luasnip = '⋗',
          --     buffer = 'b',
          --     path = 'p',
          --   }
          --   item.menu = menu_icon[entry.source.name]
          --   return item
          -- end,
          --   {
          --   border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
          -- },
        },
        sources = {
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'buffer',                 keyword_length = 2 },
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'cmp-tw2css' },
        },
      }
    end,
  },
}
