local map = vim.keymap.set
local utils = require 'core.utils'
local M = {}

local config = {
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
  },
  diagnostic = {
    virtual_text = false,
    underline = false,
    update_in_insert = false,
    severity_sort = true,
    float = {
      focusable = false,
      style = 'minimal',
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    },
  },
}

local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end

local keymaps = function(client, buffer)
  local telescope_builtin = require 'telescope.builtin'

  map('n', 'gd', vim.lsp.buf.definition, { desc = '[g]oto [d]efinition', buffer = buffer })
  -- stylua: ignore
  map('n', 'gr', function() require('trouble').open 'lsp_references' end, { desc = '[g]oto [r]eferences',buffer = buffer })
  map('n', 'K', vim.lsp.buf.hover, { desc = 'hover' })
  map('n', 'gi', vim.lsp.buf.implementation, { desc = '[g]oto [i]mplementation', buffer = buffer })
  -- stylua: ignore
  map('n', 'gl', vim.diagnostic.open_float, { desc = 'show [l]ine [d]iagnostics' })
  map('n', 'gK', vim.lsp.buf.signature_help, { desc = 'signature help', buffer = buffer })
  map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
  map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
  map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
  map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
  map('n', ']w', diagnostic_goto(true, 'WARNING'), { desc = 'Next Warning' })
  map('n', '[w', diagnostic_goto(false, 'WARNING'), { desc = 'Prev Warning' })
  -- stylua: ignore
  map('n', "<leader>ca", vim.lsp.buf.code_action, { desc = "[c]ode [a]ction"})
  map('n', '<leader>cs', telescope_builtin.lsp_document_symbols, { desc = '[c]ode [s]ymbols' })
  map('n', '<leader>cd', telescope_builtin.diagnostics, { desc = '[c]ode [d]ocument symbols' })
  -- stylua: ignore
  map('n', '<leader>cw', telescope_builtin.lsp_dynamic_workspace_symbols, {desc='[c]ode [w]orkspace symbols',  buffer = buffer})
  map('n', '<leader>cr', vim.lsp.buf.rename, { desc = '[c]ode [r]ename', buffer = buffer })
  map('n', '<space>cf', function() vim.lsp.buf.format { async = true } end, { desc = 'format buffer', buffer = buffer })
end

local capabilities = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }
  return require('cmp_nvim_lsp').default_capabilities(capabilities)
end

M.setup = function(_, opts)
  vim.diagnostic.config(config.diagnostic)
  utils.on_attach(function(client, bufnr)
    keymaps(client, bufnr)
  end)

  local servers = opts.servers
  local capabilities = capabilities()

  local function setup(server)
    local server_opts =
      vim.tbl_deep_extend('force', { capabilities = capabilities }, servers[server] or {})

    if opts.setup[server] then
      if opts.setup[server](server, server_opts) then
        return
      end
    elseif opts.setup['*'] then
      if opts.setup['*'](server, server_opts) then
        return
      end
    end
    require('lspconfig')[server].setup(server_opts)
  end

  local have_mason, mlsp = pcall(require, 'mason-lspconfig')
  local all_mslp_servers = {}
  if have_mason then
    all_mslp_servers = vim.tbl_keys(require('mason-lspconfig.mappings.server').lspconfig_to_package)
  end

  --@type string[]
  local ensure_installed = {}
  for server, server_opts in pairs(servers) do
    if server_opts then
      server_opts = server_opts == true and {} or server_opts
      -- run manual setup if mason=false
      if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
        setup(server)
      else
        ensure_installed[#ensure_installed + 1] = server
      end
    end
  end

  if have_mason then
    mlsp.setup { ensure_installed = ensure_installed }
    mlsp.setup_handlers { setup }
  end
end

return M
