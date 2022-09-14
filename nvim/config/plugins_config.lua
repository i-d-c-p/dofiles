---	MASON
require("mason").setup()
require("mason-lspconfig").setup()

--- TODOS CONFIGURATION
require("todo-comments").setup {}

--- COMMENTS CONFIG
require('Comment').setup()

--- ADD TREESITTER CONFIG
require'nvim-treesitter.configs'.setup {
	--ensure_installed = { "go" },

	sync_install = false,

	auto_install = true,

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

--- SETUP SNIPPETS
require'luasnip'.filetype_extend("go", {"go"})

--- SETUP CMP  
local cmp = require'cmp'

cmp.setup({
	snippet = {
		--- REQUIRED
		expand = function(args)
			require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }), --- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
	}, {
		{ name = 'buffer' },
	})
})

--- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'cmp_git' },
	}, {
		{ name = 'buffer' },
	})
})

--- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

--- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

--- SETUP LSP
vim.api.nvim_create_autocmd("BufWritePre",
	{ pattern = { "*.go", "*.py"}, command = "lua vim.lsp.buf.formatting()"}
)

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
capabilities.textDocument.completion.completionItem.snippetSupport = true

--- SETUP GOLANG 
require'lspconfig'.gopls.setup{
	capabilities = capabilities,
	settings = {
	      gopls = {
		      experimentalPostfixCompletions = true,
		      analyses = {
		        unusedparams = true,
		        shadow = true,
		     },
		     staticcheck = true,
		 },
	},

	on_attach = function()
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
		vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, {buffer=0})
		vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {buffer=0})
		vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, {buffer=0})
		vim.keymap.set('n', '<leader>cr', vim.lsp.buf.formatting, {buffer=0})
	end,
}

--- SETUP PYTHON
require'lspconfig'.pyright.setup{
	capabilities = capabilities,
}

--- SETUP DAP
vim.keymap.set("n", "<F1>", ":lua require'dap'.continue()<cr>")
vim.keymap.set("n", "<F2>", ":lua require'dap'.step_into()<cr>")
vim.keymap.set("n", "<F3>", ":lua require'dap'.step_over()<cr>")
vim.keymap.set("n", "<F4>", ":lua require'dap'.step_out()<cr>")
vim.keymap.set("n", "<F5>", ":lua require'dap'.disconnect()<cr> :lua require'dap'.close()<cr>")
vim.keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<cr>")
vim.keymap.set("n", "<leader>B", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition:'))<cr>")

require("nvim-dap-virtual-text").setup()
require("dapui").setup()
require("dap-go").setup()

local dap, dapui = require("dap"), require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

--- THEME SETUP

-- require("tint").setup()
local sign = vim.fn.sign_define

sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = ""})
sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = ""})
sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = ""})

