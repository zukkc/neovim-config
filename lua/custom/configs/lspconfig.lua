local nvchad_lsp = require "nvchad.configs.lspconfig"
local util = require "lspconfig.util"

nvchad_lsp.defaults()

local mason_bin = vim.fs.joinpath(vim.fn.stdpath("data"), "mason", "bin")
if not vim.env.PATH:find(mason_bin, 1, true) then
  vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
end

local on_attach = nvchad_lsp.on_attach
local capabilities = nvchad_lsp.capabilities

local schemastore_available, schemastore = pcall(require, "schemastore")

local function with_defaults(opts)
  opts = vim.tbl_deep_extend("force", {}, opts or {})

  if opts.capabilities then
    opts.capabilities = vim.tbl_deep_extend("force", {}, capabilities, opts.capabilities)
  end

  return vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
  }, opts)
end

local servers = {
  html = {},
  cssls = {},
  jsonls = {
    settings = {
      json = {
        schemas = schemastore_available and schemastore.json.schemas() or nil,
        validate = { enable = true },
      },
    },
  },
  emmet_ls = {
    filetypes = {
      "css",
      "html",
      "javascriptreact",
      "less",
      "scss",
      "typescriptreact",
    },
  },
  ts_ls = {
    filetypes = {
      "javascript",
      "typescript",
    },
  },
  tailwindcss = {
    filetypes = {
      "css",
      "scss",
      "javascriptreact",
      "typescriptreact",
    },
    root_dir = util.root_pattern(
      "tailwind.config.cjs",
      "tailwind.config.js",
      "tailwind.config.ts",
      "postcss.config.js",
      "postcss.config.cjs",
      "package.json",
      ".git"
    ),
    settings = {
      tailwindCSS = {
        experimental = {
          classRegex = {
            "tw`([^`]*)`",
            'tw="([^"]*)"',
            'tw={"([^"}]*)"}',
            "tw\\.\\w+`([^`]*)`",
            "clsx\\(([^)]*)\\)",
            "classnames\\(([^)]*)\\)",
          },
        },
      },
    },
  },
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=never",
      "--completion-style=detailed",
      "--function-arg-placeholders=true",
    },
    capabilities = {
      offsetEncoding = { "utf-16" },
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    init_options = { clangdFileStatus = true },
  },
  jdtls = {
    settings = {
      java = {
        configuration = {
          updateBuildConfiguration = "automatic",
        },
        format = { enabled = false },
        signatureHelp = { enabled = true },
      },
    },
  },
  kotlin_language_server = {
    settings = {
      kotlin = {
        compiler = {
          jvm = { target = "17" },
        },
      },
    },
  },
  sourcekit = {
    cmd = { "sourcekit-lsp" },
    filetypes = { "swift" },
  },
}

for server, config in pairs(servers) do
  vim.lsp.config(server, with_defaults(config))
end
vim.lsp.enable(vim.tbl_keys(servers))
