return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 32,
    },
    filesystem = {
      window = {
        mappings = {
          ["/"] = "noop", -- disable fuzzy finder
        },
      },
    },
  },
}
