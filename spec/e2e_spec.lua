-- spec/e2e_spec.lua
local uv = vim.loop

describe("e2e: headless Neovim", function()
  local root = assert(os.getenv("PWD"), "PWD environment variable must be set to project root")

  -- helper to run a headless Neovim command and capture first line of stdout
  local function nvim_headless(cmds)
    local cmd = {
      "nvim",
      "--headless",
      "-u",
      "NONE",
      "-c",
      "set rtp+=" .. root,
    }
    for _, c in ipairs(cmds) do
      table.insert(cmd, "-c")
      table.insert(cmd, c)
    end
    table.insert(cmd, "-c")
    table.insert(cmd, "qa")
    local handle = io.popen(table.concat(cmd, " "))
    local out = handle:read("*l")
    handle:close()
    return out
  end

  it("fetches rhymes via the Lua API", function()
    local out = nvim_headless({
      [[lua print(#require("rhymes.rhyme").get_rhymes("time"))]],
    })
    local count = tonumber(out)
    assert.is_number(count)
    assert.is_true(count > 0)
  end)

  it("analyzes a simple poem", function()
    -- create a buffer with 3 lines, two stanzas
    local poem = [[
new
lua vim.api.nvim_buf_set_lines(0, 0, -1, false, {"a","", "b"})
lua local res = require("rhymes.analysis").analyze_poem(0)
lua print(res.lines .. "," .. res.stanzas)
]]
    local cmds = vim.split(poem, "\n")
    -- run headless commands
    local out = nvim_headless(cmds)
    assert.equals("3,2", out)
  end)
end)
