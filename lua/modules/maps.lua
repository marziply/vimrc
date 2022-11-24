local utils = require('modules.utils')

local function map(kind, bind, cmd, opts)
	return vim.api.nvim_set_keymap(kind, bind, cmd, opts or {})
end

local function map_telescope(char, opt)
  local bind = '<c-f>' .. char
  local cmd = '<cmd>Telescope ' .. opt .. '<cr>'

  nmap(bind, cmd)
end

function nmap(bind, cmd, opts)
	return map('n', bind, cmd, opts)
end

function vmap(bind, cmd, opts)
	return map('v', bind, cmd, opts)
end

function imap(bind, cmd, opts)
	return map('i', bind, cmd, opts)
end

function nmap_all(binds)
  for bind, cmd in pairs(binds) do
    nmap(bind, cmd)
  end
end

function nmap_with_all(binds)
  for bind, fn in pairs(binds) do
    nmap_with(bind, fn)
  end
end

function nmap_with(bind, fn)
	return vim.keymap.set('n', bind, fn)
end

function vmap_with(bind, fn)
  return vim.keymap.set('v', bind, fn)
end

-- General
nmap('<esc>', ':echo<cr>', {
	silent = true
})
nmap('<c-f>', '<nop>')
nmap('<c-s>', ':w<cr>')
nmap('<c-q>', ':bd<cr>')
nmap('<c-k>', '10<c-y>')
nmap('<c-j>', '10<c-e>')
nmap('<c-o>', '<c-o>zz')
nmap('<c-i>', '<c-i>zz')
nmap('<c-m>o', 'o<esc>o')
nmap('<c-m>O', 'O<esc>O')
nmap('Y', 'i_<esc>r')
nmap('n', 'nzz')
nmap('N', 'Nzz')
nmap('H', 'Hzz')
nmap('L', 'Lzz')
nmap('G', 'Gzz')
nmap('*', '*zz')
nmap('v[', 'V$%o$')
nmap('v]', '$%V%o$')
nmap('mo', 'o<esc>')
nmap('mO', 'O<esc>')
nmap('gcs', 'v[gc')
nmap('gcS', 'v]gc')

-- Utils
nmap_with('<c-g>z', function() utils.configure_zsh() end)

-- LSP
nmap_with('<c-g>d', function() vim.diagnostic.open_float() end)
nmap_with('[d', function()
  vim.diagnostic.goto_prev {
    severity = vim.diagnostic.severity.ERROR
  }
end)
nmap_with(']d', function()
  vim.diagnostic.goto_next {
    severity = vim.diagnostic.severity.ERROR
  }
end)

-- Barbar / buffers
nmap('<c-b>', '<cmd>BufferPick<cr>')
nmap('<c-n>', '<cmd>BufferNext<cr>')
nmap('<c-p>', '<cmd>BufferPrevious<cr>')
nmap('<a->>', '<cmd>BufferMoveNext<cr>')
nmap('<a-<>', '<cmd>BufferMovePrevious<cr>')
nmap('<c-g>q', ':bufdo bd!<cr>')
nmap('Q', '<cmd>BufferClose!<cr>')

-- Telescope
map_telescope('p', 'find_files')
map_telescope('f', 'live_grep theme=dropdown')
map_telescope('h', 'command_history theme=dropdown')
map_telescope('s', 'search_history theme=dropdown')
map_telescope('c', 'spell_suggest theme=get_cursor')
map_telescope('m', 'man_pages')
map_telescope('r', 'registers theme=dropdown')
map_telescope('*', 'grep_string')
map_telescope('lD', 'diagnostics')
map_telescope('ld', 'diagnostics bufnr=0')
map_telescope('lr', 'lsp_references')
map_telescope('li', 'lsp_implementations')
map_telescope('lg', 'lsp_definitions')
map_telescope('gc', 'git_commits')
map_telescope('gb', 'git_branches')
map_telescope('gs', 'git_status')

-- ToggleTerm
nmap('<c-g>t', '<cmd>ToggleTerm<cr>')

-- Renamer
nmap_with('<c-g>r', function()
  utils.exec_from('renamer', function(r) r.rename() end)
end)

nmap_with('<c-g>s', function()
  local word = vim.fn.expand('<cword>')

  utils.popup_substitute(word)
end)

vmap_with('<c-r>', function()
  vim.cmd('normal! "vy"')

  utils.popup_substitute(vim.fn.getreg('v'))
end)

return {
	nmap = nmap,
	vmap = vmap,
	imap = imap,
  nmap_all = nmap_all,
	nmap_with = nmap_with,
  nmap_with_all = nmap_with_all
}
