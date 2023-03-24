let g:tianqiKeyFile = expand("~/.tianqi.key")

let file_types = {
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
    return get(file_types, file_type, 'Unknown')
endfunction

function! codegeex#SetTianqiKeyFile(keyfile)
    let g:tianqiKeyFile = a:keyfile
endfunction

function! codegeex#GenCode()
    let lang = codegeex#getLanguage()
    if lang == "Unknown"
        return
    endif
    let back = @a
    normal! "aygg
    let code = @a
    let result = system("python3 ~/.local/share/nvim/plugged/codegeex-vim/autoload/codegeex.py gen " . lang . " " . shellescape(code) . " --keyfile " . shellescape(g:tianqiKeyFile))
    let @a = result
    set paste
    call feedkeys("\<C-o>a\<C-r>a\<ESC>")
    set nopaste
endfunction


