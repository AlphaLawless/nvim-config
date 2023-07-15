local ok_mark, mark = pcall(require, 'harpoon.mark')
if not ok_mark then
  return
end

local ok_ui, ui = pcall(require, 'harpoon.ui')
if not ok_ui then
  return
end

local remap = vim.keymap.set

remap("n", "<leader>a", mark.add_file)
remap("n", "<C-e>", ui.toggle_quick_menu)

remap("n", "<C-h>", function() ui.nav_file(1) end)
remap("n", "<C-t>", function() ui.nav_file(2) end)
remap("n", "<C-n>", function() ui.nav_file(3) end)
remap("n", "<C-s>", function() ui.nav_file(4) end)

