return {
  {
    "natecraddock/workspaces.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local workspaces = require "workspaces"
      workspaces.setup {
        -- add your config options here
        -- e.g., path = vim.fn.stdpath("data") .. "/workspaces",
      }
    end,
  },
}
