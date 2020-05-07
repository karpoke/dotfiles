" refresh vim config:  :so(urce) %

" TODO:
" * work with buffers: :tabe || ^p y ^t
" * customize by filetype
" * manage plugins: vundle
" * install plugins: add plugin, reload (:so %), call :PluginInstall
" * work with python, django
" * tags: set tags
" * refactorize
" * autocomplete: YouCompleteMe
" * snippets
"
" resize windows automatically: ^w=
" jump to the matching bracket/brace: %
" indent/unindent: >>, <<
" fix indentation: =G
" create a new tab: :tabnew
" go to next tab: gt
" go to previous tab: gT
" close all other tabs besides the active one: :tabo
" previous/next file: ^o, ^i

" vundle install:
"   $ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
" Plugin 'ctrlpvim/ctrlp.vim'  # mucho mejor fzf
Plugin 'vim-scripts/vcscommand.vim'
Plugin 'vim-scripts/taglist.vim'
" Plugin 'Yggdroot/indentLine'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'rking/ag.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-fugitive'
Plugin 'typeintandem/vim'


" to install a new plugin:
" 1) add it above
" 2) refresh source:  :so %
" 3) install it:      :PluginInstall


"   " The following are examples of different formats supported.
"   " Keep Plugin commands between vundle#begin/end.
"   " plugin on GitHub repo
"   " plugin from http://vim-scripts.org/vim/scripts.html
"   Plugin 'L9'
"   " Git plugin not hosted on GitHub
"   Plugin 'git://git.wincent.com/command-t.git'
"   " git repos on your local machine (i.e. when working on your own plugin)
"   Plugin 'file:///home/gmarik/path/to/plugin'
"   " The sparkup vim script is in a subdirectory of this repo called vim.
"   " Pass the path to set the runtimepath properly.
"   Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"   " Install L9 and avoid a Naming conflict if you've already installed a
"   " different version somewhere else.
"   Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Install Plugins:
" Launch vim and run :PluginInstall
" To install from command line: vim +PluginInstall +qall
" Put your non-Plugin stuff after this line


syntax on

" change leader. default = \ (:help leader)
" :let mapleader = ","

" Set to auto read when a file is changed from the outside
set autoread
au CursorHold * checktime

" show existing tab with 4 spaces width
set tabstop=4 " ts
" when indenting with '>', use 4 spaces width
set shiftwidth=4 " sw
" On pressing tab, insert 4 spaces
set expandtab " et
" Number of spaces Tab counts in editing operations
set softtabstop=4 " sts
set smarttab " sta
" sets how vim shall represent characters internally

" Use:
"   :.retab     to retab a line
"   :%retab     to retab entire file
"   :'<,'>retab to retab a visual selection
" shiftwith in front of a line. tabstop or softtabstop in other places
function! ReTab()
    :%retab
    :%s/\s\+$//
endfunction

set encoding=utf-8
" encoding for a particular file
set fileencoding=utf-8
" insensitive case search
set ignorecase " ic
" no ignorecase if Uppercase char present
set smartcase " scs
" highlight search
set hlsearch
" incremental search (moving cursor position)
set incsearch

" blink briefly around the match
" zzzv is to keep search matches in the middle of the window
highlight BlinkHL ctermbg=green ctermfg=yellow
nnoremap <silent> n nzzzv:call HLNext(0.4)<cr>
nnoremap <silent> N Nzzzv:call HLNext(0.4)<cr>
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
    let target_pat = '\c\%#'.@/
    let blinks = 2
    for n in range(1,blinks)
        let red = matchadd('BlinkHL', target_pat, 101)
        redraw
        exec 'sleep '. float2nr(a:blinktime / (2*blinks) * 300) . 'm'
        call matchdelete(red)
        redraw
        exec 'sleep '. float2nr(a:blinktime / (2*blinks) * 300) . 'm'
    endfor
endfunction

