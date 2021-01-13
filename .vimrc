"if exists('$WINDOWID') && ($TERM =~ "st" || $TERM =~ "tmux" || $TERM =~"screen-256color" || $TERM =~ "xterm-256color")
"    colorscheme miromiro
"else
"    colorscheme miro8                   " colourscheme for the 8 colour linux term
"endif
"
if &compatible
    set nocompatible
endif 
" For snippet-style shortcuts, make jumping around easier
" Even though it is control + @, it is actually ctrl + space
inoremap <C-@> <Esc>/<++><CR>c4l

"------------------------------------------------------------------------------
"
"
"				Colors and Syntax
"
"
"------------------------------------------------------------------------------

syntax on "Enable Syntax Processing
:hi gray guifg=#ebdbb2 ctermfg=223

filetype plugin on

set t_Co=256
set ttyfast
set cursorline
set nowrap
set encoding=utf-8
set backspace=2
set scrolloff=10

set scrolloff=8

" Allows for writing to files with root priviledges
cmap w!! w !sudo tee %

set grepprg=grep\ -nH\ $*

":hi CursorLine cterm=none
":hi CursorLine gui=none

"------------------------------------------------------------------------------
"
"
"				Spaces and Tabs
"
"
"------------------------------------------------------------------------------

filetype plugin indent on "Load filetype specific indent files

set tabstop=4	"Number of Visual Spaces per Tab
set softtabstop=4 "Number of Spaces in Tab when editing
set shiftwidth=4
set expandtab "Tabs are Spaces
set smartindent " New line generates proper tabbing

"------------------------------------------------------------------------------
"
"
"				UI Config
"
"
"------------------------------------------------------------------------------

set relativenumber number "show line numbers

set showcmd "show command in bottom bar

filetype indent on "Load Filetype-Specific Indent Files

set wildmenu "Visual Autocomplete for Command Menu

set lazyredraw "redraw only when we need to

set showmatch "highlight matching [{()}]

"------------------------------------------------------------------------------
"
"
"				Searching
"
"
"------------------------------------------------------------------------------

set incsearch "search as characters are entered

set hlsearch "highlight matches


"Turn off search highlight
nnoremap <leader><space> nohlsearch<CR>

"------------------------------------------------------------------------------
"
"
"				Folding
"
"
"------------------------------------------------------------------------------

set foldenable "enable folding

set foldlevelstart=10 "open most folds by default

set foldnestmax=10 "10 Nested fold max

"Space open Close folds
nnoremap <space> za

set foldmethod=indent "fold based on indent level

"------------------------------------------------------------------------------
"
"
"				Movement
"
"
"------------------------------------------------------------------------------

"Move vertically by visual line
"nnoremap j gj
"nnoremap k gk

"nnoremap j jzz
"nnoremap k kzz


"Move to beginning/end of line
nnoremap B ^
nnoremap E $

"$/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

"Highlight last inserted text
nnoremap gV `[v`]

"Navigate Vsplits with ctrl-j/k/l/h
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

" Make splits slightly quicker
" nnoremap <C-V> <C-W><C-V>
" Can't do ctrl-s because that is terminal scroll lock
" nnoremap <C-S> <C-W><C-S>

nnoremap <C-T> :vert term<CR>
nnoremap <C-H> <C-W><C-H>

"Split panes to the left and below the current vim pane
set splitbelow
set splitright

"
"	Disable Arrow Key Movement, Resizes Splits Instead
"
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

" FILE BROWSING: 
"
" Tweaks for browsing
let g:netrw_banner=0        " disable anoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right`
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"------------------------------------------------------------------------------
"
"
"
"				Leader Shortcuts
"
"
"------------------------------------------------------------------------------

let mapleader="," "Leader is comma

"jk is escape
"inoremap jk <esc>


set statusline=\ \%f%m%r%h%w\ ::\ %y\ [%{&ff}]\%=\ [%p%%:\ %l/%L]\ 
set laststatus=2
set cmdheight=1


