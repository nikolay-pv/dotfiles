set nocompatible              " be iMproved, required

" start Plug and set the runtime path
call plug#begin('~/.vim/bundle')
" Keep Plugin commands between plug#begin/end.
" Make sure you use single quotes

" version controls
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'vim-scripts/vcscommand.vim'
Plug 'mileszs/ack.vim'
" nerd set
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"Plug 'tyok/nerdtree-ack', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
" language
Plug 'beloglazov/vim-online-thesaurus'
Plug 'rhysd/vim-grammarous'
" spellcheck of code
Plug 'kamykn/spelunker.vim'
" vim improvements
Plug 'thinca/vim-localrc'
Plug 'moll/vim-bbye'
Plug 'easymotion/vim-easymotion'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
"Plug 'xolox/vim-misc'
"Plug 'xolox/vim-easytags'
Plug 'ludovicchabant/vim-gutentags', {'for': ['c', 'cpp', 'h', 'hpp', 'py']}
Plug 'majutsushi/tagbar'
Plug 'andrewradev/linediff.vim'
" handy plugin for marks
Plug 'kshenoy/vim-signature'
" fuzzy file opener
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-rooter'
Plug 'rizzatti/dash.vim'
" cpp
Plug 'ncm2/ncm2', {'on': []}
Plug 'roxma/nvim-yarp', {'on': []}
Plug 'ncm2/ncm2-jedi', {'on': []}
Plug 'ncm2/ncm2-bufword', {'on': []}
Plug 'ncm2/ncm2-path', {'on': []}
Plug 'Shougo/neoinclude.vim', {'on': []}
Plug 'ncm2/ncm2-neoinclude', {'on': []}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh', 'on' : []}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc-json'
"Plug 'neoclide/coc-yaml'
"Plug 'neoclide/coc-xml'
"Plug 'neoclide/coc-python'
"Plug 'neoclide/coc-highlight'
"Plug 'neoclide/coc-solargraph'
Plug 'honza/vim-snippets'
Plug 'rhysd/vim-clang-format'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
" notes
Plug 'vimwiki/vimwiki'
" go together
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/VimFold4C'
" highlight syntax
Plug 'pboettch/vim-cmake-syntax'
Plug 'bfrg/vim-cpp-modern'
Plug 'peterhoeg/vim-qml'
Plug 'aklt/plantuml-syntax'
Plug 'keith/swift.vim'
" does not allow to fold....
"Plug 'arakashic/chromatica.nvim'
" A - for switching between source and header files
Plug 'micbou/a.vim'
" colorschemes
Plug 'rakr/vim-one'
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'mhartington/oceanic-next'
"Plug 'jeaye/color_coded'
"Plug 'scrooloose/syntastic'
" utilities

call plug#end()

" To ignore plugin indent changes, instead use:
filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Faster bufs switching: below, above, right, left
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" buffer navigation
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

"" Syntax
"enable syntax highlighting
syntax on
" enable all python syntax highlighting features
let python_highlight_all = 1

colorscheme onedark
let g:onedark_terminal_italics=1
highlight Comment cterm=italic
" highlight spaces
:highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

" Show trailing whitespace:
:match ExtraWhitespace /\s\+$/
" Show trailing whitespace and spaces before a tab:
:match ExtraWhitespace /\s\+$\| \+\ze\t/
function TrimWhiteSpaces()
  %s/\s\+$//g
  ''
endfunction
nmap <leader>os :call TrimWhiteSpaces()<CR>

" set autoread when the file changed from outside
set autoread
" force check for log files
if has('nvim')
    au FocusGained *.log* :checktime
endif

" show line numbers
set number
set relativenumber

" show the matching part of the pair for [] {} ()
set showmatch

"" Command related tunings
" Enchance command-line completion
set wildmenu
set wildignorecase
set wildmode=full
set history=200
" history scrollers
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" expansion of active dir to avoid writing of %:h
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

"" Search
" search on typing
set incsearch
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" But case-sensitive if there are capital letters
set smartcase
" turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" convenience remapping to make sure search jump appears at the middle of the screen
nnoremap n nzz
nnoremap N Nzz
" perform the same substitution with the same parameters
noremap & :&&<CR>
xnoremap & :&&<CR>

" convenience remapping to jupm to a line number faster, instead of 123gg => 123<CR> in
" normal mode
nnoremap <CR> gg

