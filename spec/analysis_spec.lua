-- spec/analysis_spec.lua
local analysis = require("rhymes.analysis")

describe("analysis.analyze_poem", function()
	it("counts lines and stanzas correctly", function()
		vim.cmd("new")
		vim.api.nvim_buf_set_lines(0, 0, -1, false, { "a", "", "b" })
		local res = analysis.analyze_poem(0)
		assert.equals(res.lines, 3)
		assert.equals(res.stanzas, 2)
		vim.cmd("bd!")
	end)
end)
