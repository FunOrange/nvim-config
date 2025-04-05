local function save_if_modified()
  if vim.bo.modified then vim.cmd "write" end
end

return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        n = {
          ["<F1>"] = { ":ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
          ["<Leader>gg"] = false, -- <Leader>tl is the only way to open lazygit
          ["<F4>"] = { ":TermExec cmd='npm run dev'<cr>", desc = "npm run dev" },
          ["gt"] = {
            function() require("astrocore.buffer").nav(vim.v.count1) end,
            desc = "Next buffer",
          },
          ["gT"] = {
            function() require("astrocore.buffer").nav(-vim.v.count1) end,
            desc = "Previous buffer",
          },
          [",s"] = { save_if_modified, desc = "Save file" },
          ["H"] = { "^", desc = "beginning of line" },
          ["L"] = { "$", desc = "end of line" },
          ["J"] = { "<C-e><C-e>", desc = "Scroll screen down" },
          ["K"] = { "<C-y><C-y>", desc = "Scroll screen up" },
          ["Q"] = { "@q", desc = "Quick execute macro" },
          [",v"] = { "<C-v>", desc = "Enter visual block mode" },
          ["<F2>"] = { function() vim.lsp.buf.rename() end, desc = "Rename symbol" },
          ["<Leader>,"] = { ':execute "cd " .. stdpath("config")<cr>', desc = "cd to nvim config" },
          ["<Leader>u"] = { function() vim.cmd.UndotreeToggle() end, desc = "Undo tree" },
          ["<Leader>gf"] = { "<cmd>DiffviewFileHistory %<cr>", desc = "Show file history (git commits)" },
          ["gr"] = {
            function() vim.lsp.buf.references() end,
            desc = "Show references",
          },
          ["<Leader>x"] = {
            function()
              vim.cmd "w"
              vim.cmd "!zig run %"
            end,
            desc = "zig run",
          },
          [",b"] = {
            function()
              save_if_modified()
              vim.cmd "make"
            end,
            desc = "save and make",
          },
          [",B"] = {
            function()
              save_if_modified()
              vim.cmd "make run"
            end,
            desc = "save and make run",
          },
          ["<Leader>z"] = { "<cmd>ZenMode<cr>", desc = "Zen mode" },
          ["<Leader>G"] = { [[:let @+ = expand('%:~:.')<cr>]], desc = "Yank current file path" },
          [";"] = { ":", desc = "Execute command" },
          [":"] = { ";", desc = "Repeat latest f, t, F or T" },
          ["<C-i>"] = { "<C-i>", desc = "Repeat latest f, t, F or T" },
          ["?"] = { "/\\M", desc = "Search backward, no regex" },
          ["zf0"] = { "zR", desc = "Reset folds" },
          ["zf1"] = { "<cmd>set foldlevel=1<cr>", desc = "Fold level 1" },
          ["zf2"] = { "<cmd>set foldlevel=2<cr>", desc = "Fold level 2" },
          ["zf3"] = { "<cmd>set foldlevel=3<cr>", desc = "Fold level 3" },
          ["zf4"] = { "<cmd>set foldlevel=4<cr>", desc = "Fold level 4" },
          ["zf5"] = { "<cmd>set foldlevel=5<cr>", desc = "Fold level 5" },
          ["zf6"] = { "<cmd>set foldlevel=6<cr>", desc = "Fold level 6" },
          ["zf7"] = { "<cmd>set foldlevel=7<cr>", desc = "Fold level 7" },
          ["zf8"] = { "<cmd>set foldlevel=8<cr>", desc = "Fold level 8" },
          ["zf9"] = { "<cmd>set foldlevel=9<cr>", desc = "Fold level 9" },
          ["<left>"] = { "<cmd>:cp<cr>", desc = "Previous quickfix item" },
          ["<right>"] = { "<cmd>:cn<cr>", desc = "Next quickfix item" },

          --- file shortcuts
          ["<C-p>"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
          [",es"] = {
            function()
              local os_name = vim.loop.os_uname().sysname
              if os_name == "Windows_NT" then
                vim.cmd "edit ~/scratch.txt"
              elseif os_name == "Darwin" then
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
          [",env"] = {
            ':execute "edit .env.local"<cr>',
            desc = "edit .env.local",
          },
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
          ["<Leader>gpt"] = { function() require("chatgpt").edit_with_instructions() end, desc = "ChatGPT" },
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
