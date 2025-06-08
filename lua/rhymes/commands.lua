-- lua/rhymes/commands.lua
local M = {}
local picker = require("rhymes.picker")
local analysis = require("rhymes.analysis")

--- Entry point for :Rhymes
-- @param action string: 'find' or 'analyze'
-- @param ...    varargs
function M.run(action, ...)
	if action == "find" then
		local word = select(1, ...)
		if not word or word == "" then
			print("Usage: :Rhymes find <word>")
			return
		end
		picker.open(word)
	elseif action == "analyze" then
		local buf = vim.api.nvim_get_current_buf()
		local res = analysis.analyze_poem(buf)
		print(string.format("Lines: %d, Stanzas: %d", res.lines, res.stanzas))
	else
		print("Usage: :Rhymes find <word> | :Rhymes analyze")
	end
end

return M
