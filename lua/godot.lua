local function find_godot_project_root()
	local cwd = vim.fn.getcwd()
	local search_paths = { "", "/.." }

	for _, relative_path in ipairs(search_paths) do
		local project_file = cwd .. relative_path .. "/project.godot"
		if vim.uv.fs_stat(project_file) then
			return cwd .. relative_path
		end
	end

	return nil
end

local pipe_path = "\\\\.\\pipe\\nvim-pipe-1234"

local function is_server_running(project_path)
	local server_pipe = project_path .. pipe_path
	return vim.uv.fs_stat(server_pipe) ~= nil
end

local function start_godot_server_if_needed()
	local godot_project_path = find_godot_project_root()

	if godot_project_path and not is_server_running(godot_project_path) then
		vim.fn.serverstart(pipe_path)

		local lspconfig = require("lspconfig")
		lspconfig.gdscript.setup({})

		return true
	end

	return false
end

start_godot_server_if_needed()