" Autocompleteion
:imap <S-Tab> <C-P>

" Text, tabs and indent
" expand tabs into spaces
set expandtab

" indent when moving to the next line while writing code
set autoindent
set smartindent
set cino=N-s

" Wrap lines
set wrap

" set tabs to have 2 spaces
set ts=4
" set number of spaces for indentation
set shiftwidth=4

" Linebreak on 90 cheraters
set linebreak
set tw=90

" Set folding based on indent
set foldmethod=indent
autocmd BufRead,BufNewFile   *.c* setlocal foldmethod=syntax
autocmd BufRead,BufNewFile   *.h* setlocal foldmethod=syntax
autocmd BufRead,BufNewFile   *.cmake* setlocal foldmethod=indent
set nofoldenable
" space open/closes folds
nnoremap <space> za

" Pressing \ss will toggle and untoggle spell checking
set spelllang=en_gb
map <leader>ss :setlocal spell!<cr>
map <leader>css ZT<cr>

let g:spelunker_check_type = 2

" automatically check spelling in some buffers
au BufNewFile,BufRead COMMIT_EDITMSG setlocal spell
au BufNewFile,BufRead *.wiki setlocal spell

" Shared clipboard with OS (should work on all the platforms)
set clipboard^=unnamed,unnamedplus
let g:clipboard = {
  \ 'name': 'pbcopy',
  \ 'copy': {
  \    '+': 'pbcopy',
  \    '*': 'pbcopy',
  \  },
  \ 'paste': {
  \    '+': 'pbpaste',
  \    '*': 'pbpaste',
  \ },
  \ 'cache_enabled': 0,
  \ }

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" autoscroll
set scrolloff=3

" ############################################################################
" #          Configure any plugin-specific settings and mappings.            #
" ############################################################################

" ------------------------------- NerdTree ------------------------------------
" Nerd short-cut
map <C-n> :NERDTreeToggle<CR>
let NERDTreeDirArrows=1
let NERDTreeQuitOnOpen=0

" ---------------------------------- Ack --------------------------------------
" Silver searcher with ack
let g:ackprg = 'ag --nogroup --nocolor --column'

" --------------------------------- TagBar -----------------------------------
let g:tagbar_autoclose = 1
nmap <Leader>t :TagbarToggle<CR>
" config tags
set tags=./tags;/

" ------------------------------- FzF ---------------------------------
set rtp+=/usr/local/opt/fzf
" This is the default extra key bindings
"let g:fzf_action = {
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-x': 'split',
"  \ 'ctrl-v': 'vsplit' }

" ------------------------------- GuetenTags ---------------------------------
":set statusline+=%{gutentags#statusline('[',']')}
:let g:gutentags_project_root=['.git']

" ----------------------------Silver Searcher --------------------------------
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

" ------------------------------- Clang-tools  --------------------------------
nmap <leader>clf <plug>(operator-clang-format)
let g:clang_format#detect_style_file=1

" ------------------------------- Syntax Cpp  ---------------------------------
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_template_highlight = 1

" ----------------------------------- A ---------------------------------------
nmap <leader>hh :A<CR>

" -------------------------------- airline ------------------------------------
let g:airline#extensions#default#section_truncate_width = {
      \ 'a': 45,
      \ 'b': 85,
      \ 'c': 80,
      \ 'x': 60,
      \ 'y': 88,
      \ 'z': 45,
      \ 'warning': 75,
      \ 'error': 78,
      \ }

let g:airline_section_z = '%3l/%L:%3v'

let g:airline_mode_map = {
  \ '__' : '-',
  \ 'c'  : 'C',
  \ 'i'  : 'I',
  \ 'ic' : 'I',
  \ 'ix' : 'I',
  \ 'n'  : 'N',
  \ 'ni' : 'N',
  \ 'no' : 'N',
  \ 'R'  : 'R',
  \ 'Rv' : 'R',
  \ 's'  : 'S',
  \ 'S'  : 'S',
  \ '' : 'S',
  \ 't'  : 'T',
  \ 'v'  : 'V',
  \ 'V'  : 'V',
  \ '' : 'V',
  \ }

" add coc.nvim to airline
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

"Change error symbol:
"let airline#extensions#coc#error_symbol = 'Error:'
"Change warning symbol:
"let airline#extensions#coc#error_symbol = 'Warning:'
"Change error format:
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
"Change warning format:
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

