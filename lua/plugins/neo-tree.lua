return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 42,
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
