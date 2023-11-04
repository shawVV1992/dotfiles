-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- utf8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"

-- jkhl 移动时光标周围保留8行
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8

-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = false

-- 高亮所在行
vim.wo.cursorline = true

-- 显示左侧图标指示列
vim.wo.signcolumn = "yes"

-- 右侧参考线，超过表示代码太长，考虑换行
vim.wo.colorcolumn = "150"

-- 缩进4个空格等于1个Tab
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true

-- >> <<时移动长度
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4

-- 空格时代替tab
vim.o.expandtab = true
vim.o.expandtab = true

-- 新行对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartcase = true

-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true

-- 搜索不要高亮
vim.o.hlsearch = true

-- 边输入边搜索
vim.o.incsearch = true

-- 命令行高为2，提供足够的显示空间
vim.o.cmdheight = 2

-- 当文件被外部文件加载时，自动加载
vim.o.autoread = true
vim.bo.autoread = true

-- 禁止折行
vim.wo.wrap = false

-- 光标在行首时，<left><right>可以跳到下一行
vim.o.whichwrap = "<,>,[,]"

-- 允许隐藏被修改过的buffer
vim.o.hidden = true

-- 鼠标支持
vim.o.mouse = "a"

-- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false

-- 缩短自动更新时间
vim.o.updatetime = 300

-- 设置等待键盘连击时间为500ms
vim.o.timeoutlen = 500

-- 分屏从下方和右方出现
vim.o.splitbelow = true
vim.o.splitright = true

-- 自动补全，不自动选中
vim.o.completeopt = "menu,menuone,noselect,noinsert"

-- 样式
vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true

-- 不可见字符的显示，这里把空格显示为一个点
vim.o.list = true
--vim.o.listchars="space:."

-- 补全增强
vim.o.wildmenu = true

-- 不传递消息给/ins-completin menu/
vim.o.shortmess = vim.o.shortmess .. "c"

-- 补全做多显示十行
vim.o.pumheight = 10

-- 永远显示tabline
vim.o.showtabline = 2

-- 使用增强状态栏插件后不需要vim的模式提醒
vim.o.showmode = false

--共享剪贴板(获取ubuntu剪贴板)
vim.o.clipboard = "unnamed"
vim.o.clipboard = "unnamedplus"
