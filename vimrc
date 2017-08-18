"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

let g:vim_bootstrap_langs = "go,html,javascript,php"
let g:vim_bootstrap_editor = "vim"				" nvim or vim

if !filereadable(vimplug_exists)
  echo "Installing Vim-Plug..."
  echo ""
  silent !\curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

" Plug 'SirVer/ultisnips'
Plug 'tpope/vim-sensible'
Plug 'honza/vim-snippets'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/vimshell'
Plug 'tpope/vim-fugitive'
Plug 'editorconfig/editorconfig-vim'
Plug 'kien/ctrlp.vim'
Plug 'flazz/vim-colorschemes'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'majutsushi/tagbar'
Plug 'lukaszkorecki/CoffeeTags', { 'do': 'gem install CoffeeTags' }
Plug 'airblade/vim-gitgutter'
Plug 'fatih/vim-go'
Plug 'w0rp/ale'
Plug 'kchmck/vim-coffee-script'
Plug 'wavded/vim-stylus'
Plug 'digitaltoad/vim-jade'
Plug 'Chiel92/vim-autoformat'
Plug 't9md/vim-quickhl'
Plug 'vim-scripts/calendar.vim--Matsumoto'
Plug 'tpope/vim-speeddating'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
Plug 'Shougo/unite.vim'
Plug 'ervandew/supertab'
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh' }
Plug 'ternjs/tern_for_vim'
Plug 'mxw/vim-jsx'
autocmd! User YouCompleteMe call youcompleteme#Enable()

call plug#end()

set number
set tabstop=2
set expandtab
set cindent
set shiftwidth=2
set softtabstop=2
set completeopt=menu,longest
set noswapfile
set mouse=a
set clipboard=unnamed
let g:Powerline_symbols = 'fancy'

imap jj <ESC>

" Theme
if has('gui_running')
  set background=light
  set guifont=Menlo:h12
  colorscheme solarized
else
  "set background=light
endif

" YCM
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" NERDTree
map <Leader>n <plug>NERDTreeTabsToggle<CR>
let g:nerdtree_tabs_open_on_console_startup = 1

" Tagbar
map <Leader>c :TagbarToggle<CR>
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
let g:tagbar_indent = 1
let g:tagbar_autoshowtag = 1

" Golang
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>gt <Plug>(go-doc-tab)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:syntastic_go_checkers = ['go', 'govet', 'golint', 'errcheck']

" vim-matchmaker
let g:matchmaker_enable_startup = 1

" For jsx
let g:jsx_ext_required = 0

" AutoFormat
noremap <Leader> f :Autoformat<CR><CR>

