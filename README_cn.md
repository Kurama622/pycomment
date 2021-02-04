# pycomment

![vim](https://img.shields.io/badge/vim-neovim-red) ![gvim](https://img.shields.io/badge/gvim-blue)

[ENGLISH](./README.md)  |  中文版

## 展示
![pycomment](./screenshut/pycomment1.gif)

![pycomment2](./screenshut/pycomment2.gif)

## 介绍
根据函数的输入参数、返回变量和它们的类型，自动生成注释文档（格式同`numpy`）

## 安装

如果你用`vim-plug`，你可以通过下面命令安装
```vim
Plug 'demonlord1997/pycomment', {'for':'python'}
```
如果你用`dein`，你可以通过下面命令安装
```vim
[[plugins]]
repo = 'demonlord1997/pycomment'
on_ft = 'python'
```
## 配置
在你的配置文件（`.vimrc`/`init.vim`）中，写入
```vim
let g:pycomment_mark_mapping = 1
```
则会启用默认触发按键，即按下`Alt+c`，将会展开注释文档，按两次`<leader>`键，将会定位到标识符`<++>`处，但并不进入插入模式。如果你想要修改快捷键，我推荐你采用下面的配置方式

```vim
let g:pycomment_mark_mapping = 0
nmap <C-c> <nop>
nmap <silent> <C-c> <Plug>(pycomment)
nmap <leader><leader> <ESC>/<++><CR>:nohlsearch<CR>c4l
```
在函数定义处或者函数体内按下 `ctrl+c` 将会展开注释文档。

按两次`<leader>`键，将会定位到标识符`<++>`处，并进入到vim的插入模式。

你可以通过`nmap <silent> <你的快捷键> <Plug>(pycomment)`来修改注释文档展开的快捷键。

你可以通过`nmap <你的快捷键> <ESC>/<++><CR>:nohlsearch<CR>c4l`或者`nmap <silent> <你的快捷键> <Plug>(pycomment_mark)`来修改定位的快捷键。

