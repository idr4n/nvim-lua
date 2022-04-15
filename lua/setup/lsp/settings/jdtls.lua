local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.env.TMPDIR .. 'workspace/' .. project_name
local _, jdtls_server = require("nvim-lsp-installer.servers").get_server("jdtls")
local new_cmd = jdtls_server:get_default_options().cmd
new_cmd[#new_cmd] = workspace_dir

-- for k, v in pairs(root_dir) do
--   print(k)
--   print(v)
-- end

return {
  cmd = new_cmd,
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
}
