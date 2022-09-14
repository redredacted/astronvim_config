return {
  on_attach = function(_, bufnr)
    local rt = require "rust-tools"
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
  end,
  checkOnSave = {
    overrideCommand = {
      "cargo",
      "clippy",
      "--workspace",
      "--message-format=json",
      "--all-targets",
      "--all-features",
    },
  },
}
