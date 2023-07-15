local ok, zen_mode = pcall(require, 'zen-mode')
if not ok then
  return
end

vim.keymap.set("n", "<leader>zz", function()
    zen_mode.setup {
        window = {
            backdrop = 0.95,
            height = 1,
            width = 120,
            options = { }
        },
    }
    zen_mode.toggle()
    vim.wo.wrap = false
    vim.wo.number = true
    vim.wo.rnu = true
    ColorMyPencils()
end)


vim.keymap.set("n", "<leader>zZ", function()
    zen_mode.setup {
        window = {
            backdrop = 0.95,
            height = 1,
            width = 100,
            options = { }
        },
    }
    zen_mode.toggle()
    vim.wo.wrap = false
    vim.wo.number = false
    vim.wo.rnu = false
    vim.opt.colorcolumn = "0"
    ColorMyPencils()
end)
