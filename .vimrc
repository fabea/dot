" --------------------------------------
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
" ui
Plug 'romainl/vim-cool'
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'NLKNguyen/papercolor-theme'
" basic editting
Plug 'matze/vim-move'
Plug 'rhysd/clever-f.vim'
Plug 'sheerun/vim-polyglot' 
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/vim-easy-align'
" tmux
Plug 'christoomey/vim-tmux-navigator'
" completions
Plug 'mattn/emmet-vim'
Plug 'honza/vim-snippets'
" searching
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/coc-yank', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-lists', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-emmet', { 'do': 'yarn install --frozen-lockfile' }
Plug 'neoclide/coc-snippets', { 'do': 'yarn install --frozen-lockfile' }
Plug 'fannheyward/coc-pyright', { 'do': 'yarn install --frozen-lockfile' }

call plug#end()

"" vim basic settings
set clipboard=unnamed
set number
set shortmess-=S showcmd showmatch
set fileformat=unix fileformats=unix,dos
autocmd BufEnter * silent! lcd %:p:h

"" gui
set noshowmode
if has('gui_running')
  " set guifont=Sarasa\ Fixed\ Slab\ SC:h13
  set guifont=Consolas:h14
else 
  set t_Co=256
endif
set go      =
set vb t_vb =
au GUIEnter * simalt ~x

"" colorscheme
colorscheme nord 
let g:lightline = {
      \ 'colorscheme': 'nord',
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

"" vim-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" clever-f
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)

" coc
source ~/.coc_config.vim

" prevent lightline from disappearing each time source the main config
call lightline#update()
