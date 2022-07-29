-- Indentation options --
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.tabstop = 2                             -- insert 2 spaces for a tab
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
vim.opt.expandtab = true                        -- convert tabs to spaces
vim.opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation

-- Search options --
vim.opt.hlsearch = true                         -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.incsearch = true                        -- Incremental search that shows partial matches
vim.opt.smartcase = true                        -- smart case to search lower and upper case

-- Performance options
vim.opt.lazyredraw = true                       -- the screen will not be redrawn while executing macros, registers...

-- Backup options
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.backup = false                          -- creates a backup file
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- Editing and Typing options
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.timeoutlen = 100                        -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.undofile = true                         -- enable persistent undo

-- User interface options
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.mouse = "a"                             -- allow the mouse to be used in neovim
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.number = true                           -- set numbered lines
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.sidescrolloff = 8                       -- The number of screen columns to keep to the left and to the cursor
vim.opt.scrolloff = 8                           -- is one of my fav
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.laststatus = 3                          -- show only 3 status line

-- Extras
vim.opt.showcmd = false
vim.opt.ruler = false

-- To consult all options enter with `:help options` and see more about the options that have here

vim.opt.fillchars.eob=" "
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:append("-")
vim.opt.shortmess:append("c")                     -- helps to avoid all the |hit-enter| prompts caused by file messages

-- Info: you can set options like vimscript with vim.cmd, see more https://github.com/nanotee/nvim-lua-guide#vimcmd
