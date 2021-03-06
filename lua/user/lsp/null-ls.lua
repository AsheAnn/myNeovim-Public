local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({
			extra_filetypes = {
				"toml",
				"solidity",
        "css"
			},
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote"},
		}),
		diagnostics.eslint_d.with({
			filetypes = {
				"javascript",
				"html",
				"json",
				"css",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
			},
			extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote"},
		}),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
    -- python
		formatting.yapf,
		diagnostics.flake8,
    --ruby
		formatting.rubocop,
		diagnostics.rubocop,
		formatting.erb_lint,
    diagnostics.erb_lint,
	},
})
