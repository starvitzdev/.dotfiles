return {
	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<F11>', builtin.find_files, { desc = 'Telescope find files', remap = true })
		vim.keymap.set('n', '<c-`>', function()
			require('telescope.builtin').find_files {
				cwd = vim.fn.stdpath("config")
			}
			end, { remap = true })
		vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
		vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
	end
}

