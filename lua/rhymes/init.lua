-- lua/rhymes/init.lua
local M = {}

--- Setup plugin configuration
-- @param opts table: { services = { ... }, enable_analysis = bool }
function M.setup(opts)
	M.config = vim.tbl_extend("force", {
		services = { "datamuse" },
		enable_analysis = false,
	}, opts or {})

	-- future: if M.config.enable_analysis then register null-ls source end
end

return M
