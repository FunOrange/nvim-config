-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

local get_system_colorscheme = function()
  local home = os.getenv "HOME" or os.getenv "USERPROFILE"
  local handle = io.popen(home .. "/scripts/get_system_colorscheme.sh")
  if handle == nil then return "dark" end
  local result = handle:read "*a"
  handle:close()
  result = result:gsub("%s+", "") -- Trim any trailing newlines or spaces
  return result
end

if get_system_colorscheme() == "light" then
  vim.cmd.colorscheme "catppuccin-latte"
else
  vim.cmd.colorscheme "catppuccin-mocha"
end

local cmp = require "cmp"
cmp.setup {
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm { select = true },
    ["<C-CR>"] = cmp.mapping.confirm { select = true },
    ["<Tab>"] = cmp.config.disable,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" }, -- For vsnip users.
  }, {
    { name = "buffer" },
  }),
}

vim.api.nvim_del_keymap("n", "gra")
vim.api.nvim_del_keymap("n", "grn")
vim.api.nvim_del_keymap("n", "grr")
vim.api.nvim_set_keymap("n", "<C-right>", ":cn<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-left>", ":cp<CR>", { noremap = true, silent = true })

vim.opt.swapfile = false

vim.api.nvim_create_user_command("OrganizeImports", function()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { vim.api.nvim_buf_get_name(0) },
  }
  vim.lsp.buf.execute_command(params)
end, {})

-- Disable matchparen plugin
vim.g.loaded_matchparen = 1

-- title = cwd
vim.opt.title = true
vim.opt.titlestring = "%{getcwd()}"
vim.api.nvim_create_autocmd("DirChanged", {
  pattern = "*",
  callback = function() vim.opt.titlestring = vim.fn.getcwd() end,
})

-- console.log variable

-- toggle formatter
-- vim.g.autoformat = true
-- vim.api.nvim_create_user_command("ToggleFormatter", function()
--   vim.g.autoformat = not vim.g.autoformat
--   print("Autoformat: " .. (vim.g.autoformat and "Enabled" or "Disabled"))
-- end, {})
-- vim.keymap.set("n", "<leader>lF", ":ToggleFormatter<CR>", { desc = "Toggle Autoformat" })

-- tsc error quickfix
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  command = "setlocal errorformat=%f(%l\\\\,%c):\\ error\\ %m",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  command = "setlocal makeprg=tsc\\ --noEmit\\ --pretty\\ false",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    vim.fn.setreg("l", "oconsole.log('" .. esc .. "pa:', " .. esc .. "pa);" .. esc .. ";w" .. enter)
  end,
})

local function save_if_modified()
  if vim.bo.modified then vim.cmd "write" end
end
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
    local enter = vim.api.nvim_replace_termcodes("<CR>", true, false, true)
    vim.fn.setreg("l", 'ofmt.Printf("%+v\\n", ' .. esc .. "pa)" .. esc .. ";w" .. enter)

    vim.keymap.set("n", ",r", function()
      save_if_modified()
      vim.cmd "!go run ."
    end, { desc = "go run" })

    vim.keymap.set("n", ",t", function()
      save_if_modified()
      vim.cmd "!go test ./... -v"
    end, { desc = "go test (all)" })
  end,
})
