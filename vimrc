" Modern Vim configuration.
" Keep machine-specific plugin declarations in ~/.vimrc.local.bundles and
" machine-specific options in ~/.vimrc.local.

scriptencoding utf-8
set nocompatible

let mapleader = ','
let maplocalleader = ','

" Startup-time plugin defaults. Keep these before plug#end(), where vim-plug
" loads plugin scripts.
let g:airline#extensions#vimtex#enabled = 0

" ---------------------------------------------------------------------------
" vim-plug
" ---------------------------------------------------------------------------
let s:plug_vim = expand('~/.vim/autoload/plug.vim')
let s:plugins_enabled = filereadable(s:plug_vim)

if s:plugins_enabled
  call plug#begin(expand('~/.vim/plugged'))

  " Editing primitives
  Plug 'tpope/vim-sensible'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'cohama/lexima.vim'
  Plug 'editorconfig/editorconfig-vim'

  " Project navigation and search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
  Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }

  " Git and statusline
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'airblade/vim-gitgutter'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Language support
  Plug 'dense-analysis/ale'
  Plug 'fatih/vim-go', { 'for': 'go' }
  Plug 'rust-lang/rust.vim', { 'for': 'rust' }
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-rails', { 'for': 'ruby' }
  Plug 'tpope/vim-rake', { 'for': 'ruby' }
  Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
  Plug 'mattn/emmet-vim', {
        \ 'for': ['html', 'css', 'scss', 'javascript', 'javascriptreact',
        \         'typescript', 'typescriptreact', 'vue']
        \ }

  " Theme
  Plug 'catppuccin/vim', { 'as': 'catppuccin' }

  if filereadable(expand('~/.vimrc.local.bundles'))
    source ~/.vimrc.local.bundles
  endif

  call plug#end()
else
  augroup vimrc_missing_vimplug
    autocmd!
    autocmd VimEnter * echohl WarningMsg
          \ | echom 'vim-plug not found; plugin setup was skipped. Install ~/.vim/autoload/plug.vim, then run :PlugInstall.'
          \ | echohl None
  augroup END
endif

" ---------------------------------------------------------------------------
" Core behavior
" ---------------------------------------------------------------------------
filetype plugin indent on
syntax enable

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,default,latin1
set fileformats=unix,dos,mac

set backspace=indent,eol,start
set hidden
set autoread
set confirm
set history=1000
set updatetime=300
set timeoutlen=500
set ttyfast

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smartindent
set shiftround

set ignorecase
set smartcase
set incsearch
set hlsearch

