require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")

--- @module "mason-lspconfig"
--- @type MasonLspconfigSettings
local config_opts = {
	automatic_enable = {
		exclude = {
			"ruff",
		},
	},
}
mason_lspconfig.setup(config_opts)

vim.lsp.config("basedpyright", {
	settings = {
		basedpyright = {
			analysis = {
				typeCheckingMode = "standard",
				reportAny = false,
				reportExplicitAny = false,
			},
		},
	},
})

vim.lsp.config("nil_ls", {
	settings = {
		nil_ls = {
			nix = {
				binary = "nix",
				flake = {
					autoEvalInputs = false,
					nixpkgsInputName = "nixpkgs",
				},
			},
		},
	},
})
