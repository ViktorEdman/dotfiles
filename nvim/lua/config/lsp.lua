require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")

--- @module "mason-lspconfig"
--- @type MasonLspconfigSettings

mason_lspconfig.setup({
	automatic_enable = true,
})

vim.lsp.config("nixd", {
	cmd = { "nixd" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", ".git" },
	settings = {
		nixd = {
			nixpkgs = {
				expr = "import <nixpkgs> { }",
			},
			formatting = {
				command = { "nixfmt" },
			},
			options = {
				nixos = {
					expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.vm.options",
				},
				home_manager = {
					expr = "(builtins.getFlake (toString ./.)).homeConfigurations.viktor.options",
				},
			},
		},
	},
})

vim.lsp.config("basedpyright", {
	cmd = { "basedpyright" },
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "main.py", "uv.lock" },
})

vim.lsp.enable("nixd")
vim.lsp.enable("basedpyright")
vim.lsp.enable("lua_ls")
