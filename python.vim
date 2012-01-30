set softtabstop=4 " sets the tab for size for indentation, will be a combination of tabs and spaces if expandtab isn't set
set shiftwidth=4 " sets how many spaces are created when shift(>>) or shift(<<) is pressed or autoindent is envoked
set textwidth=79 " sets the width of the text
set expandtab " the tab key in inset mode will output spaces instead of

" maps keys to commands
map <F10> :!clear;/usr/bin/env python '%'<CR>
