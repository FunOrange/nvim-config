-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.cmd.colorscheme "catppuccin"

require("cmp").setup {
  mapping = {
    -- Unmap keys
    ["<C-J>"] = function() end,
    ["<C-K>"] = function() end,
  },
}

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("\\<CR>")', { silent = true, expr = true })

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
