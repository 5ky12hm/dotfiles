local h = require('helpers.map')

local utils_plugins = {}

table.insert(utils_plugins, {
	{
		'numToStr/Comment.nvim',
		lazy = false,
		config = function()
			require('Comment').setup()
			-- h.nmap('<leader>c', 'gcc', {})
			-- h.vmap('<leader>c', 'gc', {})
			vim.api.nvim_set_keymap('n', '<leader>c', 'gcc', {})
			vim.api.nvim_set_keymap('v', '<leader>c', 'gc', {})
		end,
	},
	{
		'lukas-reineke/indent-blankline.nvim',
		lazy = false,
		config = function()
			local highlight = {
				'CursorColumn',
				'Whitespace',
			}
			require('ibl').setup({
				indent = {
					highlight = highlight,
					char = '',
				},
				whitespace = {
					highlight = highlight,
				},
				scope = {
					enabled = false,
				},
			})
		end,
	},
	{
		"m00qek/baleia.nvim",
		lazy = false,
		config = function()
			vim.g.baleia = require("baleia").setup({})

			-- Command to colorize the current buffer
			vim.api.nvim_create_user_command("BaleiaColorize", function()
				vim.g.baleia.once(vim.api.nvim_get_current_buf())
			end, { bang = true })

			-- Command to show logs
			vim.api.nvim_create_user_command("BaleiaLogs", vim.g.baleia.logger.show, { bang = true })
		end,
	},
	{
		'windwp/nvim-autopairs',
		event = 'InsertEnter',
		config = function()
			require('nvim-autopairs').setup()

			-- local npairs = require('nvim-autopairs')
			-- -- TODO: bs overwrite bullets.vim bs
			-- npairs.setup({
			-- 	map_bs = false,
			-- })
			-- h.imap('<bs>', npairs.autopairs_bs(), { expr = true, noremap = true, silent = true })

			h.imap('<c-f>', '<c-g>U<right>')
		end,
	},
})

if vim.fn.executable('gcc') == 1 then
	table.insert(utils_plugins, {
		'nvim-treesitter/nvim-treesitter',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter.configs').setup({
				ensure_installed = {
					'bash',
					'c',
					'css',
					'csv',
					'go',
					'groovy',
					'html',
					'java',
					'javascript',
					'json',
					'lua',
					'markdown',
					'markdown_inline',
					'python',
					'rust',
					'scss',
					'tsx',
					'typescript',
					'vim',
					'vimdoc',
					'nix',
					'yaml',
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	})
else
	vim.api.nvim_echo({
		{ "Failed to build nvim-treesitter: Command not found: gcc", "Comment" },
	}, true, {})
end

return utils_plugins
