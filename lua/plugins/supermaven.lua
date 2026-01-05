return {
  "supermaven-inc/supermaven-nvim",
  enabled = vim.loop.os_uname().sysname ~= "Windows_NT" and jit.arch ~= "arm64",
  config = function()
    require("supermaven-nvim").setup {
      log_level = "off",
    }
  end,
}
