return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          -- ["<C-p>"] = { function() require("telescope.builtin").find_files() end, desc = "Go to file" },
          ["<F1>"] = { ":ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
          ["<F4>"] = { ":TermExec cmd='npm run dev'<cr>", desc = "npm run dev" },
          ["gt"] = {
            function() require("astrocore.buffer").nav(vim.v.count1) end,
            desc = "Next buffer",
          },
          ["gT"] = {
            function() require("astrocore.buffer").nav(-vim.v.count1) end,
            desc = "Previous buffer",
          },
          ["<C-J>"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
          ["<C-K>"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
          ["H"] = { "^", desc = "beginning of line" },
          ["L"] = { "$", desc = "end of line" },
          ["J"] = { "<C-e><C-e>", desc = "Scroll screen down" },
          ["K"] = { "<C-y><C-y>", desc = "Scroll screen up" },
          ["Q"] = { "@q", desc = "Quick execute macro" },
          ["<Tab>"] = { "%", remap = true, desc = "Go to matching pair" },
          [",v"] = { "<C-v>", desc = "Enter visual block mode" },
          ["<F2>"] = { function() vim.lsp.buf.rename() end, desc = "Rename symbol" },
          ["<Leader>,"] = { ':execute "cd " .. stdpath("config")<cr>', desc = "cd to nvim config" },
          ["<Leader>u"] = { function() vim.cmd.UndotreeToggle() end, desc = "Undo tree" },
          ["<Leader>gf"] = { "<cmd>DiffviewFileHistory %<cr>", desc = "Show file history (git commits)" },
          ["[c"] = {
            function()
              if vim.wo.diff then
                vim.cmd.normal { "]c", bang = true }
              else
                require("gitsigns").nav_hunk "prev"
              end
            end,
            desc = "Go to next git hunk",
          },
          ["]c"] = {
            function()
              if vim.wo.diff then
                vim.cmd.normal { "]c", bang = true }
              else
                require("gitsigns").nav_hunk "next"
              end
            end,
            desc = "Go to previous git hunk",
          },
          ["gr"] = {
            function() vim.lsp.buf.references() end,
            desc = "Show references",
          },
          ["<C-left>"] = {
            ":cp<cr>",
            desc = "Previous quickfix",
          },
          ["<C-right>"] = {
            ":cn<cr>",
            desc = "Next quickfix",
          },
          ["<Leader>z"] = { "<cmd>ZenMode<cr>", desc = "Show file history (git commits)" },
          ["<Leader>x"] = { ":call VrcQuery()<cr>", desc = "Execute request" },
          ["<Leader>G"] = { [[:let @+ = expand('%:~:.')<cr>]], desc = "Yank current file path" },

          --- file shortcuts
          [",es"] = {
            function()
              local os_name = vim.loop.os_uname().sysname
              if os_name == "Windows_NT" then
                vim.cmd "edit ~/scratch.txt"
              elseif os_name == "Linux" then
                vim.cmd "edit /mnt/c/Users/funor/scratch.txt"
              end
            end,
            desc = "edit mappings",
          },
          [",ev"] = {
            ':execute "edit " .. stdpath("config") .. "/lua/plugins/mappings.lua"<cr>',
            desc = "edit mappings",
          },

          --- improved default functionality
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
          ["<Tab>"] = {
            function() return vim.fn["copilot#Accept"]() end,
            expr = true,
            desc = "Copilot autocomplete",
          },
          ["<C-l>"] = { function() require("luasnip").jump(1) end, desc = "Jump to next snippet placeholder" },
          ["<C-h>"] = { function() require("luasnip").jump(-1) end, desc = "Jump to previous snippet placeholder" },
        },
        v = {
          ["H"] = { "^", desc = "beginning of line" },
          ["L"] = { "$", desc = "end of line" },
          ["<C-c>"] = { "y", desc = "Copy" },
          ["c"] = { "y", desc = "Copy" },
          ["v"] = { "P", desc = "Paste (don't clobber register)" },
        },
        x = {
          ["n"] = { "<Plug>(VM-Find-Subword-Under)", desc = "Expand multi cursor" },
          ["v"] = { "P", remap = true, desc = "Paste (don't clobber register)" },
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
