local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
  return
end

local servers = {
  -- Search for more in https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  "sumneko_lua", -- Lua
  "asm_lsp", -- Assembly/Nasm
  "clangd", -- C/C++
  "cssls", -- CSS
  "html", -- HTML
  "eslint", -- Eslint
  "tsserver", -- JavaScript/TypeScript
  "pyright", -- Python
  "java_language_server", -- Java
  "kotlin_language_server", -- Kotlin
  "graphql", -- GraphQL
  "elixirls", -- Elixir
  "hls", -- Haskell
  "bashls", -- Bash
  "jsonls", -- Json
  "yamlls", -- Yaml
  "rust_analyzer", -- Rust
  "emmet_ls", -- Emmet
  "dockerls", -- Docker
  "denols", -- Deno
  "solargraph", -- Ruby
}

lsp_installer.setup({
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = "✓",
      server_pending = "➜",
      server_uninstalled = "✗"
    }
  }
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  -- For more custom settings search for example: https://github.com/neovim/nvim-lspconfig/tree/master/lua/lspconfig/server_configurations
  local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
  if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
  end

  if server == "rust_analyzer" then
    require("rust-tools").setup {
      tools = {
        on_initialized = function()
          vim.cmd [[
            autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
          ]]
        end,
      },
      server = {
        on_attach = require("user.lsp.handlers").on_attach,
        capabilities = require("user.lsp.handlers").capabilities,
        settings = {
          ["rust-analyzer"] = {
            lens = {
              enable = true,
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
    }

    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
