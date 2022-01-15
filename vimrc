" This is stuff to get vundle working.
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Make sure you bundle vundle
Plugin 'VundleVim/Vundle.vim'

" List uUser installed vim plugins here. You can use Githbu shortcuts,
" vim-scripts shortcuts, or direct links. See the vundel docs.
Plugin 'tpope/vim-fugitive'
Plugin 'preservim/nerdtree'
Plugin 'python-mode/python-mode'
Plugin 'davidhalter/jedi-vim'
Plugin 'vim-scripts/taglist.vim'
Plugin 'vim-scripts/ToggleComment'
Plugin 'vim-latex/vim-latex'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'jpalardy/vim-slime'

call vundle#end()

" Some general stuff
colorscheme ron " A nice colorscheme
syntax on " Use syntax highlighting
filetype plugin indent on " Turn on plugins

" This sends your yanks to the system clipboard allowing for easier copying and
" pasting
set clipboard=unnamed

" This allows you to mouse select text even if you have the screen split
" set mouse=a

" NerdTree key mapping
map <F3> :NERDTreeToggle<CR>

" Sets the filetype for jinja files
au BufNewFile,BufRead *.j2 set filetype=htmljinja

" Sets the filetype for Autolev files
au BufNewFile,BufRead *.al set filetype=

" Sets the filetype for Markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

set autowrite " saves the file when you switch buffers or execute external commands, otherwise vim asks if you want to save
set autoindent " will indent lines following indented lines
set bs=indent,eol,start
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅ " adds some symbols for tabs, trailing whitespace, and non=breaking spaces
"set exrc " allows you to set a custom local vimrc in working directories
set textwidth=79 " sets wrapping default as 79 characters

" Python-mode
" Activate rope
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)
" Assume Python 3 syntax
let g:pymode_python = 'python3'
" Don't use rope, using Jedi as a separate install instead.
let g:pymode_rope = 0
"
" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'
"
"Linting
let g:pymode_lint = 1
let g:pymode_lint_checker = ['pyflakes', 'pep8', 'mccabe']
" Auto check on save
let g:pymode_lint_write = 1
let g:pymode_lint_unmodifed = 1
"
" Support virtualenv
let g:pymode_virtualenv = 1
"
" Enable breakpoints plugin
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'
"
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
" Don't autofold code
let g:pymode_folding = 0

" Python Jedi
" Don't autocomplete 'import' in python.
let g:jedi#smart_auto_mappings = 0

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
autocmd FileType cpp source ~/.vim/after/ftplugin/cpp.vim
autocmd FileType R source ~/.vim/after/ftplugin/r.vim
autocmd FileType javascript source ~/.vim/after/ftplugin/javascript.vim
autocmd FileType yaml source ~/.vim/after/ftplugin/yaml.vim

" This remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

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

" stuff added for Latex-Suite

" this stuff some how fucks up my python/pyflakes highlighting if it is in my .vimrc

" stuff added for Latex-Suite

" " IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a singe file. This will confuse Latex-Suite. Set your grep
" " program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_IgnoredWarnings="Underfull\nOverfull\nspecifier changed to\nYou have requested\nMissing number, treated as zero.\nThere were undefined references\nCitation %.%# undefined\nLaTeX Font Warning"
let g:Tex_IgnoreLevel=8
let g:Tex_ViewRule_pdf='evince $*.pdf'
let g:Tex_ViewRule_dvi='evince $*.pdf'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_GotoError=0
let g:Tex_CompileRule_pdf='pdflatex $*.tex && bibtex $*.aux && pdflatex $*.tex && pdflatex $*.tex'
let g:Tex_CompileRule_dvi='latex $*.tex && bibtex $*.aux && latex $*.tex && latex $*.tex && dvipdf $*.dvi $.pdf'
let g:tex_indent_items = 1

" I accidentally hit F1 all the time when trying to hit escape and this brings
" up the Gnome terminal help. So I disabled that via Edit > Keyboard Shortcuts
" (press backspace). Now F1 brings up vim help, so remap F1 to esp only when in
" insert mode, see http://vim.wikia.com/wiki/Disable_F1_built-in_help_key.
inoremap <F1> <Esc>
noremap <F1> :call MapF1()<CR>

function! MapF1()
  if &buftype == "help"
    exec 'quit'
  else
    exec 'help'
  endif
endfunction

" Spell check
set spelllang=en
set spellfile=$HOME/bin/en.utf-8.add

" vim-slime
" I added a new (uncommitted) ftplugin for rst file in
" .vim/bundle/vim-slime/ftplugin that is a copy of the python ftplugin so that
" dedenting works.
let g:slime_target = 'tmux'
let g:slime_default_config = {
            \ 'socket_name': get(split($TMUX, ','), 0),
            \ 'target_pane': '{top-right}' }
let g:slime_dont_ask_default = 1
let g:slime_python_ipython = 1

" \h will execute these commands
nmap <Leader>h <Plug>SlimeLineSend
xmap <Leader>h <Plug>SlimeRegionSend