" taglist
" nnoremap <silent> <F8> :TlistToggle<CR>
nnoremap <silent> <c-t> :TlistToggle<CR>

" lighter text
set background=light
" max width. wrap text automatically in lines longer
set textwidth=79
" no wrap automatically
set nowrap
" highlight column after 'textwidth' (vim +7.3)
" set colorcolumn=+1
" highlight three columns after 'textwidth'
" set colorcolumn=+1,+2,+3
" highlight ColorColumn ctermbg=lightgrey guibg=lightgrey
" another: make the 81st column stand out
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

" show line numbers
set number
" show relative number
set relativenumber

" no adding blank line at end of file automatically
" set noeol
" show line under the cursor
" set cursorline " cul
" show symbols as these chars
" set listchars=tab:→\ ,trail:·,extends:¶,precedes:§,nbsp:·,eol:¶,space:␣
exec "set listchars=tab:\uBB\uBB,trail:\uB7,extends:¶,precedes:§,nbsp:~"
" show symbols
set list
" show these break line symbols
set showbreak=×××
" show row and column position
set ruler
" nicer status line
set laststatus=2
" show partial command in the last line
set showcmd
" show matching bracket
set showmatch
" copy indent from the previous line
set autoindent
"set nosmartindent
"set nocindent
" make that backspace key work the way it should
set backspace=indent,eol,start
" keep x lines when scrolling
set scrolloff=7

" Copying and pasting from the clipboard
set clipboard=unnamedplus

" tags file
" help: :tag, Ctrl-], v_CTRL_], <C-LeftMouse>, g<LeftMouse>, :stag, Ctrl-W_]
set tags=.tags,tags,./.tags

" remap Esc to jj
imap jj <Esc>

" syntax in diff files
augroup PatchDiffHighlight
    autocmd!
    autocmd FileType  diff   syntax enable
augroup END

"set wildmode=list:full
"set formatoptions=t
"set switchbuf=usetab
"set complete=.,w,b,t,i,d
"set mouse=nvh
" así el mouse funciona como visual y no 'coge' los números
"set mouse=a

if has('autocmd')
"aug projects
"au!
"au FileType python,sh setl fo=croq sts=4 ts=4 sw=4
"au FileType html set noai fo=t tw=80 sts=2 ts=2 sw=2 inde=
"aug END

" execute with: gg=G
autocmd FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null
autocmd FileType json setlocal equalprg=python\ -m\ json.tool

" # vim: ai ts=4 sts=4 et sw=4
autocmd FileType python set sw=4
autocmd FileType python set ts=4
autocmd FileType python set sts=4
endif

"imap <F1> <Nop>
"cmap <F1> <Nop>
"nmap <F1> <Nop>
"nmap K <Nop>
"nmap Q <Nop>

"imap <MiddleMouse> <Nop>
"cmap <MiddleMouse> <Nop>
"nmap <MiddleMouse> <Nop>

nmap ,e  :Vexplore<CR>
nmap ,n  :setl nohlsearch!<CR>
nmap ,o  :setl number!<CR>
nmap ,j  :setl relativenumber!<CR>
nmap ,p  :setl paste!<CR>
nmap ,w  :setl wrap!<CR>
nmap ,r  :call ReTab()<CR>
"nmap ,c :copen<CR>
"nmap ,x :cclose<CR>
"nmap ,m :make<CR>

" NERDTree
map <C-n> :NERDTreeToggle<CR>
" open automatically if no files were specified
"   autocmd StdinReadPre * let s:std_in=1
"   autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" open automatically if vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" close if the only window left is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" arrows
" let g:NERDTreeDirArrowExpandable = '▸'
" let g:NERDTreeDirArrowCollapsible = '▾'
" end NERDTree

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" end syntastic

