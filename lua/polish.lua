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
  vim.cmd.colorscheme "astrolight"
else
  vim.cmd.colorscheme "catppuccin"
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

local select_one_or_multi = function(prompt_bufnr)
  local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    require("telescope.actions").close(prompt_bufnr)
    for _, j in pairs(multi) do
      if j.path ~= nil then vim.cmd(string.format("%s %s", "edit", j.path)) end
    end
  else
    require("telescope.actions").select_default(prompt_bufnr)
  end
end
require("telescope").setup {
  defaults = {
    mappings = {
      i = {
        ["<CR>"] = select_one_or_multi,
      },
    },
  },
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
