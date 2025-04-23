return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    opts = {
      transparent_background = true,
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.50,
      },
      -- highlight_overrides = {
      --   mocha = function(c)
      --     return {
      --       Normal = { bg = c.mantle },
      --       Comment = { fg = "#7687a0" },
      --       ["@tag.attribute"] = { style = {} },
      --     }
      --   end,
      -- },
    },
  },
}
