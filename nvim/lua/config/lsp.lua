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

vim.lsp.enable("nixd")
vim.lsp.enable("basedpyright")
vim.lsp.enable("lua_ls")
vim.lsp.enable("basedpyright")
vim.lsp.enable("jsonls")
