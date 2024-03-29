local remap = vim.keymap.set
local opts = { silent = true }

vim.g.mapleader = " "

-- save when Sudo is required
remap("n", "<leader>W", '<esc>:lua require"util".sudo_write()<CR>', opts)
-- save new tab file or save buffer
remap("n", "<leader>ww", ':lua require"util".save_file()<CR>', opts)

-- confirm to quit or just quit
remap("n", "<leader>Q", ':lua require"util".confirm_quit()<CR>', opts)

remap("v", "J", ":m '>+1<CR>gv=gv")
remap("n", "<leader>pv", vim.cmd.Ex)

remap({ "n", "v" }, "H", "^", opts)
remap({ "n", "v" }, "L", "$", opts)

-- new tab
remap("n", "te", ":tabedit<CR>", opts)

-- navigate between buffers
remap("n", "<leader><S-l>", ":bnext<CR>", opts)
remap("n", "<leader><S-h>", ":bprevious<CR>", opts)

-- Increment/Decrement
remap("n", "+", "<C-a>")
remap("n", "-", "<C-x>")

remap("v", "K", ":m '<-2<CR>gv=gv")

-- Stay in indent mode
remap("v", "<", "<gv", opts)
remap("v", ">", ">gv", opts)

remap("n", "J", "mzJ`z")
remap("n", "<C-d>", "<C-d>zz")
remap("n", "<C-u>", "<C-u>zz")
remap("n", "n", "nzzzv")
remap("n", "N", "Nzzzv")

-- greatest remap ever
remap("x", "<leader>p", [["_dP]])

-- view path and dir
remap("n", "<leader>vipa", "<cmd>lua print(vim.fn.expand('%:p')) <CR>")
remap("n", "<leader>vidi", "<cmd>lua print(vim.fn.expand('%:d')) <CR>")

-- next greatest remap ever : asbjornHaland
remap({ "n", "v" }, "<leader>y", [["+y]])
remap("n", "<leader>Y", [["+Y]])
-- copy all buffer to another register
remap("n", "<leader><C-y>", "<cmd>:%y+ <CR>")

-- select all buffer
remap("n", "<C-a>", "gg<S-v>G")

-- delete where the cursor is stopped
remap({ "n", "v" }, "<leader>d", [["_d]])

-- disable highlight
remap("n", "<leader>nh", "<cmd>:nohl <CR>")

-- This is going to get me cancelled
remap({ "i", "v" }, "<C-c>", "<Esc>")

remap("n", "Q", "<nop>")
remap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

remap("n", "<C-k>", "<cmd>cnext<CR>zz")
remap("n", "<C-j>", "<cmd>cprev<CR>zz")
remap("n", "<leader>k", "<cmd>lnext<CR>zz")
remap("n", "<leader>j", "<cmd>lprev<CR>zz")

-- rename all match word
remap({ "n", "v" }, "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- delete the current word and enter in i mode
remap("n", "<leader>ew", function()
  vim.api.nvim_input("b")
  vim.api.nvim_input("viw")
  vim.api.nvim_input("d")
  vim.api.nvim_input("i")
end, opts)

-- turn on a file executable
remap("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)

remap("n", "<leader>vpp", "<cmd>e ~/.config/nvim/init.lua<CR>")
remap("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

remap("n", "<leader><leader>", function()
  vim.cmd("so")
end)
