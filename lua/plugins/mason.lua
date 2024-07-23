-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

function print_table(tbl, indent)
  indent = indent or 0
  local formatting = string.rep("  ", indent)

  for key, value in pairs(tbl) do
    if type(value) == "table" then
      print(formatting .. tostring(key) .. ":")
      print_table(value, indent + 1)
    else
      print(formatting .. tostring(key) .. ": " .. tostring(value))
    end
  end
end

function remove_string_from_list(list, str)
  for i = #list, 1, -1 do
    if list[i] == str then table.remove(list, i) end
  end
end

-- Customize Mason plugins

---@type LazySpec
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = function(_, opts)
      print "ensure_installed (before):"
      print_table(opts.ensure_installed)

      remove_string_from_list(opts.ensure_installed, "emmet_ls")
      print "ensure_installed (after):"
      print_table(opts.ensure_installed)
    end,
  },
}
