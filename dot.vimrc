
set nocompatible
filetype off

"-----------------------------------------------------------------------------
"  Basic settings
"-----------------------------------------------------------------------------
let mapleader = ","

set ch=2
set encoding=utf-8
set hidden
set modeline
set expandtab
set number
set ruler
set sw=2
set ts=2
set scrolloff=3
set shellslash
set autoread
set ignorecase
set smartcase
set incsearch
set shortmess=atI
set history=1000
set laststatus=2
set grepprg=rg\ --vimgrep
" c indentation style
set cino=l1g0t0E-sN-s
" toggle whitespace display with ,s
set listchars=tab:>-,trail:·,eol:$

" This is more annoying than helpful. And slow.
"set wildmenu
"set wildmode=list:longest

if !has("windows")
set backupdir=~/.vim-backup
set directory=~/.vim-backup
endif

" Initialize vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle - required! 
Bundle 'gmarik/vundle'

" Github repos
Bundle 'vim-scripts/Colour-Sampler-Pack'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/Align'
Bundle 'vim-scripts/EasyMotion'
Bundle 'vim-scripts/asciidoc.vim'
Bundle 'vim-scripts/argtextobj.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-vividchalk'
Bundle 'altercation/vim-colors-solarized'

"-----------------------------------------------------------------------------
" Miscellaneous plugin configuration
"-----------------------------------------------------------------------------

" Hide files you don't want to edit most of the time.
let g:netrw_list_hide='^\.,\.gz$,\.exe$,\.zip$,\.swp$,\~$,\.fasl$'

let g:ctrlp_custom_ignore = {
\ 'dir':  '\v(\.git)|(build.*)|(t2-output)$',
\ 'file': '\v\.(o|d|exe|dll|a|zip|tar\..*)$',
\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
\}

" More matching
runtime macros/matchit.vim

"-----------------------------------------------------------------------------
" Alternate file switching. Desired cycle order:
" .c -> .s -> .i -> .h -> .c
"-----------------------------------------------------------------------------
let g:alternateExtensions_cpp = "s,asm,i,inc,h,hpp"
let g:alternateExtensions_c = "h,s,asm,i,inc"
let g:alternateExtensions_h = "s,c,m,cpp"
let g:alternateExtensions_m = "h"
let g:alternateExtensions_i = "h,hxx,hpp,c,cpp"
let g:alternateExtensions_s = "i,inc,c,cpp,h,hpp"

"-----------------------------------------------------------------------------
" File type hooks
"-----------------------------------------------------------------------------
autocmd BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
autocmd BufNewFile,BufRead *.ml,*.mli,*.mly,*.mll setf ocaml
autocmd BufNewFile,BufRead *.vcg,*.fcg setf cg

autocmd filetype vim,css,javascript,html,perl,ocaml,lisp,c,cpp,h,text,ruby,sh,lua set ts=2 sw=2 expandtab
autocmd filetype python set ts=4 sw=4 expandtab
autocmd filetype make set sw=2 ts=2 noexpandtab
autocmd filetype go set sw=4 ts=4 noexpandtab
autocmd filetype asm set sw=8 ts=8 noexpandtab

"-----------------------------------------------------------------------------
" Custom functions/commands
"-----------------------------------------------------------------------------

let g:QuickMakeAutoDetect = 1

" Attempt to auto-detect build system, run make. Much like hitting F7 in
" visual studio when bound later.
"
" To disable, set g:QuickMakeAutoDetect=0
function! s:QuickMake()

	if g:QuickMakeAutoDetect == "1"
		if filereadable("Makefile")
			set makeprg=make
		elseif filereadable("tundra.lua")
			set makeprg=tundra2
		elseif filereadable("SConstruct")
			set makeprg=scons
		endif
	endif

	let format = &errorformat	" capture current local efm
	:wall
	:copen
	silent! :make
	let &efm=format " transfer error format to quickfix buffer
endfunction

command! -nargs=0 QuickMake :call s:QuickMake()

function! ClangFormatFile()
  wall
  call system("clang-format -i " . expand("%:p"))
  checktime
endfunction


function! DoRefreshTags()
  wall
  call system("ctags --recurse --extras=+f")
endfunction

command! -nargs=0 RefreshTags :call DoRefreshTags()

"-----------------------------------------------------------------------------
" Keyboard mappings
"-----------------------------------------------------------------------------

" Tab moves to beginning of line, like ^
map <Tab> ^

" Fantastic hack to have escape to clear the hlsearch highlight via remapping
" escape.
if has("gui_running")
	nnoremap <esc> :noh<return><esc>
	set hlsearch
end

" Toggle header/source on Alt+O
nmap <M-o> :A<CR>

" Toggle listing whitespace with ,s
nmap <silent> <leader>s :set nolist!<CR>

" Function key shortcuts.
nmap <F5> :copen<CR>
nmap <F6> :cclose<CR>
nmap <F7> :QuickMake<CR>
nmap <F8> :cnext<CR>
nmap <F9> :cprev<CR>
nmap <F10> :call ClangFormatFile()<CR>
nmap <F11> :RefreshTags<CR>

if !has("gui_running")
	colorscheme desert
end

syntax on
filetype plugin indent on
