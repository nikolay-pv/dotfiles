set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'w0rp/ale'
Plugin 'Valloric/YouCompleteMe'
" relies on ycm
Plugin 'rdnetto/YCM-Generator'
" version controls
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'vcscommand.vim'
Plugin 'mileszs/ack.vim'
" nerd set
Plugin 'scrooloose/nerdtree'
Plugin 'tyok/nerdtree-ack'
Plugin 'scrooloose/nerdcommenter'
" language
Plugin 'beloglazov/vim-online-thesaurus'
Plugin 'rhysd/vim-grammarous'
" vim improvements
Plugin 'thinca/vim-localrc'
Plugin 'moll/vim-bbye'
Plugin 'easymotion/vim-easymotion'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-surround'
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'majutsushi/tagbar'
Plugin 'andrewradev/linediff.vim'
" handy plugin for marks
Plugin 'kshenoy/vim-signature'
" fuzzy file opener
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'rizzatti/dash.vim'
" Plugin 'brookhong/cscope.vim'
" Plugin 'autoload_cscope.vim'
" cpp
Plugin 'ronakg/quickr-cscope.vim'
Plugin 'rhysd/vim-clang-format'
" highlight
Plugin 'pboettch/vim-cmake-syntax'
" Plugin 'bfrg/vim-cpp-modern'
Plugin 'arakashic/chromatica.nvim'
" A - for switching between source and header files
Plugin 'micbou/a.vim'
" colorschemes
Plugin 'rakr/vim-one'
Plugin 'arcticicestudio/nord-vim'
Plugin 'joshdick/onedark.vim'
Plugin 'mhartington/oceanic-next'
" Plugin 'jeaye/color_coded'
"Plugin 'scrooloose/syntastic'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Faster bufs switching
"switching to below window
"switching to above window
"switching to right window
"switching to left window
no <C-j> <C-w>j 
no <C-k> <C-w>k 
no <C-l> <C-w>l 
no <C-h> <C-w>h 

"enable syntax highlighting
syntax on 
colorscheme onedark

" set autoread when the file changed from outside
set autoread

" change the pwd automatically 
autocmd BufEnter * silent! lcd %:p:h
" cd $mainbs

" show line numbers
set number 

" show the matching part of the pair for [] {} ()
set showmatch

" enable all python syntax highlighting features
let python_highlight_all = 1

" Enchance command-line completion
set wildmenu
set wildmode=longest:full,list:longest,full

"" Search
" search on typing
set incsearch
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" But case-sensitive if there are capital letters
set smartcase

" Autocompleteion
:imap <S-Tab> <C-P>

" Text, tabs and indent
" expand tabs into spaces
set expandtab

" indent when moving to the next line while writing code
set autoindent
set smartindent

" Wrap lines
set wrap

" set tabs to have 2 spaces
set ts=4

" set number of spaces for indentation
set shiftwidth=4

" Linebreak on 90 cheraters
set lbr
set tw=90

" Set folding based on indent
set foldmethod=indent
autocmd BufRead,BufNewFile   *.c* setlocal foldmethod=syntax
autocmd BufRead,BufNewFile   *.h* setlocal foldmethod=syntax
set nofoldenable

" Pressing ,ss will toggle and untoggle spell checking
set spelllang=en_gb
map <leader>ss :setlocal spell!<cr>

" Shared clipboard with OS
set clipboard=unnamed

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" autoscroll
set scrolloff=5

" ############################################################################
" #          Configure any plugin-specific settings and mappings.            #
" ############################################################################

" ----------------------------------- YCM ------------------------------------
" Apply YCM FixIt
map ff :YcmCompleter FixIt<CR>
" set up default config
" let g:ycm_global_ycm_extra_conf = '~/.vim/ycm_extra_conf_global.py'
" show all errors
let g:ycm_max_diagnostics_to_display=0
" syntax
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_seed_identifiers_with_syntax=1
" location with errors
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_insertion = 1

" ------------------------------- NerdTree ------------------------------------
" Nerd short-cut
map <C-n> :NERDTreeToggle<CR>
let NERDTreeDirArrows=1
let NERDTreeQuitOnOpen=0

" ---------------------------------- Ack --------------------------------------
" Silver searcher with ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" -------------------------------- CntrlP --------------------------------------
"let g:ctrlp_cmd = 'CtrlPMRU'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_cache_dir = '$HOME/.vim/.cache/ctrlp'
let g:ctrlp_max_files = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|CMakeProjectFiles)$',
  \ 'file': '\v\.(gif|ttf|png|rhtml|d|exe|so|dll|o|json|DS_Store|swp)$',
  \ }
let g:ctrlp_root_markers = ['.ctrlp']

" --------------------------------- TagBar -----------------------------------
let g:tagbar_autoclose = 1
nmap <Leader>t :TagbarToggle<CR>
"map <C-b> :TagbarToggle<CR>
" config tags
set tags=./tags;/

" ------------------------------- GuetenTags ---------------------------------
:set statusline+=%{gutentags#statusline('[',']')}
:let g:gutentags_project_root=['.ctrlp']

" ----------------------------Silver Searcher --------------------------------
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" ------------------------------- Cscope -------------------------------------
let g:quickr_cscope_keymaps = 0
" always open in quickfix window
let g:quickr_cscope_use_qf_g = 1
" nnoremap <leader>fa 
" nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nmap  <leader>fs <plug>(quickr_cscope_symbols)
" g: Find this definition
nmap  <leader>fg <plug>(quickr_cscope_global)
" d: Find functions called by this function
nmap  <leader>fd <plug>(quickr_cscope_functions)
" c: Find functions calling this function
nmap  <leader>fc <plug>(quickr_cscope_callers)
" t: Find this text string
nmap  <leader>ft <plug>(quickr_cscope_text)
" e: Find this egrep pattern
nmap  <leader>fe <plug>(quickr_cscope_egrep)
" f: Find this file
nmap  <leader>ff <plug>(quickr_cscope_files)
" i: Find files #including this file
nmap  <leader>fi <plug>(quickr_cscope_includes)

" ------------------------------- Clang-tools  --------------------------------
nmap  <leader>clf <plug>(operator-clang-format)
let g:clang_format#detect_style_file=1

" ------------------------------- Syntax Cpp  ---------------------------------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1

" ----------------------------------- A ---------------------------------------
nmap <leader>hh :A<CR>

