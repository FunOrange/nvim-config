return {
  {
    "nvim-pack/nvim-spectre",
    event = "VeryLazy",
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
