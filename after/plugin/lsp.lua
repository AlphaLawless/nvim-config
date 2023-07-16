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
local ok_lspsaga, lspsaga = pcall(require, 'lspsaga')
if not ok_lspsaga then
  return
end

lspsaga.setup({
  ui = {
    border = 'rounded'
  }
})

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
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
  'zls',
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
  signs = {
    Error = ' ',
    Warn = ' ',
    Info = ' ',
    Hint = ' ',
  }
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  remap("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
  remap("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  remap("n", "[d", "<cmd>Lspsaga diagnostic_jump_next", opts)
  remap("n", "]d", "<cmd>Lspsaga diagnostic_jump_prev", opts)
  remap("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  remap("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  remap("n", "<leader>vca", "<cmd>Lspsaga code_action<CR>", opts)
  remap("n", "<leader>rr", function() vim.lsp.buf.references() end, opts)
  remap("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
  remap("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  remap('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)
end)

-- Options
lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lspconfig.elixirls.setup({
  root_dir = lspconfig.util.root_pattern("mix.exs", ".git") or vim.fn.expand(vim.loop.os_homedir())
})

lspconfig.rust_analyzer.setup({
  on_attach = lsp.on_attach,
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
