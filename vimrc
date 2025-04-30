" This is stuff to get vundle working.
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Make sure you bundle vundle
Plugin 'VundleVim/Vundle.vim'
" List user installed vim plugins here. You can use Github shortcuts,
" vim-scripts shortcuts, or direct links. See the vundel docs.
Plugin 'girishji/vimcomplete'
Plugin 'jpalardy/vim-slime'
Plugin 'lervag/vimtex'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'pcgen/vim-pcgen'
Plugin 'preservim/nerdtree'
Plugin 'python-mode/python-mode'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-scripts/ToggleComment'
Plugin 'vim-scripts/taglist.vim'
Plugin 'yegappan/lsp'
" Plugin 'ycm-core/YouCompleteMe'
call vundle#end()

" Some general stuff
syntax on " Use syntax highlighting
filetype plugin indent on " Turn on plugins

" This sends your yanks to the system clipboard allowing for easier copying and
" pasting, use :%y+ for example.
set clipboard=unnamed

" This allows you to mouse select text even if you have the screen split, but
" it seems to disable right click copy.
" set mouse=a

set autowrite " saves the file when you switch buffers or execute external commands, otherwise vim asks if you want to save
set autoindent " will indent lines following indented lines
set bs=indent,eol,start
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅ " adds some symbols for tabs, trailing whitespace, and non=breaking spaces
"set exrc " allows you to set a custom local vimrc in working directories
set textwidth=79 " sets wrapping default as 79 characters

" This remembers where you were the last time you edited the file, and returns to the same position.
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

"highlights end of line whitespace as red
if has('gui_running')
   hi WhiteSpaceEOL guibg=#FF0000
else
   hi WhiteSpaceEOL ctermbg=Red
endif
match WhitespaceEOL /\s\+\%#\@<!$/

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

set fileencodings=ucs-bom,utf-8,default,latin2

" Sets the filetype for jinja files
au BufNewFile,BufRead *.j2 set filetype=htmljinja

" Sets the filetype for Autolev files
au BufNewFile,BufRead *.al set filetype=

" Sets the filetype for Markdown files
autocmd BufNewFile,BufReadPost *.md set filetype=markdown

" load some overrides for particular filetypes
autocmd FileType R source ~/.vim/after/ftplugin/r.vim
autocmd FileType cpp source ~/.vim/after/ftplugin/cpp.vim
autocmd FileType html source ~/.vim/after/ftplugin/html.vim
autocmd FileType javascript source ~/.vim/after/ftplugin/javascript.vim
autocmd FileType matlab source ~/.vim/after/ftplugin/matlab.vim
autocmd FileType python source ~/.vim/after/ftplugin/python.vim
autocmd FileType rst source ~/.vim/after/ftplugin/rst.vim
autocmd FileType tex source ~/.vim/after/ftplugin/tex.vim
autocmd FileType yaml source ~/.vim/after/ftplugin/yaml.vim

"""""""""""""""""
" YouCompleteMe "
"""""""""""""""""
" Vundle cannot install YouCompleteMe simply by cloning the repository. After
" you run BundleInstall or BundleUpdate then:
" cd ~/.vim/bundle/YouCompleteMe
" ./install.py
" A C++ compiler and cmake is needed, etc., but this then works.
" let g:ycm_autoclose_preview_window_after_completion = 1

"""""""""""""""
" vimcomplete "
"""""""""""""""
let g:vimcomplete_tab_enable = 1

"""""""
" lsp "
"""""""
" vimcomplete uses lsp and you can add different language servers with the
" configuration below.
" TODO : configure pylsp to only use completion (for now):
" https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
let lspOpts = #{autoHighlightDiags: v:true}
autocmd User LspSetup call LspOptionsSet(lspOpts)

" the path to this may not be the same on all my computers, pylsp can be
" installed via apt
" configure the pylsp to disable everything but jedi (I use python-mode for
" everything else) configuration explained:
" - https://github.com/yegappan/lsp/issues/504
" - https://github.com/python-lsp/python-lsp-server/blob/develop/CONFIGURATION.md
let lspServers = [#{
    \ name: 'pylsp',
    \ filetype: ['python'],
    \ path: '/home/moorepants/miniconda/bin/pylsp',
    \ workspaceConfig: {
    \   'pylsp': {
    \     'configurationSources': [],
    \     'plugins': {
    \       'jedi_compeltion': {
    \         'enabled': 1,
    \       },
    \       'autopep8': {
    \         'enabled': 0,
    \       },
    \       'mccabe': {
    \         'enabled': 0,
    \       },
    \       'pylint': {
    \         'enabled': 0,
    \       },
    \       'pyflakes': {
    \         'enabled': 0,
    \       },
    \       'pycodestyle': {
    \         'enabled': 0,
    \       },
    \       'pydocstyle': {
    \         'enabled': 0,
    \       },
    \       'preload': {
    \         'enabled': 0,
    \       },
    \       'rope_completion': {
    \         'enabled': 0,
    \       },
    \       'yapf': {
    \         'enabled': 0,
    \       },
    \     }
    \   }
    \ }
    \ }]
autocmd User LspSetup call LspAddServer(lspServers)

""""""""""""
" NerdTree "
""""""""""""

" NerdTree key mapping, press F3
map <F3> :NERDTreeToggle<CR>

"""""""""""""""
" Python-mode "
"""""""""""""""
" pylama imports from pkg_resources but that is not available with whatever
" python pymode runs. So I cloned setuptools in the pymode submodules folder
" and symlinked pkg_resources in the libs dir:
" cd .vim/bundle/python-mode/pymode/submodules
" git clone git@github.com:pypa/setuptools.git
" ln -s ../../submodules/setuptools/pkg_resources/ pkg_resources"

let g:pymode = 1 " turn pymode on and off
" rope is a code completion library that will conflict with jedi-vim or other
" code completers, so turn it off if using a code completer.
let g:pymode_rope = 0 " turn rope on and off
let g:pymode_rope_completion = 0  " turn on autocompletion
let g:pymode_rope_autoimport = 0  " import modules in script so they can complete
" Disable special keys for jumping around to classes & functions
let g:pymode_motion = 0
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
" flake8: Missing whitespace around operator (E225)
" flake8: Missing whitespace around arithmetic operator (E226)
let g:pymode_lint_ignore = ["E225", "E226"]
"
" Disable virtualenv support
let g:pymode_virtualenv = 0
"
" syntax highlighting (these are already the default settings)
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
"
" Don't autofold code
let g:pymode_folding = 0

"""""""""""
" taglist "
"""""""""""

" maps keys to commands
map <F2> :w<CR>
map <F8> :TlistToggle<CR><C-w>h

let Tlist_Inc_Winwidth=0

"""""""""""""""""
" ToggleComment "
"""""""""""""""""

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

"""""""""""""
" vim-slime "
"""""""""""""

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
