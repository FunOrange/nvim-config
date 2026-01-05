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

return {
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      if opts.ensure_installed then
        remove_string_from_list(opts.ensure_installed, "stylua")
        remove_string_from_list(opts.ensure_installed, "selene")
      end
    end,
  },
}
