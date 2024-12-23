local finder_plugins = {}

if vim.fn.executable('make') == 1 and vim.fn.executable('gcc') == 1 then
	table.insert(finder_plugins, {
		'nvim-telescope/telescope.nvim',
		lazy = false,
		dependencies = {
			'nvim-lua/plenary.nvim',
			'nvim-tree/nvim-web-devicons',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
			},
			'nvim-telescope/telescope-live-grep-args.nvim',
		},
		config = function()
			local telescope = require('telescope')
			local lga_actions = require('telescope-live-grep-args.actions')
			telescope.setup({
				defaults = {
					vimgrep_arguments = {
						-- default telescope's vimgrep_arguments
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',

						-- unset --binary in ~/.ripgreprc
						'--no-binary',
					},
					file_ignore_patterns = {
						'^.git/',
						'^node_modules/',
					},
					mappings = {
						i = {
							['<c-h>'] = 'which_key',
						},
					},
				},
				winblend = 20,
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = 'smart_case',
					},
					live_grep_args = {
						auto_quoting = true,
						mappings = {
							i = {
								['<c-l>'] = lga_actions.quote_prompt(),
							},
						},
					},
				},
			})

			local h = require('helpers.map')
			local builtin = require('telescope.builtin')
			local lga_shortcuts = require('telescope-live-grep-args.shortcuts')
			h.nmap('<leader>ff', builtin.find_files)
			-- h.nmap('<leader>fg', builtin.live_grep)
			h.nmap('<leader>fb', builtin.buffers)
			h.nmap('<leader>fh', builtin.help_tags)
			h.nmap('<leader>fg', telescope.extensions.live_grep_args.live_grep_args)
			h.nmap('<leader>fc', lga_shortcuts.grep_word_under_cursor)
			h.nmap('<leader>fp', telescope.extensions.projects.projects)

			telescope.load_extension('fzf')
			telescope.load_extension('live_grep_args')
			telescope.load_extension('projects')
		end,
	})
else
	vim.api.nvim_echo({
		{ "Failed to build telescope.nvim: Command not found: make, gcc", "Comment" },
	}, true, {})
end

return finder_plugins
