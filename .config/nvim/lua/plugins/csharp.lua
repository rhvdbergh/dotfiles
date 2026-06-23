return {
  -- Disable OmniSharp — replaced by Roslyn
  { "Hoffs/omnisharp-extended-lsp.nvim", enabled = false },
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = { enabled = false },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { lsp_format = "prefer" },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "cs",
        callback = function()
          vim.bo.shiftwidth = 4
          vim.bo.tabstop = 4
        end,
      })
    end,
  },

  -- Roslyn LSP (native C# language server, replaces OmniSharp)
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    dependencies = { "mason-org/mason.nvim" },
    -- init runs at startup before lazy-loading, so cmd is set before vim.lsp.enable fires
    init = function()
      vim.lsp.config("roslyn", {
        cmd = { vim.fn.stdpath("data") .. "/mason/bin/roslyn", "--stdio" },
      })
    end,
    opts = {},
    config = function(_, opts)
      require("roslyn").setup(opts)
      vim.lsp.config("roslyn", {
        settings = {
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
        },
      })
    end,
  },

}
