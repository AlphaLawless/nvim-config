local ok, template = pcall(require, "template")
if not ok then
  return
end

template.setup({
  temp_dir = vim.fn.expand('~/.config/nvim/templates')
})

vim.keymap.set("n", "<leader>tt", function ()
  vim.fn.feedkeys(":Template ")
end, { remap = true })

require("telescope").load_extension("find_template")

vim.keymap.set("n", "<leader>pt", ":Telescope find_template<CR>")
