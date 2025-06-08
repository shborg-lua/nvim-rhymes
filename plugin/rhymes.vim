-- plugin/rhymes.vim
" Lazily load on :Rhymes
if exists('g:loaded_rhymes') | finish | endif
let g:loaded_rhymes = 1

" Define single command with subcommands
command! -nargs=* Rhymes lua require('rhymes.commands').run(<f-args>)
