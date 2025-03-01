-- In your lazy.nvim config (e.g., init.lua or lazy.lua)
return {
  -- other plugins...
  {
    "nvim-pack/nvim-spectre",
    config = function()
      require("spectre").setup {
        replace_engine = {
          ["sed"] = {
            cmd = "sed",
            args = { "-i", "", "-E" },
          },
        },
      }
      vim.api.nvim_set_keymap("n", "<Leader>s", ":Spectre<CR>", { noremap = true, silent = true })
    end,
  },
}
