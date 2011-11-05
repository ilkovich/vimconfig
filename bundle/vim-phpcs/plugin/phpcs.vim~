function! RunPhpcs()
let l:filename=@%
let l:phpcs_output=system('phpcs --report=csv --standard=Pear '.l:filename)
cexpr l:phpcs_output
cwindow
endfunction

set errorformat=%E\"%f\"\\,%l\\,%c\\,error\\,\"%m\"\\,%*[a-zA-Z.],%W\"%f\"\\,%l\\,%c\\,warning\\,\"%m\"\\,%*[a-zA-Z.],%-GFile\\,Line\\,Column\\,Severity\\,Message\\,Source
set errorformat+=\"%f\"\\,%l\\,%c\\,%t%*[a-zA-Z]\\,\"%m\"
command! Phpcs execute RunPhpcs()
