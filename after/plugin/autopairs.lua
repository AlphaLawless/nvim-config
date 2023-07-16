local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
  return
end

npairs.setup({
  map_cr = true,
  enable_check_bracket_line = false,
  disable_filetype = { "TelescopePrompt" , "vim" },
})
