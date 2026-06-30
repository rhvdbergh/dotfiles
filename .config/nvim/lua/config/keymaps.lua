-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function copy_to_clipboard(text, label)
  vim.fn.setreg("+", text)
  vim.notify("Copied " .. label .. ": " .. text)
end

vim.keymap.set("n", "<leader>fy", function()
  copy_to_clipboard(vim.fn.expand("%:t"), "filename")
end, { desc = "Copy filename to clipboard" })

vim.keymap.set("n", "<leader>fp", function()
  copy_to_clipboard(vim.fn.expand("%"), "relative path")
end, { desc = "Copy relative path to clipboard" })
