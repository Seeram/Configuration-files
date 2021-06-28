"" Use with caution!
""
"" TODO 
"" - taglist window with useless status bar

"" no compatible with vi
set nocompatible
"" syntax highlighting
syntax on
"" visual wink from terminal
set visualbell
"" encoding written to file
set fileencoding=utf-8
"" encoding displayed
set encoding=utf-8
"" don't make lines wider than terminal, wrap them
set wrap
"" tab width
set tabstop=4
"" number of space characters for indentation
set shiftwidth=4
"" spaces instead of tabs
" set expandtab
"" highlighting 
set hlsearch
"" setting leader key
let mapleader = ","
"" autoindentation
set autoindent
"" max length of line
set colorcolumn=100

""  Plug - plugin manager https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

"" universal compatitible mode
Plug 'tpope/vim-sensible'
"" file system explorer
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"" easy to use commenter
Plug 'scrooloose/nerdcommenter'
"" asynchronous lint engine
Plug 'w0rp/ale'
"" overview of source code
Plug 'vim-scripts/taglist.vim'
"" colortheme
Plug 'altercation/vim-colors-solarized'
"" redefined search command
Plug 'henrik/vim-indexed-search'
"" intelisense for vim
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
"" completition of parenthesis etc.
Plug 'Raimondi/delimitMate'
"" working directory changed to root of git repository
Plug 'airblade/vim-rooter'
"" dynamic file opening
Plug 'ctrlpvim/ctrlp.vim'
"" git plugin
Plug 'tpope/vim-fugitive'
"" vim-tmux navigator
Plug 'christoomey/vim-tmux-navigator'

call plug#end()
""  Plug

    set statusline+=%#PmenuSel#
    set statusline+=%{StatuslineGit()}
    set statusline+=%#LineNr#
"" file path(full)
    set statusline +=%4*\ %<%F%*
"" modified flag
    set statusline +=%2*%m%*
"" current line number
    set statusline +=%1*%=%5l%*
"" total line number
    set statusline +=%2*/%L%*
"" column number
    set statusline +=%1*%4v\%*

"" show status bar always '0' for never, '1' if you have 2 or more windows and '2' for always
set laststatus=2

"" more readable font
set background=dark
colorscheme solarized

"" highlight current cursorline
set cursorline
hi CursorLine cterm=NONE


"" each time a new or existing file is edited, Vim will try to recognize the type of the file and set the 'filetype' option. This will trigger the FileType event, which can be used to set the syntax highlighting, set options, etc."
filetype on
"" enable loading the plugin files for specific file types
filetype plugin on
"" enable loading the indent file for specific file types
filetype indent on

"" Set relative numbering and toggling to make copy pasting easier
set number
"" Turn line numbering on at startup
"" Toggle line numbers from none at all
"" to relative numbering with current line number
noremap <F1> :set invnumber<CR>


"" press <F2> when trying to paste trying to paste from other applications
set pastetoggle=<F2>
set list
set listchars=tab:▸\ ,trail:·

""  Ale(asynchronous lint engine) options
let g:airline#extensions#ale#enabled = 1

let g:ale_linters = { 'perl': ['perl']  }

"" shown warnings are shared between multiple files
let g:ale_set_loclist       = 0
let g:ale_set_quickfix      = 1
""  Ale

"" TagOList on right side
let Tlist_Use_Right_Window = 1

"" run Tlist and focus on (last accessed) window
autocmd VimEnter * TlistOpen | wincmd p

noremap <F3> :TlistToggle<CR>:wincmd l<CR>
noremap <F4> :set list!<CR>

""  Coc.vim
let g:coc_disable_startup_warning = 1

"" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
""  Coc.vim

""  CtrlP.vim
if executable('fd')
    let g:ctrlp_user_command = 'fd --type f --color=never "" %s'
    let g:ctrlp_use_caching = 0
    let g:ctrlp_match_window_reversed = 0
endif
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_regexp = 0
let g:ctrlp_by_filename = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v(\.git|venv|deps|_build)',
            \ 'file': '\v(__init2__\.py|\.pyc)$',
            \ }

nnoremap <leader>, :CtrlP<CR>
""  CtrlP.vim

""  get git branch, used in setatus line
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let branchname = GitBranch()
  return strlen(branchname) > 0 ? branchname : ''
endfunction
""  get git branch, used in setatus line

"" perltidy
function! Perl()
"" Tidy selected lines (or entire file) with _t:
    nnoremap <silent> <F11> m`:%!perltidy<cr>g``
    vnoremap <silent> <F11> :!perltidy<cr>

"" Deparse obfuscated code
    nnoremap <silent> <F12> :.!perl -MO=Deparse 2>/dev/null<cr>
    vnoremap <silent> <F12> :!perl -MO=Deparse 2>/dev/null<cr>
endfunction

"
" Call Perl() when you open a Perl file
autocmd FileType perl call Perl()
autocmd BufNewFile,BufRead *.t call Perl()
"" perltidy

function! PerlOpenModule(type)
    " t s v
    let l:line = line(".")
    let l:col = col(".")
    let l:file = expand("%:p")

    let l:cmd = "/home/behun/.vim/find_perl_module.pl " . l:file . " " . l:line . " " . l:col . " " . a:type
    let l:result = system(l:cmd)
    let l:result = substitute(l:result, '\n\+$', '', '')
    if strlen(l:result) > 10
        let l:tokens = split(l:result, "\t")
        if a:type == 1
            execute "tabnew " . l:tokens[0]
        elseif a:type == 2
            execute "split " . l:tokens[0]
        elseif a:type == 3
            execute "vsplit " . l:tokens[0]
        else
            execute "e " . l:tokens[0]
        endif
        execute l:tokens[1]
    endif
endfunction

"" tabnew
autocmd FileType perl nnoremap <buffer> <leader>mt  :call PerlOpenModule(1)<CR>
"" split
autocmd FileType perl nnoremap <buffer> <leader>ms  :call PerlOpenModule(2)<CR>
"" vsplit
autocmd FileType perl nnoremap <buffer> <leader>mv  :call PerlOpenModule(3)<CR>
"" edit
autocmd FileType perl nnoremap <buffer> <leader>mm  :call PerlOpenModule(4)<CR>
autocmd FileType perl nnoremap <buffer> <leader>mp  :call PerlOpenModule(5)<CR>

