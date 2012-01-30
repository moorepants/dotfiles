syntax on
filetype on
filetype indent on

" This sends your yanks to the system clipboard allowing for easier copying and
" pasting
set clipboard=unnamed

" This allows you to mouse select text even if you have the screen split
"set mouse=a

" This causes vim to load pyflakes
filetype plugin indent on

" This causes pyflakes not to load if the file ends in _auto.py. I use this
" ending for really long python files, which slow vim down if pyflakes is
" running.
autocmd BufReadPre *_auto.py :let b:did_pyflakes_plugin=1

" This allows one to toggle pyflakes using the fork
" https://github.com/georgexsh/pyflakes-vim
let g:pyflakes_autostart = 0
map <F11> :PyflakesToggle<cr>

set autowrite " saves the file when you swith buffers or execute external commands, otherwise vim asks if you want to save
set autoindent " will indent lines following indented lines
set bs=indent,eol,start
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅ " adds some symbols for tabs, trailing whitespace, and non=breaking spaces
"set exrc " allows you to set a custom local vimrc in working directories
set textwidth=79 " sets wrapping default as 79 characters

" maps keys to commands
map <F2> :w<CR>
map <F8> :TlistToggle<CR><C-w>h

let Tlist_Inc_Winwidth=0

set fileencodings=ucs-bom,utf-8,default,latin2

" load some overrides for particular filetypes
autocmd FileType html source ~/.vim/after/ftplugin/html.vim
autocmd FileType python source ~/.vim/after/ftplugin/python.vim
autocmd FileType tex source ~/.vim/after/ftplugin/tex.vim
autocmd FileType matlab source ~/.vim/after/ftplugin/matlab.vim
autocmd FileType rst source ~/.vim/after/ftplugin/rst.vim

" This remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

" This remembers where you were the last time you edited the file, and returns
" to the same postion.
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

"highlights end of line whitespace as red
if has('gui_running')
   hi WhiteSpaceEOL guibg=#FF0000
else
   hi WhiteSpaceEOL ctermbg=Red
endif
match WhitespaceEOL /\s\+\%#\@<!$/

" Mappings for plugin/ToggleComment.vim
noremap <silent> ,# :call CommentLineToEnd('#')<CR>+
noremap <silent> ;# :call CommentLineToEnd('###')<CR>+
noremap <silent> ,% :call CommentLineToEnd('%')<CR>+
noremap <silent> ;% :call CommentLineToEnd('%%%')<CR>+
noremap <silent> ,/ :call CommentLineToEnd('// ')<CR>+
noremap <silent> ," :call CommentLineToEnd('" ')<CR>+
noremap <silent> ,; :call CommentLineToEnd('; ')<CR>+
noremap <silent> ,- :call CommentLineToEnd('-- ')<CR>+
noremap <silent> ,* :call CommentLinePincer('/* ', ' */')<CR>+
noremap <silent> ,< :call CommentLinePincer('<!-- ', ' -->')<CR>+

" and/or Filetype specific mappings: Meta-c (Alt-c) and Meta-Shift-C
autocmd FileType c    noremap <silent> <buffer> <M-c> :call CommentLineToEnd('// ')<CR>+
autocmd FileType c    noremap <silent> <buffer> <M-C> :call CommentLinePincer('/* ', ' */')<CR>+
autocmd FileType make noremap <silent> <buffer> <M-c> :call CommentLineToEnd('# ')<CR>+
autocmd FileType html noremap <silent> <buffer> <M-c> :call CommentLinePincer('<!-- ', ' -->')<CR>