"This extension hides the fugitive://**// part of the buffer names
let g:airline#extensions#fugitiveline#enabled = 1

" ---------------------------------- Bbye --------------------------------------

nnoremap <Leader>q :Bdelete<CR>

" ---------------------------------- COC --------------------------------------
"  general
"  add spelling dictionary to completion
set complete+=k
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
set hidden

" <TAB>: completion.
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` for navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <leader>fd <Plug>(coc-definition)
nmap <leader>ft <Plug>(coc-type-definition)
nmap <leader>fi <Plug>(coc-implementation)
nmap <leader>fr <Plug>(coc-references)

" clls specific
" caller
nmap <leader>fc <Plug>(coc-references)
"nmap <leader>fc :call CocLocations('ccls','$ccls/call')<cr>
" callee
nmap <leader>fC :call CocLocations('ccls','$ccls/call',{'callee':v:true})<cr>
" bases
nmap <leader>ffb :call CocLocations('ccls','$ccls/inheritance')<cr>
" derived
nmap <leader>ffd :call CocLocations('ccls','$ccls/inheritance',{'derived':v:true})<cr>

" Use K for show documentation in preview window
nnoremap <leader>fh :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <leader>rr <Plug>(coc-rename)

" Remap for format selected region
vmap <leader>fm  <Plug>(coc-format-selected)
nmap <leader>fm  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  "autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>ff  <Plug>(coc-fix-current)

" Use `:Format` for format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` for fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

"  highlight
" increase updatetime for CursorHold to 1,5 second
set updatetime=1500
autocmd CursorHold * silent call CocActionAsync('highlight')

" coc-snippet
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" ---------------------------------- Dash -------------------------------------
:nmap <silent> <leader>d <Plug>DashSearch

" ---------------------------------- Gdb --------------------------------------
let g:nvimgdb_config_override = {
  \ 'key_continue':   '<leader>gc',
  \ 'key_next':       '<leader>gn',
  \ 'key_step':       '<leader>gs',
  \ 'key_finish':     '<leader>gf',
  \ 'key_breakpoint': '<leader>gb',
  \ 'key_frameup':    '<leader>gu',
  \ 'key_framedown':  '<leader>gd',
  \ 'key_eval':       '<leader>ge',
  \ 'split_command': 'vsplit'
  \ }

" ------------------------------- Easymotion -----------------------------------
" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap <leader>m <Plug>(easymotion-overwin-f)

nmap <leader>w <Plug>(easymotion-w)
nmap <leader>W <Plug>(easymotion-W)
"nmap <leader>f{char} <Plug>(easymotion-f)
"nmap <leader>F{char} <Plug>(easymotion-F)
"nmap <leader>t{char} <Plug>(easymotion-t)
"nmap <leader>T{char} <Plug>(easymotion-T)
nmap <leader>b <Plug>(easymotion-b)
nmap <leader>B <Plug>(easymotion-B)
nmap <leader>e <Plug>(easymotion-e)
nmap <leader>E <Plug>(easymotion-E)
"nmap <leader>ge <Plug>(easymotion-ge)
"nmap <leader>gE <Plug>(easymotion-gE)
nmap <leader>n <Plug>(easymotion-n)
nmap <leader>N <Plug>(easymotion-N)
nmap <leader>s <Plug>(easymotion-s)

" JK motions: Line motions
map <leader>j <Plug>(easymotion-j)
map <leader>k <Plug>(easymotion-k)

" ------------------------------- VimWiki -----------------------------------
" Disable table mappings as they hijack the tab completions
let g:vimwiki_table_mappings=0
let g:vimwiki_folding='list'
let g:vimwiki_text_ignore_newline=0

let g:vimwiki_list = [{'path': '~/vimwiki/', 'auto_export': 1, 'css_name': '~/vimwiki/vimwiki-assets/style.css',
            \ 'template_path': '~/vimwiki/vimwiki-assets/',
            \ 'template_default': 'default',
            \ 'template_ext': '.tpl',
            \ 'auto_diary_index': 1
            \ }]
":nmap <Leader>wn <Plug>VimwikiNextLink
":nmap <Leader>wp <Plug>VimwikiPrevLink
" allow longer lines
au BufNewFile,BufRead *.wiki setlocal tw=110

let g:python3_host_prog="/usr/local/bin/python3"

" ------------------------------- MakePrg -----------------------------------
autocmd QuickFixCmdPost make belowright cwindow

