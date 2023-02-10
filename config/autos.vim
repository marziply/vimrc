fun! Diagnostic()
  lua << EOF
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor",
      -- severity = vim.diagnostic.severity.ERROR
    })
EOF
endfun

augroup general
  autocmd!
  autocmd BufNewFile * startinsert
augroup end

augroup filetypes
	autocmd!
	autocmd BufEnter,BufReadPost *.{njk,tera}.html,*.html.tera setl ft=htmldjango
	autocmd BufEnter,BufReadPost *.capnp setl ft=capnp
	autocmd BufEnter,BufReadPost *.sway setl ft=i3config
	autocmd BufEnter,BufReadPost *.env* setl ft=sh
	autocmd BufEnter,BufReadPost *.rs setl shiftwidth=2
	autocmd BufEnter,BufReadPost *.ts setl shiftwidth=4
augroup end

augroup vim_config
	autocmd!
	autocmd BufWritePost */nvim/config/*.vim lua src('init.vim')
augroup end

augroup packer_config
	autocmd!
	autocmd BufWritePost */nvim/*.lua so % | PackerCompile
augroup end

augroup cargo_config
	autocmd!
	autocmd BufWritePost Cargo.toml LspRestart
augroup end

augroup diagnostics
  autocmd!
  autocmd CursorHold,CursorHoldI * call Diagnostic()
augroup end

augroup linters
  autocmd!
  autocmd BufWritePost * FormatWrite
  " autocmd BufWritePost * lua vim.lsp.buf.format()
augroup end
