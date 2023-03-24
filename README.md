
# Codegeex-vim

Codegeex-vim is a Vim plugin for generating code summaries using [Codegeex](https://www.codegeex.com/), an online code summarization tool. This plugin allows users to generate code summaries directly from their Vim editor.

## Installation

Install using [vim-plug](https://github.com/junegunn/vim-plug) or another plugin manager:

```
Plug 'https://github.com/tianqixin/codegeex-vim'
```

Then, execute `:PlugInstall`.

This plugin requires Python 3 to be installed on your system.

## Usage

To use Codegeex-vim, first set your Codegeex API key by placing it in `~/.tianqi.key`.

Then, open a file in Vim and navigate to the code you want to summarize. Select the code you want to summarize using Visual Mode, and then execute:

```
:call codegeex#GenCode()
```

This will generate a summary of the selected code using Codegeex.

By default, Codegeex-vim uses the filetype of the current buffer to determine the language of the selected code, but this can be overridden by specifying the language as the first argument to `GenCode()`:

```
:call codegeex#GenCode('Python')
```

## Troubleshooting

If Codegeex-vim is not working as expected, try setting the `g:tianqiKeyFile` variable explicitly:

```
:call codegeex#SetTianqiKeyFile('/path/to/tianqi.key')
```

You can also check the output of the `:messages` command for error messages.

## Supported Languages

Codegeex-vim currently supports the following languages:

- C++
- C
- C#
- CUDA
- Objective-C
- Objective-C++
- Python
- Java
- Scala
- TeX
- HTML
- PHP
- JavaScript
- TypeScript
- Go
- Shell
- Rust
- CSS
- SQL
- Kotlin
- Pascal
- R
- Fortran
- Lean

If the code you want to summarize is written in a language not on this list, Codegeex may still be able to generate a summary, but it may not be as accurate.