" {{{ DistractFree
let g:distractfree_width = '75%'
let g:distractfree_colorscheme = 'mirowriter'
let g:distractfree_keep_options = 'textwidth=79'
" }}}

" {{{ Map keys to toggle functions
function! MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction

command! -nargs=+ MapToggle call MapToggle(<f-args>)
"Keys & functions
MapToggle <F4> number
MapToggle <F5> spell
MapToggle <F6> paste
MapToggle <F7> hlsearch
MapToggle <F8> wrap
" }}}

" {{{ Toggle colored right border after 80 Characters
set colorcolumn=0
let s:color_column_old = 80

function! ToggleColorColumn()
    if s:color_column_old == 0
        let s:color_column_old = &colorcolumn
        windo let &colorcolumn = 0
    else
        windo let &colorcolumn=s:color_column_old
        let s:color_column_old = 0
    endif
endfunction
nnoremap <bar> :call ToggleColorColumn()<CR>
" }}}

au BufNewFile,BufRead *rtorrent.rc* set filetype=rtorrent

" VIM LATEX
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

if exists('$TMUX')
    execute 'source' '~/.vim/vim_configs/tmux_nav.vim'
endif
au BufNewFile,BufRead *.s,*.S set filetype=arm " arm = armv6/7

"----------------------------------------------------------------------------
"
"
"       Vundle
"
"
"----------------------------------------------------------------------------

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Snippits Plugin
" Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'KeitaNakamura/tex-conceal.vim'
Plugin 'vimwiki/vimwiki'
Plugin 'morhetz/gruvbox'

" Snippits Settings
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" A Vim Plugin for Lively Previewing LaTeX PDF Output
Plugin 'lervag/vimtex'

call vundle#end()            " required
filetype plugin indent on    " required
syntax enable

"tex-conceal settings
set conceallevel=2
let g:tex_conceal="abdgm"

let g:tex_flavor = "latex"
let g:vimtex_view_general_viewer = "zathura"
set clipboard=unnamed

" I think this is needed for inkscape stuff
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/" && inkscape-figures watch 1>/dev/null'<CR>
nnoremap <C-f> : silent exec '!inkscape-figures watch 1>/dev/null; inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

" Spell checking
map <leader>o :setlocal spell! spelllang=en_us<CR>
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

let wiki = {}
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
let g:vimwiki_list = [wiki]


function! CleverTab()
    let line = getline('.')                         " current line
    let pumvis = pumvisible()
    let substr = strpart(line, -1, col('.')+1)      " from the start of the current
    " line to one character right
    " of the cursor
    let substr = matchstr(substr, "[^ \t]*$")       " word till cursor
    if (strlen(substr)==0)                          " nothing to match on empty string
        return "\<tab>"
    endif
    let has_period = match(substr, '\.') != -1      " position of period, if any
    let has_slash = match(substr, '\/') != -1       " position of slash, if any
    let has_brace = stridx(substr, "{") != -1
    let has_loop = match(substr, 'for') != -1 || match(substr, 'while') != -1

    if (pumvis)
        return "\<C-N>"
    endif
    if ( has_loop )
        return " (  )\<CR>{\<CR>}\<Esc>ko<++>\<Esc>j.4kf(lli"
    endif
    if ( has_brace )
        return "\<CR>}\<Esc>ko"
    endif
    if (!has_period && !has_slash)
        return "\<C-X>\<C-N>"                         " existing text matching // maybe just change to <C-O> ?
    elseif ( has_slash )
        return "\<C-X>\<C-F>"                         " file matching
    else
        return "\<C-X>\<C-O>"                         " omni matching
    endif
endfunction                                                                                                                                                                                                

inoremap <expr> <Tab> CleverTab()


" function! s:InsertSpace()
    " if getline('.')[col('.')-3:col('.')-2] =~ '[^. ]\s$'
        " return "\<bs>. "
    " else
        " return ' '
    " endif
" endfunction
" 
" inoremap <expr> <space> <SID>InsertSpace()
