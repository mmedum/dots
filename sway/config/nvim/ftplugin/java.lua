-- Add extended capabilities
local capabilities = require("lsp.handlers").capabilities

local status_cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_cmp_ok then
	return
end

-- jdtls setup
local status, jdtls = pcall(require, "jdtls")
if not status then
	return
end

local home = os.getenv("HOME")
WORKSPACE_PATH = home .. "/.workspace/"
CONFIG = "linux"

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
	return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = WORKSPACE_PATH .. project_name

-- Java DAP
local bundles = {}
local mason_path = vim.fn.glob(vim.fn.stdpath("data") .. "/mason/", 1)
vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar", 1), "\n"))
vim.list_extend(
	bundles,
	vim.split(
		vim.fn.glob(
			mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
			1
		),
		"\n"
	)
)

local cmd = {
	"java",
	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	"-Dosgi.bundles.defaultStartLevel=4",
	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	"-Dlog.protocol=true",
	"-Dlog.level=ALL",
	"-javaagent:" .. home .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar",
	"-Xms1g",
	"--add-modules=ALL-SYSTEM",
	"--add-opens",
	"java.base/java.util=ALL-UNNAMED",
	"--add-opens",
	"java.base/java.lang=ALL-UNNAMED",
	"-jar",
	vim.fn.glob(home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar", 1),
	"-configuration",
	home .. "/.local/share/nvim/mason/packages/jdtls/config_" .. CONFIG,
	"-data",
	workspace_dir,
}

local settings = {
	java = {
		-- jdt = {
		--   ls = {
		--     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G -Xms100m"
		--   }
		-- },
		eclipse = {
			downloadSources = true,
		},
		configuration = {
			updateBuildConfiguration = "interactive",
		},
		maven = {
			downloadSources = true,
		},
		implementationsCodeLens = {
			enabled = true,
		},
		referencesCodeLens = {
			enabled = true,
		},
		references = {
			includeDecompiledSources = true,
		},
		format = {
			enabled = false,
		},
		inlayHints = {
			parameterNames = {
				enabled = "all", -- literals, all, none
			},
		},
	},
	signatureHelp = { enabled = true },
	completion = {
		favoriteStaticMembers = {
			"org.hamcrest.MatcherAssert.assertThat",
			"org.hamcrest.Matchers.*",
			"org.hamcrest.CoreMatchers.*",
			"org.junit.jupiter.api.Assertions.*",
			"java.util.Objects.requireNonNull",
			"java.util.Objects.requireNonNullElse",
			"org.mockito.Mockito.*",
		},
	},
	contentProvider = { preferred = "fernflower" },
	extendedClientCapabilities = extendedClientCapabilities,
	sources = {
		organizeImports = {
			starThreshold = 9999,
			staticStarThreshold = 9999,
		},
	},
	codeGeneration = {
		toString = {
			template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
		},
		useBlocks = true,
	},
}

local flags = {
	allow_incremental_sync = true,
	debounce_text_changes = 150,
	server_side_fuzzy_completion = true,
}

local config = {
	cmd = cmd,
	on_attach = require("lsp.handlers").on_attach,
	capabilities = capabilities,
	root_dir = root_dir,
	settings = settings,
	flags = flags,
	init_options = {
		bundles = bundles,
	},
}

-- Refresh codelens after write
--vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--	pattern = { "*.java" },
--	callback = function()
--		vim.lsp.codelens.refresh()
--	end,
--})

-- Start language server
jdtls.start_or_attach(config)

vim.cmd(
	"command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
)
vim.cmd(
	"command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)"
)
vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
vim.cmd("command! -buffer JdtJol lua require('jdtls').jol()")
vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

keymap("n", "<leader>jo", "<Cmd>lua require'jdtls'.organize_imports()<CR>", opts)
keymap("n", "<leader>jv", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
keymap("n", "<leader>jc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
keymap("n", "<leader>jm", "<Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
keymap("n", "<leader>tm", "<Cmd>lua require'jdtls'.test_nearest_method()<CR>", opts)
keymap("n", "<leader>tc", "<Cmd>lua require'jdtls'.test_class()<CR>", opts)
keymap("n", "<leader>ju", "<Cmd>JdtUpdateConfig<CR>", opts)

keymap("v", "<leader>jv", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)
keymap("v", "<leader>jc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)
keymap("v", "<leader>jm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)
