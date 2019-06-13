syntax on "syntax processing, colors
colorscheme wal "wal colorscheme to vim

"call plug#begin('~/.vim/plugged')
"call plug#end()
"spaces and tabs
set tabstop=4		"number of visual spaces for tab
set softtabstop=4	"number of spaces for tab when editing
set shiftwidth=4
set expandtab		"tabs = spaces
set autoindent

"set cursorline		"line the cursor are on goes highlighted
set wildmenu 		"when tab to complete, appears a zsh-like menu
set showmatch		"highlight matching [{()}]

set encoding=utf-8 "set encode to utf-8
set showcmd         "show last command entered
set hidden          "hide buffers instead of closing them, 
set formatoptions-=o    "dont continue comments when typing o/O

"search
set incsearch 		"search as characters are entered
set hlsearch		"highlight searches
set ignorecase       "ignore case if search is all lowercase
nnoremap <leader><space> :nohlsearch<CR>

"layout
set laststatus=2
"statusline
set statusline=                 "init
set statusline+=\ %(%l-%L%)     "line number and line total
set statusline+=\ <<\ %f\ >>   "file name
"set statusline+=\ %t
"set statusline+=\ /%{Wd()}/
"set statusline+=\ %{getcwd()}
set statusline+=\ %y
set statusline+=%(%m%r%w%)   "file type
set statusline+=[%n]
set statusline+=%=              "right align
"set statusline+=%-5.{strftime('%a\ %I:%M\ %p')}
set statusline+=%-7{strftime('%I:%M')}
set statusline+=%-4(%l,%c%V%)\ %P "set character and column number and percentage

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"noremap <silent> k gk
"noremap <silent> j gj

"nnoremap <Up> <gk>
"nnoremap <Down> <gj>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

set nu
set clipboard=unnamedplus

set splitbelow
set splitright

"au BufNewFile,BufRead *.py
"    \ set tabstop=4

au BufNewFile,BufRead *.cpp so /home/takion/.vim/cpp.vim "whenever opens a cpp file, load the setting inside cpp.vim
au BufNewFile,BufRead *.h so /home/takion/.vim/cpp.vim
au BufNewFile,BufRead *.py so /home/takion/.vim/py.vim
au BufNewFile,BufRead *.cs so /home/takion/.vim/cpp.vim

function! Wd()
    let s = system("pwd") 
    return s
"awk -F / '{print $NF}'")
endfunction

"newline without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>
