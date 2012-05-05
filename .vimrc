color wombat
syntax on 
set number
set ruler
set ic "ignore case
set smartcase "case sensitive when using capital letter
set title
set scrolloff=3
set hlsearch
set incsearch

set visualbell "pc speaker to visual alert

set nowrap
set autochdir "ch dir to current buffer location
set hidden "manage multiple buffers effectively

"tab completion
set wildmenu
set wildmode=list:longest

"These are very similar keys. Typing 'a will jump to the line in the current file marked with ma. However, `a will jump to the line and column marked with ma.
"it.s more useful in any case I can imagine, but it.s located way off in the corner of the keyboard. The best way to handle this is just to swap them:
nnoremap ' `
nnoremap ` '
"match if/else blocks with % sign.
runtime macros/matchit.vim

set history=1000

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()

filetype plugin indent on
" run file with PHP CLI (CTRL-M)
" autocmd FileType php noremap <C-M> :w!<CR>:!/usr/bin/php %<CR>

" PHP parser check (CTRL-L)
autocmd FileType php noremap <C-L> :!/usr/bin/php -l %<CR>
autocmd BufEnter build.ant noremap <buffer> <C-B> :!ant -f %<CR>

noremap ,; <Esc>:redraw!<Cr> 

noremap ,. @:
"map <F11> :DbgStepInto<CR>
"map <F10> :DbgStepOver<CR>
"map <S-F11> :DbgStepOut<CR>
"map <F5> :DbgRun<CR>
"map <S-F5> :DbgDetach<CR>
"map <C-F9> :DbgToggleBreakpoint<CR>

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR> 

noremap <silent> <F8> :TlistToggle<CR>
let Tlist_GainFocus_On_ToggleOpen = 1

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
"turn off search highlighting
nmap <silent> <leader>n :silent :nohlsearch<CR>

" let g:SuperTabDefaultCompletionType = "context"

set tabstop=4
set shiftwidth=4
set expandtab

"allows replacing text with r character
vmap r "_dP 

nnoremap ,c :JSHint<CR>

inoremap kj <Esc>

"Javascript folding http://amix.dk/blog/post/19132
function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType html set foldmethod=indent
au FileType css  set foldmethod=marker
au FileType css  set foldmarker={,}


"allow diffing rsync out files. 
function! Diffb()
    let line=getline(line('.'))    
    let files=split(line, ';', 0)
    echo files[0]
    execute "tabnew " . files[0]
    diffthis
    execute "vnew " . files[1]
    diffthis
endfunction 

function! FormatFileForDiff()
    %!grep '\.'
    %!grep -v 'bson'
    %s/\(.*\)/\/home\/ilkovich\/NetBeansProjects\/UrbanReach\/\1;scp:\/\/root@westport.thoughtvineinc.com\/\/home\/UrbanReach2\/www\/\1/g
    map <F2> :call Diffb()<CR>
endfunction

"format (indent) whole file
map <C-S-F> mzgg=G'z<CR>

set diffopt+=iwhite
set backupdir=/tmp
set directory=/tmp

noremap <C-S-Y> :FufBuffer<CR>

"  move text and rehighlight -- vim tip_id=224 
vnoremap > ><CR>gv 
vnoremap < <<CR>gv 

" Supertab settings
" supertab + eclim == java win
let g:SuperTabDefaultCompletionTypeDiscovery = [
\ "&completefunc:<c-x><c-u>",
\ "&omnifunc:<c-x><c-o>",
\ ]
let g:SuperTabLongestHighlight = 1

" Eclim settings
" ,i imports whatever is needed for current line
nnoremap <silent> <LocalLeader>i :JavaImport<cr>
" ,d opens javadoc for statement in browser
nnoremap <silent> <LocalLeader>d :JavaDocSearch -x declarations<cr>
" ,<enter> searches context for statement
nnoremap <silent> <LocalLeader><cr> :JavaSearchContext<cr>
" ,jv validates current java file
nnoremap <silent> <LocalLeader>jv :Validate<cr>
" ,jc shows corrections for the current line of java
nnoremap <silent> <LocalLeader>jc :JavaCorrect<cr>
" 'open' on OSX will open the url in the default browser without issue
let g:EclimBrowser='open'

"auto save / restore folds
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview
"

au BufRead,BufNewFile *.inc set filetype=php
