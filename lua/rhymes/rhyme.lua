-- lua/rhymes/rhyme.lua
local M = {}

-- service implementations using vim.fn.systemlist()
local service_impl = {
	datamuse = function(word)
		local cmd = string.format('curl -s "https://api.datamuse.com/words?rel_rhy=%s"', vim.fn.shellescape(word))
		local lines = vim.fn.systemlist(cmd)
		local ok, json = pcall(vim.fn.json_decode, table.concat(lines, ""))
		if not ok or type(json) ~= "table" then
			return {}
		end

		local out = {}
		for _, item in ipairs(json) do
			if item.word then
				table.insert(out, item.word)
			end
		end
		return out
	end,
	-- future: add rhymebrain, AI providers here
}

--- Get rhymes for a word across configured services
-- @param word string
-- @return table list of rhyme words
function M.get_rhymes(word)
	local seen, results = {}, {}
	for _, svc in ipairs(require("rhymes").config.services) do
		local fn = service_impl[svc]
		if fn then
			for _, rhyme in ipairs(fn(word)) do
				if not seen[rhyme] then
					seen[rhyme] = true
					table.insert(results, rhyme)
				end
			end
		end
	end
	return results
end

return M