" YCM YouCompleteMe
" https://github.com/ycm-core/YouCompleteMe
" Install:
"   sudo apt install build-essential cmake python3-dev
"   cd ~/.vim/bundle/YouCompleteMe
"   python3 install.py  # w/o clang completer
"
" let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
" let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
" let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
" let g:ycm_complete_in_comments = 1 " Completion in comments
" let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_confirm_extra_conf = 0
let g:ycm_always_populate_location_list = 1
"let g:ycm_autoclose_preview_window_after_completion=1
"let g:ycm_autoclose_preview_window_after_insertion=1
set completeopt=menuone " Default: completeopt=preview,menuone
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_semantic_triggers = {
 \  'c': ['->', '.'],
 \  'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
 \      're!\[.*\]\s'],
 \  'ocaml': ['.', '#'],
 \  'cpp,cuda,objcpp': ['->', '.', '::'],
 \  'perl': ['->'],
 \  'php': ['->', '::'],
 \  'cs,d,elixir,go,groovy,java,javascript,julia,perl6,scala,typescript,vb': ['.'],
 \  'python': ['re!..'],
 \  'ruby,rust': ['.', '::'],
 \  'lua': ['.', ':'],
 \  'erlang': [':'],
 \ }
" END YMC

" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" "List possible snippets based on current file
" end utlisnips

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme="laederon"
let g:airline_symbols#linenr = ':'
let g:airline_symbols#linenr = ':'
let g:airline#extensions#syntastic#enabled = 1

" fzf much better
"" let g:airline#extensions#ctrlp#color_template = 'insert'
"" let g:airline#extensions#ctrlp#color_template = 'normal'
"" let g:airline#extensions#ctrlp#color_template = 'visual'
"" let g:airline#extensions#ctrlp#color_template = 'replace'
"" let g:airline#extensions#ctrlp#show_adjacent_modes = 1
""
"" " ctrlp
"" " Change the default mapping and the default command to invoke CtrlP:
"" let g:ctrlp_map = '<c-p>'
"" let g:ctrlp_cmd = 'CtrlP'
"" " When invoked, unless a starting directory is specified, CtrlP will set its
"" " local working directory according to this variable:
"" let g:ctrlp_working_path_mode = 'ra'
"" " Exclude files or directories using Vim's wildignore:
"" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " Linux/MacOSX
"" " Specify an external tool to use for listing files instead of using Vim's
"" " globpath(). Use %s in place of the target directory:
"" let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
"" " Single VCS listing command:
"" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files']
"" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
"" let g:ctrlp_user_command = ['.hg', 'hg --cwd %s locate -I .']
"" " end ctrlp

" indentline
let g:indentLine_color_term = 239
" end intentline

" highlight current line
highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
set cursorline

" forgot to sudo
cnoremap w!! w !sudo tee % >/dev/null

" abbreviations
iabbrev _date  <c-r>=strftime("%Y-%m-%d")<cr>
iabbrev _time  <c-r>=strftime("%H:%M:%S")<cr>

" Turn on spell checking for commit messages
au FileType gitcommit setlocal spell
au FileType hgcommit setlocal spell
au FileType svn setlocal spell

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" fzf
" If installed using git
set rtp+=~/.fzf
map <C-P> :FZF<CR>

" ag silver search
" e    to open file and close the quickfix window
" o    to open (same as enter)
" go   to preview file (open but maintain focus on ag.vim results)
" t    to open in new tab
" T    to open in new tab silently
" h    to open in horizontal split
" H    to open in horizontal split silently
" v    to open in vertical split
" gv   to open in vertical split silently
" q    to close the quickfix window
let g:ag_prg="/usr/bin/ag --vimgrep"

" Maintain undo history between sessions
" https://jovicailic.org/2017/04/vim-persistent-undo/
set undofile
set undodir=~/.vim/undodir

" Copy to clipboard the relative path of the file and the line number
nnoremap <leader>l :let @+=expand("%").":".line(".")<CR>

" Copy to clipboard the full path of the file and the line number
nnoremap <leader>ll :let @+=expand("%:p").":".line(".")<CR>
