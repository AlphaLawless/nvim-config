-- Custom user configuration to lua neovim
require "user.colorscheme"
require "user.lsp"
require "user.plugins"
require "user.nvim-functions"

-- General commands of neovim
require "general.autocommands"
require "general.keymaps"
require "general.options"

-- Location of Plugins
require "plug-config.alpha"
require "plug-config.autopairs"
require "plug-config.bufferline"
require "plug-config.comment"
require "plug-config.cmp"
require "plug-config.dap"
require "plug-config.gitsigns"
require "plug-config.illuminate"
require "plug-config.impatient"
require "plug-config.indentline"
require "plug-config.lualine"
require "plug-config.nvim-tree"
require "plug-config.telescope"
require "plug-config.project"
require "plug-config.toggleterm"
require "plug-config.treesitter"
require "plug-config.whichkey"
