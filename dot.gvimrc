set columns=120
set lines=50
set guioptions=aciFm

" Custom color theme

"set background=light

"highlight CursorLine		gui=none	guibg=#b7a65c
"highlight ErrorMsg			gui=none	guifg=white		guibg=#30083d
"highlight IncSearch			gui=bold	guibg=#b7a246
"highlight Search			gui=none	guibg=#c0a1cb	guifg=black
"highlight LineNr			gui=none	guifg=#1e4837
"highlight Normal			gui=none	guifg=black		guibg=#d6d6d6
"
" Syntax highlighting
"highlight Comment			gui=italic	guifg=#1e4837 
"highlight Constant			gui=none	guifg=#5c4d0b 
"highlight String			gui=none	guifg=#695d2c 
"highlight PreProc			gui=none	guifg=#3c1e46
"highlight Identifier		gui=none	guifg=#30083d
"highlight Statement			gui=none	guifg=#3c9c76
"highlight Keyword			gui=none	guifg=#8a7520
"highlight Type				gui=none	guifg=#481858

colorscheme dusk

" Try to select a resonable font depending on the vim we're starting
if has("mac")

	let h = hostname()

	if h == "dino.local"

		set guifont=Menlo:h14
		set antialias
	else
		"set guifont=PragmataPro:h15
		set guifont=Andale\ Mono:h15

		"set noantialias

		"set guifont=ProggySquare:h11
		"set linespace=1

		"set guifont=Monaco:h13
		"set linespace=0

		" For that amiga look :)
		"set guifont=Topaz\ a600a1200a400:h16
		"set linespace=1

	end


elseif has("unix")

    if has("gui_motif")
        " The motif version uses standard X11 font strings
        set guifont=-misc-fixed-medium-r-normal--15-*-75-75-c-*-iso8859-1
    elseif has("gui_gtk2")
        set guifont=Fixed\ 11
    endif

elseif has("windows")
    " set guifont=Bitstream_Vera_Sans_Mono:h11:cANSI
    set guifont=ter-114n:h11
endif

