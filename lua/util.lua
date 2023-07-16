local M = {}

function M._echo_multiline(msg)
  for _, s in ipairs(vim.fn.split(msg, "\n")) do
    vim.cmd("echom '" .. s:gsub("'", "''") .. "'")
  end
end

function M.info(msg)
  vim.cmd("echohl Directory")
  M._echo_multiline(msg)
  vim.cmd("echohl None")
end

function M.warn(msg)
  vim.cmd("echohl WarningMsg")
  M._echo_multiline(msg)
  vim.cmd("echohl None")
end

function M.err(msg)
  vim.cmd("echohl ErrorMsg")
  M._echo_multiline(msg)
  vim.cmd("echohl None")
end

M.sudo_exec = function(cmd, print_output)
  vim.fn.inputsave()
  local password = vim.fn.inputsecret("Password: ")
  vim.fn.inputrestore()
  if not password or #password == 0 then
    M.warn("Invalid password, sudo aborted")
    return false
  end
  local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)
  if vim.v.shell_error ~= 0 then
    print("\r\n")
    M.err(out)
    return false
  end
  if print_output then print("\r\n", out) end
  return true
end

M.sudo_write = function(tmpfile, filepath)
  if not tmpfile then tmpfile = vim.fn.tempname() end
  if not filepath then filepath = vim.fn.expand("%") end
  if not filepath or #filepath == 0 then
    M.err("E32: No file name")
    return
  end
  -- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd
  -- Both `bs=1M` and `bs=1m` are non-POSIX
  local cmd = string.format("dd if=%s of=%s bs=1048576",
    vim.fn.shellescape(tmpfile),
    vim.fn.shellescape(filepath))
  -- no need to check error as this fails the entire function
  vim.api.nvim_exec(string.format("write! %s", tmpfile), true)
  if M.sudo_exec(cmd) then
    M.info(string.format([[\r\n"%s" written]], filepath))
    vim.cmd("e!")
  end
  vim.fn.delete(tmpfile)
end

M.save_file = function()
  local filepath = vim.fn.expand("%")
  if filepath == '' then -- The buffer is [No Name]
    local cwd = vim.fn.getcwd() .. "/"
    local newpath = vim.fn.input("Enter new file path: ", cwd)
    if newpath ~= cwd then
      local newdir = vim.fn.fnamemodify(newpath, ":h")
      if vim.fn.isdirectory(newdir) and vim.fn.filewritable(newdir) == 2 then
        vim.cmd('write ' .. vim.fn.fnameescape(newpath))
      else
        M.sudo_write(nil, newpath)
        vim.cmd('edit ' .. newpath)
      end
    end
  else
    vim.cmd('write')
  end
end

M.confirm_quit = function()
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.api.nvim_buf_get_option(bufnr, 'modified') then
    local answer = vim.fn.input("Would you like to exit without saving [y/N]? ")
    if answer:lower() == 'y' or answer == '' then
      vim.cmd('quit!')
    end
  else
    vim.cmd('quit')
  end
end

return M
