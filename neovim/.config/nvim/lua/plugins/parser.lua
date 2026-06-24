local parser_plugins = {}

if ((vim.fn.executable('gcc') == 1) or (vim.fn.executable('clang') == 1))
	and (vim.fn.executable('tree-sitter') == 1) then

	table.insert(parser_plugins, {
		'nvim-treesitter/nvim-treesitter',
		branch = 'main',
		lazy = false,
		build = ':TSUpdate',
		config = function()
			require('nvim-treesitter').setup({
				ensure_installed = {
					'astro',
					'awk',
					'bash',
					'c',
					'cmake',
					'cpp',
					'css',
					'csv',
					'diff',
					'disassembly',
					'dockerfile',
					'git_config',
					'git_rebase',
					'gitattributes',
					'gitcommit',
					'gitignore',
					'go',
					'gomod',
					'gosum',
					'graphql',
					'groovy',
					'html',
					'http',
					'java',
					'javadoc',
					'javascript',
					'jq',
					'json',
					'julia',
					'just',
					'kotlin',
					'lua',
					'make',
					'markdown',
					'markdown_inline',
					'mermaid',
					'nginx',
					'nix',
					'php',
					'phpdoc',
					'powershell',
					'python',
					'regex',
					'requirements',
					'ruby',
					'rust',
					'scss',
					'sql',
					'ssh_config',
					'strace',
					'toml',
					'tsv',
					'tsx',
					'typescript',
					'vim',
					'vimdoc',
					'vue',
					'xml',
					'yaml',
					'zsh',
				},
				auto_install = true,
				highlight = {
					enable = true,
					disable = {},
				},
				indent = {
					enable = true,
					disable = {
						"lua",
						"markdown",
					},
				},
			})
		end,
	})
else
	vim.schedule(function()
		vim.api.nvim_echo({
			{ "nvim-treesitter: command not found: gcc or clang or tree-sitter", "Comment" },
		}, true, {})
	end)
end

return parser_plugins
