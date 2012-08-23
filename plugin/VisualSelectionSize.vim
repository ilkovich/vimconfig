 function! VisualSelectionSize() 
        if mode() == "v" 
            " Exit and re-enter visual mode, because the marks 
            " ('< and '>) have not been updated yet. 
            exe "normal \<ESC>gv" 
            if line("'<") != line("'>") 
                return (line("'>") - line("'<") + 1) . ' lines' 
            else 
                return (col("'>") - col("'<") + 1) . ' chars' 
            endif 
        elseif mode() == "V" 
            exe "normal \<ESC>gv" 
            return (line("'>") - line("'<") + 1) . ' lines' 
        elseif mode() == "\<C-V>" 
            exe "normal \<ESC>gv" 
            return (line("'>") - line("'<") + 1) . 'x' . (abs(col("'>") - col("'<")) + 1) . ' block' 
        else 
            return '' 
        endif 
    endfunction 

