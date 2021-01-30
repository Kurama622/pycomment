## pycomment

![neovim](https://img.shields.io/badge/editor-neovim-green) ![vim](https://img.shields.io/badge/editor-vim-blue) ![gvim](https://img.shields.io/badge/editor-gvim-red)

ENGLISH  |  [中文版](./README_cn.md)

![pycomment](./screenshut/pycomment.gif)

### introduce

Automatic generate docstring including inputed parameters, returned variable , and their type.

### install

- [x] vim-plug
```vim
Plug 'demonlord1997/pycomment', {'for','python'}
```
- [x] dein
```vim
[[plugins]]
repo = 'demonlord1997/pycomment'
on_ft = 'python'
```
### setting
```vim
let g:pycomment_mark_mapping = 0
nmap <C-c> <nop>
nmap <silent> <C-c> <Plug>(pycomment)
nmap <leader><leader> <ESC>/<++><CR>:nohlsearch<CR>c4l
```
Press `ctrl+c` will expand docstring.

Press `<leader> + <leader>` will replace `<++>` and enter insert mode.
