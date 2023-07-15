local ok_cmp, cmp = pcall(require, 'cmp')
if not ok_cmp then
  return
end
local ok_lsp, lsp = pcall(require, 'lsp-zero')
if not ok_lsp then
  return
end

lsp.preset({ "recommeded" })

local remap = vim.keymap.set

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())


-- More configurations here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
lsp.ensure_installed({
  'tsserver',
  'eslint',
  'lua_ls',
  'rust_analyzer',
  'html',
  'cssls',
  'pyright',
  'graphql',
  'clangd',
  'dockerls',
  'elixirls',
  'gopls',
  'clojure_lsp',
  'emmet_ls',
  'ruby_ls'
})

local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-Space>'] = cmp.mapping.complete(),
  ['<C-e>'] = cmp.mapping.close(),
  ['<CR>'] = cmp.mapping.confirm({
    behavior = cmp.ConfirmBehavior.Replace,
    select = true,
  }),
})

lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  remap("n", "gd", function() vim.lsp.buf.definition() end, opts)
  remap("n", "K", function() vim.lsp.buf.hover() end, opts)
  remap("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  remap("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  remap("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  remap("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  remap("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  remap("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  remap("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  remap("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  remap('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
end)

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