set wildmenu
set wildmode=longest:full,full
set wildignorecase
set wildignore+=*.o,*.obj,*.pyc,*.rbc,*.class,*.so,*.swp,*.zip
set wildignore+=*/.git/*,*/node_modules/*,*/target/*,*/dist/*,*/tmp/*

set splitbelow
set splitright
set scrolloff=5
set sidescrolloff=5
set display+=lastline
set linebreak

set mouse=a
set mousemodel=popup
if has('clipboard')
  set clipboard=unnamed
  if has('unnamedplus')
    set clipboard^=unnamedplus
  endif
endif

if exists('$SHELL')
  let &shell = $SHELL
endif

" ---------------------------------------------------------------------------
" Files, swap, backup, undo
" ---------------------------------------------------------------------------
let s:vim_dir = expand('~/.vim')
let s:state_dirs = {
      \ 'backup': s:vim_dir . '/backup',
      \ 'swap': s:vim_dir . '/swap',
      \ 'undo': s:vim_dir . '/undo',
      \ 'sessions': s:vim_dir . '/session',
      \ }

for s:dir in values(s:state_dirs)
  silent! call mkdir(s:dir, 'p', 0700)
endfor

let &backupdir = s:state_dirs.backup . '//,.'
let &directory = s:state_dirs.swap . '//,.'

set backup
set writebackup

if has('persistent_undo') && isdirectory(s:state_dirs.undo)
  let &undodir = s:state_dirs.undo . '//,.'
  set undofile
endif

" ---------------------------------------------------------------------------
" User interface
" ---------------------------------------------------------------------------
set number
set relativenumber
set ruler
set cursorline
if exists('+signcolumn')
  set signcolumn=yes
endif
set laststatus=2
set showcmd
set showmode
set title
set titleold=Terminal
set titlestring=%F
set list
set listchars=tab:>-,trail:.,extends:>,precedes:<,nbsp:+

if has('termguicolors')
  set termguicolors
endif

set background=dark
if !empty(globpath(&runtimepath, 'colors/catppuccin_mocha.vim'))
  colorscheme catppuccin_mocha
elseif !empty(globpath(&runtimepath, 'colors/habamax.vim'))
  colorscheme habamax
endif

set completeopt=menuone,noinsert,noselect

if exists('+diffopt')
  set diffopt+=vertical
  silent! set diffopt+=algorithm:histogram
  silent! set diffopt+=indent-heuristic
endif

runtime! macros/matchit.vim

" ---------------------------------------------------------------------------
" Commands
" ---------------------------------------------------------------------------
command! FixWhitespace %s/\s\+$//e

function! s:session_file(name) abort
  let l:name = empty(a:name) ? 'default' : a:name
  return s:state_dirs.sessions . '/' . l:name . '.vim'
endfunction

function! s:session_complete(arglead, cmdline, cursorpos) abort
  if !isdirectory(s:state_dirs.sessions)
    return []
  endif
  return map(glob(s:state_dirs.sessions . '/*.vim', 0, 1), 'fnamemodify(v:val, ":t:r")')
endfunction

function! s:save_session(name) abort
  silent! call mkdir(s:state_dirs.sessions, 'p', 0700)
  execute 'mksession! ' . fnameescape(s:session_file(a:name))
endfunction

function! s:open_session(name) abort
  execute 'source ' . fnameescape(s:session_file(a:name))
endfunction

function! s:delete_session(name) abort
  call delete(s:session_file(a:name))
endfunction

command! -nargs=1 -complete=customlist,s:session_complete SaveSession call s:save_session(<q-args>)
command! -nargs=1 -complete=customlist,s:session_complete OpenSession call s:open_session(<q-args>)
command! -nargs=1 -complete=customlist,s:session_complete DeleteSession call s:delete_session(<q-args>)
command! CloseSession tabonly | only

" ---------------------------------------------------------------------------
" Autocommands
" ---------------------------------------------------------------------------
augroup vimrc_general
  autocmd!
  autocmd FocusGained,BufEnter * silent! checktime
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | execute 'normal! g`"' | endif
augroup END

augroup vimrc_filetypes
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
  autocmd FileType go setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd FileType html,css,scss,javascript,javascriptreact,typescript,typescriptreact,json,yaml,yml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab colorcolumn=88
  autocmd FileType markdown,text,gitcommit setlocal wrap linebreak spell textwidth=0
augroup END

" ---------------------------------------------------------------------------
" Search backends
" ---------------------------------------------------------------------------
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
  command! -bang -nargs=* Rg call fzf#vim#grep(
        \ 'rg --column --line-number --no-heading --color=always --smart-case --hidden --glob "!.git/*" ' . shellescape(<q-args>),
        \ 1,
        \ fzf#vim#with_preview(),
        \ <bang>0)
elseif executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
endif

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit',
      \ }
let g:fzf_layout = { 'down': '40%' }

" ---------------------------------------------------------------------------
" Mappings
" ---------------------------------------------------------------------------
nnoremap <silent> <leader><space> :nohlsearch<CR>
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <leader>h :<C-u>split<CR>
nnoremap <leader>v :<C-u>vsplit<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

nnoremap <leader>. :lcd %:p:h<CR>
nnoremap <leader>z :bprevious<CR>
nnoremap <leader>q :bprevious<CR>
nnoremap <leader>x :bnext<CR>
nnoremap <leader>w :bnext<CR>
nnoremap <leader>c :bdelete<CR>

nnoremap <silent> <leader>e :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Rg<Space>
nnoremap <silent> <leader>g :GFiles<CR>
nnoremap <silent> <leader>y :History:<CR>
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
nnoremap <silent> <F4> :TagbarToggle<CR>

nnoremap <leader>gs :Git<CR>
nnoremap <leader>ga :Git add %<CR>
nnoremap <leader>gc :Git commit<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gl :Git pull<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>go :.GBrowse<CR>

nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<Space>
nnoremap <leader>sc :CloseSession<CR>

if has('terminal')
  nnoremap <silent> <leader>sh :terminal<CR>
endif

vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap YY "+y
vnoremap YY "+y
nnoremap XX "+x
vnoremap XX "+x
nnoremap <leader>p "+gP

cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" ---------------------------------------------------------------------------
" Plugin settings
" ---------------------------------------------------------------------------
let g:airline_theme = 'powerlineish'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1

let g:NERDTreeChDirMode = 2
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowBookmarks = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeWinSize = 36
let g:NERDTreeIgnore = ['\.pyc$', '\.rbc$', '\~$', '\.db$', '\.sqlite$', '__pycache__']

let g:tagbar_autofocus = 1

let g:ale_disable_lsp = 0
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'W'
let g:ale_fix_on_save = 0
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'go': ['gofmt'],
      \ 'python': ['black', 'isort'],
      \ 'ruby': ['rubocop'],
      \ 'javascript': ['prettier', 'eslint'],
      \ 'javascriptreact': ['prettier', 'eslint'],
      \ 'typescript': ['prettier', 'eslint'],
      \ 'typescriptreact': ['prettier', 'eslint'],
      \ 'json': ['prettier'],
      \ 'yaml': ['prettier'],
      \ }

nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> gr <Plug>(ale_find_references)
nmap <silent> K <Plug>(ale_hover)
nmap <silent> <leader>rn <Plug>(ale_rename)
nmap <silent> <leader>af <Plug>(ale_fix)
nmap <silent> [d <Plug>(ale_previous_wrap)
nmap <silent> ]d <Plug>(ale_next_wrap)

let g:go_list_type = 'quickfix'
let g:go_fmt_command = executable('goimports') ? 'goimports' : 'gofmt'
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

let g:rustfmt_autosave = 0
let g:user_emmet_leader_key = '<C-e>'

" ---------------------------------------------------------------------------
" Local overrides
" ---------------------------------------------------------------------------
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
