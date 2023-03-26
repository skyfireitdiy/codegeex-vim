let s:tianqiKeyFile = expand("~/.tianqi.key")
let s:dest_lang = ""

let s:file_types = {
            \ 'cpp': 'C++',
            \ 'c': 'C',
            \ 'csharp': 'C#',
            \ 'cuda': 'Cuda',
            \ 'objc': 'Objective-C',
            \ 'objcpp': 'Objective-C++',
            \ 'python': 'Python',
            \ 'java': 'Java',
            \ 'scala': 'Scala',
            \ 'tex': 'TeX',
            \ 'html': 'HTML',
            \ 'php': 'PHP',
            \ 'javascript': 'JavaScript',
            \ 'typescript': 'TypeScript',
            \ 'go': 'Go',
            \ 'sh': 'Shell',
            \ 'rust': 'Rust',
            \ 'css': 'CSS',
            \ 'sql': 'SQL',
            \ 'kotlin': 'Kotlin',
            \ 'pascal': 'Pascal',
            \ 'r': 'R',
            \ 'fortran': 'Fortran',
            \ 'lean': 'Lean',
            \ }

function! codegeex#getLanguage()
    let file_type = &filetype
    return get(s:file_types, file_type, 'Unknown')
endfunction

function! codegeex#SetTianqiKeyFile(keyfile)
    let s:tianqiKeyFile = a:keyfile
endfunction

function! codegeex#GenCode(ins=0)
    let lang = codegeex#getLanguage()
    if lang == "Unknown"
        echo "Unsupported Language"
        return
    endif
    echo "Codegeex is thinking ..."
    let back = @a
    normal! "aygg
    let code = @a
    let result = system("python3 ~/.local/share/nvim/plugged/codegeex-vim/autoload/codegeex_gen.py " . lang . " " . shellescape(code) . " --keyfile " . shellescape(s:tianqiKeyFile))
    let @a = result
    set paste
    call feedkeys("\<C-o>a\<C-r>a\<ESC>")
    set nopaste
    if a:ins
        call feedkeys('a')
    endif
endfunction

function! codegeex#chooseDstLang(lst)
    let choices = []
    let i = 0
    for l in a:lst
        call add(choices, i . ' ' . l)
        let i = i + 1
    endfor
    return inputlist(choices)
endfunction


function! codegeex#getVisualText()
    let save_reg = @a
    normal! gv"ay
    let text = @a
    let @a = save_reg
    return text
endfunction


function! codegeex#openWindow()
    let buf_name = '__Codegeex_'.s:dest_lang.'__'
    let index = bufnr(buf_name)
    let new = 0
    if index == -1
        vsplit
        wincmd L
        enew
        execute 'file ' . buf_name
        let index = bufnr('%')
        let new = 1
    else
        if index(tabpagebuflist(), index) == -1
            vsplit
            wincmd L
            execute 'buffer' index
        else
            call win_gotoid(win_findbuf(index)[0])
        endif
    endif
    setlocal noswapfile
    setlocal hidden
    execute 'setlocal filetype=' . s:dest_lang
    setlocal buftype=nofile
endfunction


function! codegeex#handleTransResult(j,d,e)
    call codegeex#openWindow()
    let result = a:d
    call append(line('$'), result)
    call append(line('$'), '')
endfunction

function! codegeex#TransCode()
    let src_lang = codegeex#getLanguage()
    if src_lang == "Unknown"
        echo "Unsupported Language"
        return
    endif

    let ft_lst = []
    let lst = []
    let i = 0
    for [k,v] in items(s:file_types)
        call add(ft_lst, k)
        call add(lst, v)
        let i = i + 1
    endfor

    let index = codegeex#chooseDstLang(lst)
    if index < 0 || index >= len(lst)
        echo "Index out of range"
        return
    endif

    let s:dest_lang = ft_lst[index]
    let dst_lang = lst[index]

    echo "Codegeex is thinking ..."
    let code = codegeex#getVisualText()
    let cmd = "python3 ~/.local/share/nvim/plugged/codegeex-vim/autoload/codegeex_trans.py " . src_lang . " " . dst_lang . " " . shellescape(code)
    call jobstart(cmd, {"on_stdout": function('codegeex#handleTransResult'), 'stadout_buffered':1})
endfunction


" example config:
"
" inoremap <C-\> <ESC>:call codegeex#GenCode(1)<CR>
" nnoremap <C-\> :call codegeex#GenCode(0)<CR>
" vnoremap <C-\> <Esc>:call codegeex#TransCode()<CR>
