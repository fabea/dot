          " _                        
         " (_)                       
  " __   __ _  _ __ ___   _ __  ___  
  " \ \ / /| || '_ ` _ \ | '__|/ __| 
  " _\ V / | || | | | | || |  | (__  
 " (_)\_/  |_||_| |_| |_||_|   \___| 
 "
" --------------------------------------
"
"         (C) 2021 Alex Yan.
"   A simple VIM setup for python.
"
" --------------------------------------
"" Plugin settings
call plug#begin('~/.vim/plugged')
" tpope cult
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
" python related
Plug 'Glench/Vim-Jinja2-Syntax',{'for':'html'}
Plug 'jeetsukumaran/vim-pythonsense',{'for':'python'}
" erlang
Plug 'vim-erlang/vim-erlang-tags'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-omnicomplete'
" completion
Plug 'lifepillar/vim-mucomplete'
" ui
Plug 'romainl/vim-cool'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'sainnhe/sonokai'
Plug 'NLKNguyen/papercolor-theme'
" basic editting
Plug 'rhysd/clever-f.vim'
Plug 'sheerun/vim-polyglot' 
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
" js
Plug 'pangloss/vim-javascript',{'for':'javascript'}
Plug 'maxmellon/vim-jsx-pretty',{'for':'javascript'}
" tmux
Plug 'christoomey/vim-tmux-navigator'
" completions
Plug 'mattn/emmet-vim'
Plug 'honza/vim-snippets'
" searching
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'pbogut/fzf-mru.vim'
" " nnn
Plug 'mcchrish/nnn.vim'

call plug#end()

"" vim basic settings
set clipboard=unnamed
set number
set shortmess-=S showcmd showmatch
set fileformat=unix fileformats=unix,dos
autocmd BufEnter * silent! lcd %:p:h
filetype plugin indent on

"" gui
if has('termguicolors')
  set termguicolors
endif
if &term == "alacritty"
  let &term = "xterm-256color"
endif
set noshowmode
if has('gui_running')
  " set guifont=Sarasa\ Fixed\ Slab\ SC:h13
  set guifont=Consolas:h14
else 
  set t_Co=256
endif
let &t_ut=''
set go      =
set vb t_vb =
au GUIEnter * simalt ~x

"" colorscheme
let g:sonokai_style = 'maia'
let g:sonokai_enable_italic = 1
let g:sonokai_disable_italic_comment = 1
colorscheme sonokai 
let g:lightline = {
      \ 'colorscheme': 'sonokai',
      \ }
:set laststatus=2

" color and font setting for classroom
function! ClassroomColorFontSettings()
  set guifont=Consolas:h18
  colorscheme PaperColor
  set background=light
  let g:lightline = { 'colorscheme': 'PaperColor' }
endfunction
command Classroom call ClassroomColorFontSettings()

"" indent line
let g:indentLine_char_list            = ['|', '¦', '┆', '┊']
let g:indentLine_enabled              = 1
let g:indentLine_showFirstIndentLevel = 1

"" for python
autocmd FileType python setlocal ai et sw=4 ts=4

"" dispatch for py
autocmd FileType python setlocal makeprg=python\ %
autocmd FileType python let b:dispatch = 'pytest %'
autocmd FileType python noremap  <F5> :Make<cr>
autocmd FileType python noremap  <F6> :Dispatch<cr>
autocmd FileType python noremap  <F7> :Dispatch flake8 %<cr>

"" dispatch for js
autocmd FileType javascript setlocal makeprg=node\ %
" autocmd FileType javascript noremap  <F5> :Make<cr>
autocmd FileType javascript noremap  <F5> :Dispatch npx nodemon %<cr>

"" vim-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" clever-f
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" coc
" source ~/.coc_config.vim

" keybindgs
" jk to replace esc
inoremap jk <ESC>
" Leader
let mapleader=" "
" fzf
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>ff :Files ~/Code<CR>
nnoremap <silent> <Leader>fg :GFiles<CR>
nnoremap <silent> <Leader>rg :Rg<CR>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>g :Commits<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>
nnoremap <silent> <Leader>mru :FZFMru<CR>
nnoremap <silent> <Leader>? :Maps<CR>

" nnn
let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' }  }
let g:nnn#action = {
      \ '<c-t>': 'tab split',
      \ '<c-x>': 'split',
      \ '<c-v>': 'vsplit' }

" prevent lightline from disappearing each time source the main config
call lightline#update()

" completion
set completeopt-=preview
set completeopt+=longest,menuone,noselect
" let g:mucomplete#enable_auto_at_startup = 1
if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
        \	if &omnifunc == "" |
        \		setlocal omnifunc=syntaxcomplete#Complete |
        \	endif
endif

" formatter
" erlang format
autocmd FileType erlang autocmd BufWritePre <buffer> 
      \silent execute '!rebar3 fmt --write %' 
      \| edit!
      \| redraw!
