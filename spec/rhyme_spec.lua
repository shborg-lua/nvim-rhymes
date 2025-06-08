-- spec/rhyme_spec.lua
local rhyme = require("rhymes.rhyme")

describe("rhyme.get_rhymes", function()
	it("returns a table for a valid word", function()
		local res = rhyme.get_rhymes("time")
		assert.is_true(type(res) == "table")
	end)
end)
