local ulf = {}
ulf.lib = require("ulf.lib")

local OUT_FILE = ".ai-update"
---@type string[]
local LINES = {}
local project_name = "b64tm"
local function write_prompt()
	local prompt = [[
Context: You are a Neovim plugin developer with exceptional skills in Lua, C and Javascript.

Communication Rules
You never respond automatically, even if the user submits code or other content. You always 
wait for an explicit request before completing a task or responding or guessing the intention of the user. 
When you present code you always show a reference which is an URL from which you learned code or 
used the code.

Project Goals
Write a Neovim plugin for helping the user to write lyrics or poams.

The first milestone is to create deployment commandlets in order to deploy versioned packages which might
be VST plugins, presets or other media assets.

The markdown DEV.md contains the current deployment state and is the source of truth for communication with
ChatGPT.

When you receive “AI_UPDATE,” you access the entire codebase of a local Git repository, which 
represents the project you are working on. The next message is an initial AI_UPDATE.
]]

	for line in prompt:gmatch("([^\n]*)\n?") do
		table.insert(LINES, line)
	end
end

local function generate_repo_tree()
	LINES[#LINES + 1] = string.format("-- REPOSITORY FILES")
	local handle = io.popen("tree .")
	if not handle then
		return
	end
	local result = handle:read("*a")
	for line in result:gmatch("([^\n]*)\n?") do
		table.insert(LINES, line)
	end

	handle:close()
end
local function generate_message()
	local function process_file(path, name, type)
		LINES[#LINES + 1] = string.format("-- >>>>>>>>>>>>>>>>>> BEGIN FILE %s\n", path)
		if type == "file" and name ~= "README.md" then
			local content = ulf.lib.fs.read_file(path)
			for line in content:gmatch("([^\n]*)\n?") do
				table.insert(LINES, line)
			end
		else
			LINES[#LINES + 1] = string.format("-- module directory of: %s", path)
		end

		LINES[#LINES + 1] = ""
		LINES[#LINES + 1] = string.format("-- >>>>>>>>>>>>>>>>>> BEGIN FILE %s\n", path)
	end

	local function process_dir(path)
		LINES[#LINES + 1] = string.format("AI_UPDATE\n")

		ulf.lib.fs.ls(path, function(path, name, type)
			process_file(path, name, type)
		end)
	end

	local dirs = { "doc", "lua/rhymes", "plugin", "spec" }

	for i, dir in ipairs(dirs) do
		process_dir(dir)
	end

	process_file("README.md", "README.md", "file")
	process_file("TODO.md", "TODO.md", "file")
	process_file("DEV.md", "DEV.md", "file")
	generate_repo_tree()
end
write_prompt()
generate_message()

local data = table.concat(LINES, "\n")
ulf.lib.fs.write_file(OUT_FILE, data)
