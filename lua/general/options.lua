local opt = vim.opt

-- Indentation options --
opt.smartindent = true                      -- make indenting smarter again
opt.tabstop = 2                             -- insert 2 spaces for a tab
opt.numberwidth = 4                         -- set number column width to 2 {default 4}
opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
opt.expandtab = true                        -- convert tabs to spaces
opt.shiftwidth = 2                          -- the number of spaces inserted for each indentation

-- Search options --
opt.hlsearch = true                         -- highlight all matches on previous search pattern
opt.ignorecase = true                       -- ignore case in search patterns
opt.incsearch = true                        -- Incremental search that shows partial matches
opt.smartcase = true                        -- smart case to search lower and upper case

-- Performance options
opt.lazyredraw = true                       -- the screen will not be redrawn while executing macros, registers...

-- Backup options
opt.swapfile = false                        -- creates a swapfile
opt.backup = false                          -- creates a backup file
opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true

-- Editing and Typing options
opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
opt.conceallevel = 0                        -- so that `` is visible in markdown files
opt.fileencoding = "utf-8"                  -- the encoding written to a file
opt.updatetime = 500                        -- faster completion (4000ms default)

-- Interface options
opt.guicursor = ""
opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
opt.cursorline = true                       -- highlight the current line
opt.mouse = "a"                             -- allow the mouse to be used in neovim
opt.relativenumber = true                   -- set relative numbered lines
opt.number = true                           -- set numbered lines
opt.pumheight = 10                          -- pop up menu height
opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
opt.showtabline = 2                         -- always show tabs
opt.splitbelow = true                       -- force all horizontal splits to go below current window
opt.splitright = true                       -- force all vertical splits to go to the right of current window
opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
opt.wrap = false                            -- display lines as one long line
opt.sidescrolloff = 8                       -- The number of screen columns to keep to the left and to the cursor
opt.scrolloff = 8                           -- is one of my fav
opt.termguicolors = true                    -- set term gui colors (most terminals support this)
opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
opt.background = "dark"                     -- set background option always dark

-- Extras
opt.showcmd = false
opt.ruler = false

-- To consult all options enter with `:help options` and see more about the options that have here

opt.fillchars.eob=" "
opt.whichwrap:append("<,>,[,],h,l")
opt.iskeyword:append("-")
opt.shortmess:append("c")                     -- helps to avoid all the |hit-enter| prompts caused by file messages

-- -- Clean Explorer
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Info: you can set options like vimscript with vim.cmd, see more https://github.com/nanotee/nvim-lua-guide#vimcmd

