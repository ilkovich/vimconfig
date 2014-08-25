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
noremap '' <Esc>:cn<Cr>

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i 
nnoremap <C-P> :call PhpDocSingle()<CR> 
vnoremap <C-P> :call PhpDocRange()<CR> 

noremap <silent> <F8> :TlistToggle<CR>
let Tlist_GainFocus_On_ToggleOpen = 1

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
"turn off search highlighting
nmap <silent> <leader>n :silent :nohlsearch<CR>

"let g:SuperTabDefaultCompletionType = "context"

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

"format (indent) whole file
map <C-S-F> mzgg=G'z<CR>

set diffopt+=iwhite
set clipboard=unnamed

function! Compile()
  let origcurdir = getcwd()
  let curdir     = origcurdir

  while curdir != "/"
  if filereadable("Makefile")
    break
  elseif filereadable("SConstruct")
    break
  endif
  cd ..
  let curdir= getcwd()
  endwhile

  if filereadable('Makefile')
    set makeprg=make -j3 -k
  elseif filereadable('SConstruct')
    set makeprg=scons
  else
    set makeprg=make
  endif
  echo "building ... wait please!"
  silent w
  silent make
  redraw!
  cc!
endfunction

map ,m :call Compile()<CR>

noremap ,b <Esc>:FufBuffer<CR>
noremap ,t <Esc>:FufTaggedFile<CR>
noremap ,o <Esc>:FufFile<Cr>

"  move text and rehighlight -- vim tip_id=224 
vnoremap > ><CR>gv 
vnoremap < <<CR>gv 

"auto save / restore folds
"au BufWinLeave * mkview
"au BufWinEnter * silent loadview
"

au BufRead,BufNewFile *.inc set filetype=php
au BufRead,BufNewFile *.module set filetype=php
au BufRead,BufNewFile *.scss set filetype=less

"set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set statusline=%F[%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ %{VisualSelectionSize()}\ %=%c,%l/%L\ %P\ %n

set clipboard=unnamed

set tags=tags;/
"let g:easytags_dynamic_files = 1
"let g:easytags_async = 1

vmap "+y :!xclip -f -sel clip <CR>
map "+p :r!xclip -o -sel clip <CR>

set t_Co=256;

function s:find_jshintrc(dir)
    let l:found = globpath(a:dir, '.jshintrc')
    if filereadable(l:found)
        return l:found
    endif

    let l:parent = fnamemodify(a:dir, ':h')
    if l:parent != a:dir
        return s:find_jshintrc(l:parent)
    endif

    return "~/.jshintrc"
endfunction

function UpdateJsHintConf()
    let l:dir = expand('%:p:h')
    let l:jshintrc = s:find_jshintrc(l:dir)
    let g:syntastic_javascript_jshint_conf = l:jshintrc
endfunction

au BufEnter * call UpdateJsHintConf()

let g:syntastic_html_tidy_ignore_errors=['proprietary attribute','trimming empty <i>', 'trimming empty <span']

"surround lines with single qutoes
let @q=':s/^\(\s*\)\(.*\)$/\1''\2'',/g'

nnoremap QQ :qa<cr>

"let g:solarized_termtrans=1
let g:solarized_termcolors=256
colorscheme wombat
set background=dark

