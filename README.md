## pycomment

ENGLISH | [中文版](./README_cn.md)

![pycomment](./screenshut/pycomment.gif)

### install

- [x] vim-plug
```vim
Plug 'demonlord1997/pycomment'
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
