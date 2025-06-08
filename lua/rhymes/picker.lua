-- lua/rhymes/picker.lua
local fzf = require("fzf-lua")
local rhyme = require("rhymes.rhyme")

local M = {}

--- Open fzf-lua picker with rhymes for WORD
-- Copies selected rhyme to the '+' register
-- @param word string
function M.open(word)
	local list = rhyme.get_rhymes(word)
	if #list == 0 then
		vim.notify("No rhymes found for: " .. word, vim.log.levels.WARN)
		return
	end

	fzf.fzf_exec(list, {
		prompt = "Rhymes: ",
		actions = {
			["default"] = function(selected)
				local w = selected[1]
				vim.fn.setreg("+", w)
				vim.notify("Copied rhyme: " .. w, vim.log.levels.INFO)
			end,
		},
	})
end

return M
