set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc

set clipboard+=unnamedplus

" ------------------------------ Chromatica -----------------------------------
let g:chromatica#libclang_path= "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/libclang.dylib"
let g:chromatica#enable_at_startup=1
