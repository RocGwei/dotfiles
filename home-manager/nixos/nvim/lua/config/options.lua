-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.list = true
opt.conceallevel = 0
opt.listchars = { space = "·", tab = " »", trail = "·", extends = ">", precedes = "<", nbsp = "␣" }