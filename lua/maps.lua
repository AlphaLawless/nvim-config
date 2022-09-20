local keymap = vim.keymap.set
local opts = { silent = true }
local arrowKeys = { "<Up>", "<Down>", "<Left>", "<Right>" }

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Do not yank with x
keymap('n', 'x', '"_x')

-- Increment/decrement
keymap('n', '+', '<C-a>')
keymap('n', '-', '<C-x>')

-- Delete a word backwards
keymap('n', 'dw', 'vb"_d')

-- Select all
keymap('n', '<C-a>', 'gg<S-v>G')

-- New tab
keymap('n', 'te', ':tabedit<Return>', opts)

-- Split window
keymap('n', 'ss', ':split<Return><C-w>w', opts)
keymap('n', 'sv', ':vsplit<Return><C-w>w', opts)

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move window
keymap('n', '<Space>', '<C-w>w', opts)
keymap('', '<C-h>', '<C-w>h', opts)
keymap('', '<C-k>', '<C-w>k', opts)
keymap('', '<C-j>', '<C-w>j', opts)
keymap('', '<C-l>', '<C-w>l', opts)

-- Resize window
keymap('n', '<M-h>', ':vertical resize -2<CR>', opts)
keymap('n', '<M-l>', ':vertical resize +2<CR>', opts)
keymap('n', '<M-k>', ':resize -2<CR>', opts)
keymap('n', '<M-j>', ':resize +2<CR>', opts)

-- Desable arrow keys for Vim Hardmode
for key = 1, #arrowKeys do
  keymap("n", arrowKeys[key], "<Nop>", opts)
  keymap("i", arrowKeys[key], "<Nop>", opts)
  keymap("c", arrowKeys[key], "<Nop>", opts)
  keymap("v", arrowKeys[key], "<Nop>", opts)
end
