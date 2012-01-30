set tabstop=2 " tabs will show as 2 spaces
set shiftwidth=2 " autoindent and <C->>> will create 2 spaces
set textwidth=79 " lines will wrap after 79 characters

" It would be nice to figure out how to move this to ~/.vim/after/tex.vim. When
" I tried it, vim latex doesn't recognize my settings.
" stuff added for Latex-Suite

" this stuff some how fucks up my python highlighting if it is in my .vimrc

" stuff added for Latex-Suite

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
" set shellslash

" " IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a singe file. This will confuse Latex-Suite. Set your grep
" " program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" " OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.
set sw=2

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

let g:Tex_IgnoredWarnings="Underfull\nOverfull\nspecifier changed to\nYou have requested\nMissing number, treated as zero.\nThere were undefined references\nCitation %.%# undefined\nLaTeX Font Warning"
let g:Tex_IgnoreLevel=8
let g:Tex_ViewRule_pdf='evince $*.pdf'
let g:Tex_ViewRule_dvi='evince $*.pdf'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_GotoError=0
let g:Tex_CompileRule_pdf='pdflatex $*.tex && bibtex $*.aux && pdflatex $*.tex && pdflatex $*.tex'
let g:Tex_CompileRule_dvi='latex $*.tex && bibtex $*.aux && latex $*.tex && latex $*.tex && dvipdf $*.dvi $.pdf'
let g:tex_indent_items = 1
