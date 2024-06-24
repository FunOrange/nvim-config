---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter-context",
  opts = {
    multiline_threshold = 1,
  },
  config = function(_, opts)
    local treesitter_context = require "treesitter-context"
    require("treesitter-context").setup(opts)
    vim.keymap.set("n", "[u", function()
      require("treesitter-context").go_to_context(vim.v.count2)
      vim.api.nvim_command "normal! zz"
    end, { silent = true })
  end,
}
