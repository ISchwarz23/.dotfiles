return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        endure_installed = { "lua_ls", "bashls" }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("bashls")

      vim.keymap.set("n", 'K', vim.lsp.buf.hover, {})
      vim.keymap.set("n", 'gd', vim.lsp.buf.definition, {})
      vim.keymap.set({"n", "v"}, '<space>ca', vim.lsp.buf.code_action, {})
    end
  }
}
