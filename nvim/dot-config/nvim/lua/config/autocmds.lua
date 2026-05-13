-- Autocmds are automatically loaded on the VeryLazy event
-- Add any additional autocmds here

-- Disable LazyVim's autocmd that enables spell on text/markdown/gitcommit/etc.
vim.api.nvim_create_augroup("lazyvim_wrap_spell", { clear = true })
vim.opt.spell = false
