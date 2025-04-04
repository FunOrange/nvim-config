-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.cmd.colorscheme "catppuccin-mocha"

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
local esc = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
vim.fn.setreg("l", "oconsole.log('" .. esc .. "pa:', " .. esc .. "pa);" .. esc .. "")
