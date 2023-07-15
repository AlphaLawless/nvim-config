vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

local TheGroup = vim.api.nvim_create_augroup("AlphaLawless", {})
local remap = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
    group = TheGroup,
    pattern = "*",
    callback = function()
        if vim.bo.ft ~= "fugitive" then
            return
        end

        local bufnr = vim.api.nvim_get_current_buf()
        local opts = {buffer = bufnr, remap = false}
        remap("n", "<leader>p", function()
            vim.cmd.Git('push')
        end, opts)

        remap("n", "<leader>gdf", function ()
          vim.cmd.Git('diff')
        end, opts)

        -- rebase always
        remap("n", "<leader>P", function()
            vim.cmd.Git({'pull',  '--rebase'})
        end, opts)

        -- NOTE: It allows me to easily set the branch i am pushing and any tracking
        -- needed if i did not set the branch up correctly
        vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts);
    end,
})
