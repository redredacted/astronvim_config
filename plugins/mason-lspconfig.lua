return { -- overrides `require("mason-lspconfig").setup(...)`
  ensure_installed = {
    "sumneko_lua",
    "rust-analyzer",
    "omnisharp",
    "bash",
    "cssls",
    "dockerls",
    "graphql",
    "html",
    "jsonls",
    "sqlls",
    "yamlls",
  },
}
