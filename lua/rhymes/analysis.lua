-- lua/rhymes/analysis.lua
local M = {}

--- Analyze poem structure: line count, stanza count (blank lines), naive rhyme scheme
-- @param bufnr number
-- @return table { lines=number, stanzas=number, rhyme_scheme=table }
function M.analyze_poem(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	local stanzas = 1
	for _, ln in ipairs(lines) do
		if ln == "" then
			stanzas = stanzas + 1
		end
	end
	local scheme = {}
	for i, ln in ipairs(lines) do
		scheme[i] = ln:sub(-3)
	end
	return { lines = #lines, stanzas = stanzas, rhyme_scheme = scheme }
end

return M
