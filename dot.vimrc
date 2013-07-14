
" Initialize vundle
set nocompatible
filetype on
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle - required! 
Bundle 'gmarik/vundle'

" Github repos
Bundle 'tpope/vim-fugitive'
Bundle 'vim-scripts/Colour-Sampler-Pack'
Bundle 'vim-scripts/a.vim'
Bundle 'vim-scripts/Align'
Bundle 'vim-scripts/EasyMotion'
Bundle 'vim-scripts/asciidoc.vim'
Bundle 'vim-scripts/argtextobj.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-vividchalk'
Bundle 'altercation/vim-colors-solarized'
Bundle 'Lokaltog/powerline'

set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim

let g:ctrlp_custom_ignore = {
\ 'dir':  '\v(\.git)|(build.*)|(t2-output)$',
\ 'file': '\v\.(o|d|exe|dll|a|zip|tar\..*)$',
\ 'link': 'SOME_BAD_SYMBOLIC_LINKS',
\}

let mapleader = ","

if has("mac") && has("gui")
	set macmeta
end

set ch=2
set encoding=utf-8
set hidden
set modeline
set noexpandtab
set number
set ruler
set sw=4
set ts=4
set scrolloff=3
set shellslash
set autoread

" c indentation style
set cino=l1g0t0

if !has("windows")
set backupdir=~/.vim-backup
set directory=~/.vim-backup
endif
set ignorecase
set smartcase
"set wildmenu
"set wildmode=list:longest
set incsearch
set shortmess=atI
set history=1000

" SlimV configuration
let g:slimv_clhs_root = "file:///Users/dep/Lisp/HyperSpec/Body/"
let g:slimv_ctags = "ctags"
let g:slimv_impl = "sbcl"
let g:paredit_mode = 0
let g:slimv_repl_split = 2

"set list
"set listchars=tab:>-,trail:@

" Toggle listing whitespace with ,s
set listchars=tab:>-,trail:·,eol:$
nmap <silent> <leader>s :set nolist!<CR>

" More matching
runtime macros/matchit.vim

syntax on

" This enables indentation for e.g. XML files
filetype off
filetype plugin indent on

"set errorformat=
"	\%f(%l\\,%c):\ %trror\ CS%\\d%\\+:\ %m,
"	\%f(%l\\,%c):\ %tarning\ CS%\\d%\\+:\ %m,
"	\%f:%l:\ %m

" Hide files you don't want to edit most of the time.
let g:netrw_list_hide='^\.,\.gz$,\.exe$,\.zip$,\.swp$,\~$,\.fasl$'

" Alternate file switching. Desired cycle order:
" .c -> .s -> .i -> .h -> .c
let g:alternateExtensions_cpp = "s,asm,i,inc,h,hpp"
let g:alternateExtensions_c = "h,s,asm,i,inc"
let g:alternateExtensions_h = "s,c,m,cpp"
let g:alternateExtensions_m = "h"
let g:alternateExtensions_i = "h,hxx,hpp,c,cpp"
let g:alternateExtensions_s = "i,inc,c,cpp,h,hpp"

" Toggle header/source on Alt+O
nmap <M-o> :A<CR>

syntax on

if !has("gui_running")
	colorscheme desert
end

map <Tab> ^

" Fantastic hack to have escape to clear the hlsearch highlight.
if has("gui_running")
	nnoremap <esc> :noh<return><esc>
	set hlsearch
end

" Set file types
au BufNewFile,BufRead *.frag,*.vert,*.fp,*.vp,*.glsl setf glsl
au BufNewFile,BufRead *.ml,*.mli,*.mly,*.mll setf ocaml
au BufNewFile,BufRead *.vcg,*.fcg setf cg

let g:QuickMakeAutoDetect = 1

function! s:QuickMake()

	if g:QuickMakeAutoDetect == "1"
		" Attempt to auto-detect build system
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

" Shortcuts to pop open and close the quickfix
nmap <F5> :copen<CR>
nmap <F6> :cclose<CR>

nmap <F7> :QuickMake<CR>

" Use F8/F9 to jump between errors in the quickfix window
nmap <F8> :cnext<CR>
nmap <F9> :cprev<CR>

set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set laststatus=2

nmap <F10> :call SlimvOpenReplBuffer()<CR>

function! s:on_csharp_file()
	set sw=2 ts=2 expandtab
	compiler mcs
endfunction

autocmd filetype vim,css,javascript,html,perl,ocaml,lisp,c,cpp,h,text,ruby,sh,lua set ts=2 sw=2 expandtab
autocmd filetype python set ts=4 sw=4 expandtab
autocmd filetype make set sw=2 ts=2 noexpandtab
autocmd filetype cs call s:on_csharp_file()
autocmd filetype go set sw=4 ts=4 noexpandtab
autocmd filetype asm set sw=8 ts=8 noexpandtab
