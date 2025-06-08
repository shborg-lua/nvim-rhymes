-- lua/rhymes/rhyme.lua
local uv = vim.loop
local M = {}

-- Simple in-memory cache
local cache = {}
local default_ttl = 60 -- seconds

-- Helper: check for curl presence
local function has_curl()
	return vim.fn.executable("curl") == 1
end

-- Helper: schedule cache eviction
local function set_cache(key, value, ttl)
	cache[key] = value
	ttl = ttl or default_ttl
	uv.new_timer():start(ttl * 1000, 0, function(timer)
		cache[key] = nil
		timer:stop()
		timer:close()
	end)
end

-- Fetch rhymes from Datamuse API
-- @param word string
-- @return table|nil list of rhymes or nil on error
local function fetch_datamuse(word)
	if not has_curl() then
		vim.notify("[nvim-rhymes] 'curl' not found; cannot fetch rhymes", vim.log.levels.ERROR)
		return {}
	end

	local cmd = string.format('curl --fail -s "https://api.datamuse.com/words?rel_rhy=%s"', vim.fn.shellescape(word))
	local ok, lines = pcall(vim.fn.systemlist, cmd)
	if not ok then
		vim.notify("[nvim-rhymes] HTTP request failed for word: " .. word, vim.log.levels.ERROR)
		return {}
	end

	local json_str = table.concat(lines, "")
	local ok2, data = pcall(vim.fn.json_decode, json_str)
	if not ok2 or type(data) ~= "table" then
		vim.notify("[nvim-rhymes] Invalid response for word: " .. word, vim.log.levels.ERROR)
		return {}
	end

	local results = {}
	for _, item in ipairs(data) do
		if item.word then
			table.insert(results, item.word)
		end
	end
	return results
end
-- Reference: Datamuse API usage example
-- https://www.datamuse.com/api/ citehttps://www.datamuse.com/api/

--- Get rhymes for a word across configured services
-- Caches results for `cache_ttl` seconds
-- @param word string
-- @return table list of unique rhyme words
function M.get_rhymes(word)
	local key = word:lower()
	if cache[key] then
		return cache[key]
	end

	--- Only 'datamuse' supported for now
	local rhymes = fetch_datamuse(word)

	-- Deduplicate
	local seen, uniq = {}, {}
	for _, w in ipairs(rhymes) do
		if not seen[w] then
			seen[w] = true
			table.insert(uniq, w)
		end
	end

	set_cache(key, uniq, M.config and M.config.cache_ttl or default_ttl)
	return uniq
end

return M
