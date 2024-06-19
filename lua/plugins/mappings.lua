return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<C-p>"] = { function() require("telescope.builtin").find_files() end, desc = "Go to file" },
          ["<F1>"] = { ":ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
          ["<F4>"] = { ":TermExec cmd='npm run dev'<cr>", desc = "npm run dev" },
          ["gt"] = {
            function() require("astrocore.buffer").nav(vim.v.count1) end,
            desc = "Next tab",
          },
          ["gT"] = {
            function() require("astrocore.buffer").nav(-vim.v.count1) end,
            desc = "Previous tab",
          },
          ["H"] = { "^", desc = "beginning of line" },
          ["L"] = { "$", desc = "end of line" },
          ["J"] = { "<C-e><C-e>", desc = "Scroll screen down" },
          ["K"] = { "<C-y><C-y>", desc = "Scroll screen up" },
          ["Q"] = { "@q", desc = "Quick execute macro" },
          ["<tab>"] = { ":normal %<cr>", desc = "Go to matching pair" },
          [",v"] = { "<C-v>", desc = "Enter visual block mode" },
          ["<F2>"] = { function() vim.lsp.buf.rename() end, desc = "Rename symbol" },
          ["<Leader>,"] = { ':execute "cd " .. stdpath("config")<cr>', desc = "Rename symbol" },

          -- altered functionality
          [">"] = { ">>", desc = "Shift line right" },
          ["<"] = { "<<", desc = "Shift line left" },
          ["n"] = { "nzz", desc = "Default function + re-center screen" },
          ["N"] = { "Nzz", desc = "Default function + re-center screen" },
          ["{"] = { "{zz", desc = "Default function + re-center screen" },
          ["}"] = { "}zz", desc = "Default function + re-center screen" },
          ["*"] = { "*zz", desc = "Default function + re-center screen" },
          ["#"] = { "#zz", desc = "Default function + re-center screen" },

          ["%"] = { "%zz", desc = "Default function + re-center screen" },
          ["<C-d>"] = { "<C-d>zz", desc = "Default function + re-center screen" },
        },
        i = {
          ["<C-l>"] = { function() require("luasnip").jump(1) end, desc = "Jump to next snippet placeholder" },
          ["<C-h>"] = { function() require("luasnip").jump(-1) end, desc = "Jump to previous snippet placeholder" },
        },
        v = {
          ["<C-c>"] = { "y", desc = "Copy" },
          ["<C-v>"] = { "P", desc = "Paste but don't clobber register" },
        },
        t = {
          ["<F1>"] = { "<C-\\><C-n>:ToggleTerm direction=float<cr>", desc = "npm run dev" },
        },
      },
    },
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          ["<Leader>k"] = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
