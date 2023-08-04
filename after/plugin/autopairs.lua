local ok, npairs = pcall(require, "nvim-autopairs")
if not ok then
  return
end

npairs.setup({
  map_cr = true,
  enable_check_bracket_line = false,
  disable_filetype = { "TelescopePrompt", "vim" },
  fast_wrap = {
    map = '<M-e>',
    chars = { '{', '[', '(', '"', "'", '`' },
    pattern = [=[[%'%"%>%]%)%}%,]]=],
    end_key = '$',
    keys = 'qwertyuiopzxcvbnmasdfghjkl',
    check_comma = true,
    manual_position = true,
    highlight = 'Search',
    highlight_grey = 'Comment'
  },
})
