" no backward compatibility w/ vi
set nocompatible

" make vim act like any mswindows (or ANY) editor...lots of useful stuff, like 
" shift text selection, movement/deletion line wrapping and the like. lots of
" shorcuts to keep you from having to switch from insert to visual/command 
" mode incessantly. honestly, a lot more useful =]
source $VIMRUNTIME/mswin.vim
behave mswin

" Make sre we only use UNIX newlines (\n). When reading files, the order below
" makes no difference, BUT since unix is first, that newline type will be used
" for all new files.
set fileformats=unix,dos

" disable appending newlines at end of file (apparently it's good form to
" leave it in, so let's leave it...)
"set noeol

" backspace can delete prev chars
set bs=2

" set file encoding UTF8
setlocal fileencoding=utf-8

" set up our intelligent indenting
set autoindent		" enable autoindenting
set smartindent		" derr
set shiftwidth=4	" how much indent to do when autoindenting

" indenting based on filetype
filetype indent on
"filetype plugin on

" makes cursor go to beinning of tab in normal mode instead of end of tab
"set list lcs=tab:\ \ 

" don't change cursor column when switching between buffers
set nostartofline

" enable paste mode for disabling auto-indent when pasting large blocks of
" text/code
set pastetoggle=<F2>

" use 4-space tabs (still tabs tho, not spaces)
set tabstop=4

" better searching (disregard case unless explicitely given caps)
set incsearch
set ignorecase
set smartcase

" informative status line
"set statusline=%F%m%r%h%w\[TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]

" syntax coloring
set t_Co=256
colorscheme void
syntax on

" highlight matching brackets/braces/etc, only highlight for 1/10th of a
" second after a mtch is made
set showmatch
set matchtime=1

" turn off wordwrap
set wrap!

" how many lines of buffer around cursor when scrolling
set scrolloff=2

" no code folding =]
"set nofoldenable
set foldmethod=syntax
let php_folding = 3			" fold functions (no classes, no {} blocks)

" show ruler line, col
set ruler

" disable mouse hide when typing
set nomh

" show current command keys in lower right
set sc

" buffers can be hidden, meaning they don't need an open window for each open
" buffer. 
set hidden

" show line numbers
set nu

" makes focus follow mouse cursor
"set mousefocus

" -----------------------------------------
" --------- some shell remappings ---------
" -----------------------------------------
" make ';' open command windows as opposed to ':' (saves having to hold shift,
" press ';', release shift)
nnoremap ; :

" make ctrl+x close the current buffer (without closing the window)
nmap <C-x> <Plug>Kwbd

" make ctrl+pageup/down control our buffer selection
map <C-PageUp> :bprevious <CR>
map <C-PageDown> :bnext <CR>

" Ctrl+backspace deletes previous word
imap <C-BS> <C-W>

" tab/shift+tab on selected text indents
vmap <Tab> >gv
vmap <S-Tab> <gv

" make arrow keys work in visual mode - NOTE - disabled because it interferes
" with windows mode
"vnoremap <Left> h
"vnoremap <Right> l
"vnoremap <Up> k
"vnoremap <Down> j

" make our home key smart
map <Home> :SmartHomeKey <CR>
imap <Home> <C-O>:SmartHomeKey<CR>

" F8 toggles MiniBufExplorer
map <F8> :TMiniBufExplorer <CR>

" F9 toggles NERDTree, but make sure MiniBufExplorer is always on top =]
map <F9> :NERDTreeToggle <CR> :TMiniBufExplorer <CR> :TMiniBufExplorer <CR>
" -----------------------------------------


" -----------------------------------------
" --------- MiniBufExplorer setup ---------
" -----------------------------------------
" switches tabs with single click
let g:miniBufExplUseSingleClick = 1

" number of spaces between tabs
let g:miniBufExplNumSpaces = 2

" show tabs even if there's only one buffer open
let g:miniBufExplorerMoreThanOne=1

" reload MinBufExpl on buffer changes
autocmd BufRead,BufNew,BufWritePost :call UMiniBufExplorer
" -----------------------------------------

" <TAB> behaves like bash, not DOS
set wildmode=longest:full
set wildmenu

" keep swap/backup files from writing
"set nobackup
set noswapfile

" load NERDTree on start
if has("gui")
	autocmd VimEnter * NERDTree
	autocmd VimEnter * wincmd p
endif

" ------------ PHP shit -------------
" SQL/HTML string syntax highlighting
let php_sql_query = 0
let php_htmlInStrings = 1
let php_smart_members = 1		" turn off if highlighting is slow
let php_alt_properties = 1		" requires php_smart_members
let php_highlight_quotes = 1	" count quotes as part of string when highlighting
let php_show_semicolon = 0		" this makes code look weird
let PHP_default_indenting = 1	" add a default of one tab after opening <?
let g:PHP_autoformatcomment=1	"blah

" add PHP syntax checking
if !exists("autocommands_loaded")
	let autocommands_loaded = 1
	autocmd BufRead *.php set makeprg=c:\cygwin\usr\local\bin\phplint.exe\ --no-print-notices\ --no-print-warnings\ %
	autocmd BufRead *.php set errorformat=%f:%l:\ %m
endif
map <F7> :silent lmake<cr>:lwindow <cr>:redraw!<cr>

" ------------c/c++ shit ---------------
let c_no_if0_fold = 1
let c_no_comment_fold = 1
set foldnestmax=1

" set up font shit for gui
if has("win32")
	set guifont=courier_new_cyr:h10
	autocmd GUIEnter * simalt ~X
else
	set guifont=Courier\ 10\ Pitch\ 10
	if has("gui")
		set toolbar=icons,text " how to show the toolbar
	endif
endif

" Remove menu bar
"set guioptions-=m

" save window position when switching buffers
if v:version >= 700
	au BufLeave * let b:winview = winsaveview()
	au BufEnter * if(exists('b:winview')) | call winrestview(b:winview) | endif
endif

" Remove toolbar
set guioptions-=T


