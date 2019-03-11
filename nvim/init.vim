set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc

" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['cquery',
    \ '--log-file=~/cq.log',
    \ '--init={"cacheDirectory":"~/cquery/"}'],
    \ 'c': ['cquery',
    \ '--log-file=~/cq.log',
    \ '--init={"cacheDirectory":"~/cquery/"}'] 
    \ }

set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()
let g:LanguageClient_useVirtualText=0
let g:LanguageClient_hoverPreview="Never"

noremap <leader>rr :call LanguageClient#textDocument_rename()<CR>
" finding
noremap <leader>fd :call LanguageClient#textDocument_definition()<CR>
noremap <leader>fr :call LanguageClient#textDocument_references()<CR>
nnoremap <leader>fs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <leader>fw :call LanguageClient#textDocument_workspaceSymbol()<CR>
" Send textDocument/hover when cursor moves.
augroup LanguageClient_config
  au!
  au BufEnter * let b:Plugin_LanguageClient_started = 0
  au User LanguageClientStarted setl signcolumn=yes
  au User LanguageClientStarted let b:Plugin_LanguageClient_started = 1
  au User LanguageClientStopped setl signcolumn=auto
  au User LanguageClientStopped let b:Plugin_LanguageClient_stopped = 0
  au CursorMoved * call LanguageClient_textDocument_hover() | call LanguageClient#textDocument_documentHighlight() 
augroup END

set clipboard+=unnamedplus

" ------------------------------ Deoplete -----------------------------------
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path="/Library/Developer/CommandLineTools/usr/lib/libclang.dylib"
let g:deoplete#sources#clang#clang_header="/Library/Developer/CommandLineTools/usr/lib/clang"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" ------------------------------ Chromatica -----------------------------------
"let g:chromatica#libclang_path= /"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib"
"let g:chromatica#enable_at_startup=1
