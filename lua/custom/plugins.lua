local function ensure(list, values)
  list = list or {}

  for _, value in ipairs(values) do
    if not vim.tbl_contains(list, value) then
      table.insert(list, value)
    end
  end

  return list
end

return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "custom.configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "custom.configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.registries = ensure(opts.registries, {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      })
      opts.ensure_installed = ensure(opts.ensure_installed, {
        "clangd",
        "clang-format",
        "jdtls",
        "kotlin-language-server",
        "ktlint",
        "roslyn",
        "typescript-language-server",
        "eslint_d",
        "prettierd",
        "tailwindcss-language-server",
        "emmet-language-server",
        "json-lsp",
        "html-lsp",
        "css-lsp",
        "sourcekit",
        "swiftlint",
        "swiftformat",
        "google-java-format",
        "stylua",
        "lua-language-server",
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = ensure(opts.ensure_installed, {
        "bash",
        "c",
        "cpp",
        "css",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "objc",
        "python",
        "regex",
        "swift",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "java",
      })
    end,
  },

  { "b0o/schemastore.nvim", lazy = true },

  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "csx" },
    opts = {},
    config = function(_, opts)
      require("roslyn").setup(opts)
    end,
  },

  {
    "coffebar/neovim-project",
    opts = {
      projects = {
        "~/projects/*",
        "~/.config/*",
      },
      picker = {
        type = "telescope",
      }
    },
    init = function()
      vim.opt.sessionoptions:append("globals")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
      { "ibhagwan/fzf-lua" },
      { "folke/snacks.nvim" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },

  {
    "ray-x/web-tools.nvim",
    lazy = false,
    config = function()
      require("web-tools").setup({})
    end,
  },
}
