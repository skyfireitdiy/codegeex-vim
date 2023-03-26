# Codegeex-Vim

Codegeex-Vim is a Vim plugin that enables you to easily generate code snippets using Codegeex API. Codegeex is an AI-powered programming assistant that helps developers generate high-quality, production-ready code. With this plugin, you can quickly generate code and seamlessly integrate it into your workflow.

## Installation

To install the plugin, use your preferred Vim plugin manager:

- [vim-plug](https://github.com/junegunn/vim-plug): `Plug 'codegeex/codegeex-vim'`
- [Vundle](https://github.com/VundleVim/Vundle.vim): `Plugin 'codegeex/codegeex-vim'`

Note: Make sure Python3 is installed on your system.

## Usage

The plugin provides the following commands:

- `GenCode([ins])`: This command generates a code snippet based on the currently active buffer or visual selection. If the cursor is in insert mode when the command is run, the generated code will be inserted in insert mode. If `ins` is 1, the command will force insert mode. Example: `:call codegeex#GenCode(0)` or `<C-\>` in normal mode.
- `TransCode()`: This command translates code from the source language to a chosen destination language. Example: `:call codegeex#TransCode()` or `<C-\>` in visual mode.
- `SetTianqiKeyFile(keyfile)`: This command sets the path to the Tianqi API key file. By default, the plugin looks for the file at `~/.tianqi.key`. Example: `:call codegeex#SetTianqiKeyFile('/path/to/tianqi/key/file')`.

## Configuration

Here's an example configuration for the plugin commands:

```
inoremap <C-\> <ESC>:call codegeex#GenCode(1)<CR>
nnoremap <C-\> :call codegeex#GenCode(0)<CR>
vnoremap <C-\> <Esc>:call codegeex#TransCode()<CR>
```

## License

MIT License. See LICENSE for more details.
