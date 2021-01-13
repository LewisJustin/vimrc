"Set some colors for colorscheme purposes
hi DarkGreen  cterm=bold ctermfg=28  guifg=#008700
hi DarkOrange cterm=bold ctermfg=166 guifg=#d75f00
hi Purple     cterm=bold ctermfg=54  guifg=#5f0087

" Set vimwiki header colors
hi! link VimwikiHeader1 DarkOrange
hi! link VimwikiHeader2 DarkGreen
hi! link VimwikiHeader3 Purple

" Shortcuts to make vimwiki markup easier
inoremap [ [[]]<Esc>hi
inoremap = ==<Esc>i


" Make a link with a filename different from word (word is what you were
" hovering over
nnoremap <leader>d wbi[[\|<Esc>ea]]<Esc>F\|i
" Make a link of the word you are on
" Pressing enter over a word will turn it into a link apparently
" nnoremap <leader>l wbi[[<Esc>ea]]<Esc>
