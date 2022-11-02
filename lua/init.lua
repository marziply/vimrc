local dir = 'modules'
local modules = {
	'bootstrap',
	'plugins',
}

function src(path)
	vim.cmd('so ' .. vim.g.nvim_dir .. '/' .. path)
end

for _, name in ipairs(modules) do
	local path = dir .. '.' .. name
	local ok, err = pcall(require, path)
	local report = vim.api.nvim_error_writeln

	if ok then
		require(path)
	else
		report('Error in module "' .. path .. '": ' .. err .. '\n\n')
	end
end