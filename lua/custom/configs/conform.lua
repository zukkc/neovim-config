local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "eslint_d", "prettierd" },
    javascriptreact = { "eslint_d", "prettierd" },
    typescript = { "eslint_d", "prettierd" },
    typescriptreact = { "eslint_d", "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    html = { "prettierd" },
    css = { "prettierd" },
    scss = { "prettierd" },
    less = { "prettierd" },
    cpp = { "clang_format" },
    c = { "clang_format" },
    objc = { "clang_format" },
    objcpp = { "clang_format" },
    java = { "google_java_format" },
    kotlin = { "ktlint" },
    swift = { "swiftformat" },
  },

  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
