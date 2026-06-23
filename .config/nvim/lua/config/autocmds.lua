-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    os.execute("pkill -9 -f 'Microsoft.CodeAnalysis.LanguageServer' 2>/dev/null")
    vim.wait(500, function()
      return #vim.lsp.get_clients({ name = "roslyn" }) == 0
    end, 10)
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  callback = function()
    os.execute("kill -WINCH " .. tostring(vim.uv.os_getppid()))
    os.exit(0)
  end,
})
