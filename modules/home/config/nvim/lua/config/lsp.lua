require("mason").setup()

local mason_lspconfig = require("mason-lspconfig")

--- @module "mason-lspconfig"
--- @type MasonLspconfigSettings

mason_lspconfig.setup({
	automatic_enable = true,
})
