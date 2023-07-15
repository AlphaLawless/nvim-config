-- Define a function to disable colorcolumn in Netrw
local disable_color_column_in_netrw = function()
  if vim.fn.expand("%:t") == "." or vim.bo.filetype == "netrw" then
    vim.opt.colorcolumn = ""
  else
    vim.opt.colorcolumn = "80"
  end
end

disable_color_column_in_netrw()

local fix_dismatch_tmux_with_vim = function()
  if os.getenv('TMUX') then
    -- Colors in tmux
    vim.api.nvim_set_option('t_8f', '<Esc>[38;2;%lu;%lu;%lum')
    vim.api.nvim_set_option('t_8b', '<Esc>[48;2;%lu;%lu;%lum')
  end
  vim.api.nvim_set_option('termguicolors', true)
  vim.api.nvim_set_option('term', 'xterm-256color')
  vim.api.nvim_set_option('background', 'dark')
end

fix_dismatch_tmux_with_vim()

local augroup = vim.api.nvim_create_augroup
local TheGroup = augroup('AlphaLawless', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = TheGroup,
    pattern = "*",
    command = "%s/\\s\\+$//e",
})
