local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	},
	"nvim-telescope/telescope-ui-select.nvim",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		opts = {},
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	"neovim/nvim-lspconfig",

	{
		"folke/lazydev.nvim",
		dependencies = {
			"saghen/blink.lib",
		},
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},

	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>?",
				function()
					require("which-key").show({ global = false })
				end,
				desc = "Buffer Local Keymaps (which-key)",
			},
		},
	},
	{ -- optional blink completion source for require statements and module annotations
		"saghen/blink.cmp",
		dependencies = {
			"saghen/blink.lib",
			"rafamadriz/friendly-snippets",
		},
		build = function()
			require("blink.cmp").build():wait(60000)
		end,
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			--- @type blink.cmp.KeymapConfig
			keymap = {
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
			},
			sources = {
				-- add lazydev to your completion providers
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		version = "*",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local telescope = require("telescope")

			telescope.setup({
				extensions = {
					file_browser = {
						hidden = true,
						hijack_netrw = true,
						initial_mode = "insert",
					},
				},
			})
			telescope.load_extension("file_browser")
			telescope.load_extension("ui-select")
		end,
	},
	{
		"romus204/tree-sitter-manager.nvim",
		config = function()
			require("tree-sitter-manager").setup({
				auto_install = true,
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				python = { "black" },
				lua = { "stylua" },
				nix = { "nixfmt" },
			},
			format_on_save = {
				async = false,
				timeout_ms = 1000,
				lsp_fallback = true,
			},
		},
	},
	-- {
	-- 	"scottmckendry/cyberdream.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		local cyberdream = require("cyberdream")
	-- 		--- @module "cyberdream.nvim"
	-- 		--- @type cyberdream.Config
	-- 		local opts = {
	-- 			saturation = 0.8,
	-- 			terminal_colors = false,
	-- 		}
	-- 		cyberdream.setup(opts)
	-- 		vim.cmd.colorscheme("cyberdream")
	-- 	end,
	-- },
	"nvim-mini/mini.surround",
	"nvim-mini/mini.ai",
	"nvim-mini/mini.comment",
	"nvim-mini/mini.trailspace",
	"nvim-mini/mini.indentscope",
	{
		"nvim-lualine/lualine.nvim",
		--- @module "lualine"
		--- @type
		opts = {
			theme = "nightfly",
			sections = {
				lualine_x = {
					{
						function()
							local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
							if #buf_clients == 0 then
								return "No active LSP"
							end
							local client_names = {}
							for _, client in pairs(buf_clients) do
								table.insert(client_names, client.name)
							end
							return "LSP: " .. table.concat(client_names, ", ")
						end,
						icon = "",
						color = { gui = "bold" },
					},
					"encoding",
					"fileformat",
					"filetype",
				},
			},
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"arkav/lualine-lsp-progress",
		},
	},
	{
		"benomahony/uv.nvim",
		--- @module "uv"
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		opts = {
			auto_activate_venv = true,
			picker_integration = true,
		},
		config = function(_, opts)
			local uv = require("uv")
			uv.setup(opts)
			uv.setup_keymaps()
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
})
