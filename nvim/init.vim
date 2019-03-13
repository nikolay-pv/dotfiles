set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc

set clipboard+=unnamedplus

" ------------------------------ ncm2 -----------------------------------
" completion enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()
" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect
set shortmess+=c
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" wrap existing omnifunc
    " Note that omnifunc does not run in background and may probably block the
    " editor. If you don't want to be blocked by omnifunc too often, you could
    " add 180ms delay before the omni wrapper:
    "  'on_complete': ['ncm2#on_complete#delay', 180,
    "               \ 'ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
au User Ncm2Plugin call ncm2#register_source({
        \ 'name' : 'css',
        \ 'priority': 9,
        \ 'subscope_enable': 1,
        \ 'scope': ['css','scss'],
        \ 'mark': 'css',
        \ 'word_pattern': '[\w\-]+',
        \ 'complete_pattern': ':\s*',
        \ 'on_complete': ['ncm2#on_complete#omni', 'csscomplete#CompleteCSS'],
        \ })

" ------------------------------ LangSever -----------------------------------
" Required for operations modifying multiple buffers like rename.
set hidden
let g:LanguageClient_serverCommands = {
    \ 'cpp': ['/usr/local/Cellar/llvm/7.0.1/Toolchains/LLVM7.0.1.xctoolchain/usr/bin/clangd'],
    \ 'c': ['/usr/local/Cellar/llvm/7.0.1/Toolchains/LLVM7.0.1.xctoolchain/usr/bin/clangd'],
    \ 'sh': ['bash-language-server', 'start']
    \ }
"set completefunc=LanguageClient#complete
set formatexpr=LanguageClient_textDocument_rangeFormatting()
let g:LanguageClient_useVirtualText=0
let g:LanguageClient_hoverPreview="Auto"

" close preview window
noremap <leader>pc :pc<CR>
noremap <leader>fh :call LanguageClient#textDocument_hover()<CR>
noremap <leader>rr :call LanguageClient#textDocument_rename()<CR>
" noremap ff :call LanguageClient#textDocument_rename()<CR>
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
  au CursorMoved * call LanguageClient#textDocument_documentHighlight() 
augroup END

