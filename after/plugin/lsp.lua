local ok_cmp, cmp = pcall(require, 'cmp')
if not ok_cmp then
  return
end
local ok_lsp, lsp = pcall(require, 'lsp-zero')
if not ok_lsp then
  return
end
local ok_snip, luasnip = pcall(require, 'luasnip')
if not ok_snip then
  return
end
local ok_lspconf, lspconfig = pcall(require, 'lspconfig')
if not ok_lspconf then
  return
end

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local _attach = function(client)
  vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
  client.server_capabilities.semanticTokensProvider = nil
  local orignal = vim.notify
  local mynotify = function(msg, level, opts)
    if msg == 'No code actions available' or msg:find('overly') then
      return
    end
    orignal(msg, level, opts)
  end

  vim.notify = mynotify
end

lsp.preset({ "recommeded" })

local remap = vim.keymap.set

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
  'ruby_ls',
  'bashls'
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
  ["<Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_next_item()
      -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
      -- they way you will only jump inside the snippet region
    elseif luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    elseif has_words_before() then
      cmp.complete()
    else
      fallback()
    end
  end, { "i", "s" }),

  ["<S-Tab>"] = cmp.mapping(function(fallback)
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then
      luasnip.jump(-1)
    else
      fallback()
    end
  end, { "i", "s" }),
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

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lspconfig.rust_analyzer.setup({
  on_attach = _attach,
  settings = {
    ['rust-analyzer'] = {
      imports = {
        granularity = {
          group = 'module',
        },
        prefix = 'self',
      },
      cargo = {
        buildScripts = {
          enable = true,
        },
      },
      procMacro = {
        enable = true,
      },
    },
  },
})

lsp.setup()

vim.diagnostic.config({
  virtual_text = true
})
