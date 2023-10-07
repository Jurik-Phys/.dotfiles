" Setting up Vundle - the vim plugin bundler {{{
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set nocompatible              " be iMproved, required
    filetype off                  " required
    set rtp+=~/.vim/bundle/vundle/
    call vundle#begin()
    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    "Add your bundles here
    Plugin 'dense-analysis/ale'                         "Asynchronous Lint Engine /Syntax and errors highlighter/
    Plugin 'https://github.com/tpope/vim-fugitive'      "So awesome, it should be illegal
    Plugin 'https://github.com/preservim/nerdtree'      "The NERDTree is a file system explorer for the Vim editor
    Plugin 'https://github.com/Yggdroot/indentLine'     "Displaying thin vertical lines at each indentation level
    Plugin 'https://github.com/sheerun/vim-polyglot'    "A collection of language packs for Vim
    " Plugin 'vim-scripts/wombat256.vim'                "This is a version of Wombat by Lars Nielsen that also works on xterms with 256 colors.

    " All of your Plugins must be added before the following line
    if iCanHazVundle == 0
        echo "Installing Vundles, please ignore key map error messages"
        echo ""
        :PluginInstall
    endif

    call vundle#end()             " required
    filetype plugin indent on     " required
    " To ignore plugin indent changes, instead use:
    "filetype plugin on
    "
    " Brief help
    "   :PluginList       - lists configured plugins
    "   :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    "   :PluginSearch foo - searches for foo; append `!` to refresh local cache
    "   :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
    " see :h vundle for more details or wiki for FAQ
" }}}

" Block of Plugins config {{{
    " Plugin 'dense-analysis/ale'
        " Запуск линтера, только при сохранении
        let g:ale_lint_on_text_changed = 'never'
        let g:ale_lint_on_insert_leave = 0
        " Hardcoded include path for same projects:
            let options   = '-std=gnu++1z '
            let options ..= '-I/usr/include/x86_64-linux-gnu/mpich '
            let options ..= '-I/opt/Qt/6.4.1/gcc_64/include -I/opt/Qt/6.4.1/gcc_64/include/QtWidgets -I/opt/Qt/6.4.1/gcc_64/include/QtGui -I/opt/Qt/6.4.1/gcc_64/include/QtCore '
            let g:ale_cpp_cc_options = options

    " Plugin 'preservim/nerdtree'
    silent! map <F2> :NERDTreeFind<CR>              " Find directory in NERDTree with current file
    silent! map <F3> :NERDTreeToggle<CR>            " Toggle NERDTree panel
    let NERDTreeShowHidden=1
    let NERDTreeIgnore=['^moc_', '\.o$']
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " Plugin 'Yggdroot/indentLine'
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" }}}

if has("gui_running")
    set guioptions+=b
    colorscheme torte " evening " spring " wombat " wombat " Цветовая схема
    set guifont=Terminal\ 10 " fixed " Шрифт
else
    " Перезапсь цветов цветовой схемы
    " ()
    " https://gist.github.com/romainl/379904f91fa40533175dfaec4c833f2f
    augroup MyColors
        autocmd!
        autocmd ColorScheme * hi StatusLine   ctermfg=DarkGray ctermbg=Yellow 
                          \ | hi StatusLineNC ctermfg=DarkGray ctermbg=White  
                          \ | hi VertSplit    ctermfg=DarkGray
                          \ | hi Folded       ctermfg=014      ctermbg=008
                          \ | hi Keyword      ctermfg=003
                          \ | hi Function     ctermfg=011
                          \ | hi String       ctermfg=011
                          \ | hi Normal       ctermfg=002      ctermbg=000
                          \ | hi Keyword      ctermfg=014
                          \ | hi Statement    ctermfg=011
                          \ | hi Constant     ctermfg=005
                          \ | hi Number       ctermfg=005
                          \ | hi PreProc      ctermfg=005
                          \ | hi Identifier   ctermfg=011
                          \ | hi Type         ctermfg=003
                          \ | hi Special      ctermfg=007
                          \ | hi Comment      ctermfg=006
                          \ | hi Todo         ctermfg=005       ctermbg=000
                          \ | hi MatchParen   ctermfg=007       ctermbg=008 
    augroup END
    colorscheme wombat
endif

" Навигация межд окнами через Ctrl + hjkl
" A) нормальный режим
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
" Б) режим терминала
tnoremap <c-j> <c-w>j
tnoremap <c-k> <c-w>k
tnoremap <c-h> <c-w>h
tnoremap <c-l> <c-w>l
tnoremap <c-l> <c-w>l
tnoremap <Esc> <c-w>N

" Отображать новый файл при разделении окна
  " A) ниже текущего или правее текущего
  " Б) правее текущего
set splitbelow splitright

" Изменение размера текущего окна через  Ctrl + Arrows
noremap <silent> <C-Left>  :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up>    :resize +3<CR>
noremap <silent> <C-Down>  :resize -3<CR>

" Изменение вида разбиения окон \ + th{tk}
map <Leader>th <C-w>t<C-w>H
map <Leader>tk <C-w>t<C-w>K

" Увеличить время ожидания команд после
" нажатия на кнопку <Leader> Она же \
set timeoutlen=3000

" Удалить символ | из разделителя окон
"              vert:\<space>
set fillchars+=vert:\ 

" переносить строки
set wrap
" set showbreak=\|->\
" Перенос строк по словам, а не по буквам
set linebreak

" визуализировать ошибки
set visualbell

" Поиск по мере набора
set incsearch

" Список кодировок файлов для автоопределения
set fileencodings=utf-8,cp1251,koi8-r,cp866

" показ номера строки
set number

" заменить табулятор на пробелы
set expandtab

" Количество пробелов в табуляции
set tabstop=4 " ширина таба {\t}
set shiftwidth=4
set smarttab
set smartindent " умное фоматирование отступов

" Установка отступов в два пробела для типов файлов
autocmd FileType javascript,javascriptreact,css,scss,jsx set tabstop=2 | set shiftwidth=2 | set expandtab

" Меню для перекодировки текста
" http://www.opennet.ru/base/rus/vim_rus_text.txt.html
" <F8> Change encoding
" <F8> File encoding for open
" ucs-2le - MS Windows unicode encoding
set  wildmenu
set  wcm=<Tab>
menu Encoding.CP1251     :FencManualEncoding cp1251<CR>
menu Encoding.KOI8-R     :FencManualEncoding koi8-r<CR>
menu Encoding.CP866      :FencManualEncoding cp866<CR>
menu Encoding.UTF-8      :FencManualEncoding utf-8<CR>
menu Encoding.UCS-2LE    :FencManualEncoding ucs-2le<CR>
map  <F8> :emenu Encoding.<Tab>

set statusline=%<[wID\ %{winnr()}]\ %t%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %l,%c%V\ %P
" Отображать статусную строку для каждого окна
set laststatus=2

" Переключение между буферами без сохранения файлов
set hidden

" командная строка в две строки
set ch=3

" для latexsuite
filetype plugin on
set grepprg=grep\ -nH\ $*
filetype indent on
let g:tex_flavor='latex'
let g:Tex_DefaultTargetFormat='pdf'
" полный вывод ошибок и предупреждений в vim-latex
let g:Tex_IgnoreLevel = 0

" Включить подсветку синтаксиса в *.cls файлах (LaTeX)
augroup cls_syntax_on
  " Remove all vimrc autocommands within scope
  autocmd!
  autocmd BufNewFile,BufRead *.cls   set syntax=tex
augroup END

" Включить подсветку синтаксиса в *.tex файлах
autocmd BufNewFile,BufRead *.tex syntax on

" Set switches spelling
" http://welinux.ru/post/426/
" словари тут: ftp://ftp.vim.org/pub/vim/runtime/spell/
set spell spelllang=ru,en
set wildmenu
set wcm=<Tab>
menu Spell.words z=
menu Spell.next ]s
menu Spell.prev [s
menu Spell.word_good zg
menu Spell.word_wrong zw
menu Spell.word_ignore zG


nmap <F4> z=<CR>
imap <F4> <Esc>z=<CR>

imap <F7> <Esc>:set spell!<CR>
nmap <F7> :set spell!<CR>

imap <C-F7> <Esc>:emenu Spell.<TAB>
nmap <C-F7> :emenu Spell.<TAB>
set nospell

highlight clear SpellBad
highlight SpellBad  ctermfg=yellow
highlight clear SpellCap
highlight SpellCap ctermfg=Blue

highlight clear SpellLocal
highlight SpellLocal ctermfg=Green

syntax on
set syntax=automatic " Автоматическое определение подсветки
autocmd Syntax * syn match Statement "[\[\](){}]" containedin=ALL " Подсветка всех скобок в коде

" Все swap файлы будут помещаться в эту папку
" set dir=~/.vim/swp
" Отключить создание swap-файла
set noswapfile


" Обычное перемещение (внутри предложения на нес)
" при включенном переносе;(с помощью стрелок)
nmap <Up> gk
nmap <Down> gj
" imap <Up> <C-o>gk
" imap <Down> <C-o>gj
:set virtualedit=all

" http://www.vim.org/scripts/script.php?script_id=4503
"
" XkbSwitch requires OS dependent keyboard layout switcher. Currently it
" depends on xkb-switch (http://github.com/ierton/xkb-switch) for UNIX / X Server
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']

" http://welinux.ru/post/3478/
function! BindF5_C()
    "http://habrahabr.ru/blogs/vim/40369/
    if filereadable("Makefile")
        set makeprg=make
         map <f5>      :w<cr>:make!<cr>:cw<cr>
        imap <f5> <esc>:w<cr>:make!<cr>:cw<cr>
    else
         map <f5>      :w<cr>:make! %:r<cr>:cw<cr>
        imap <f5> <esc>:w<cr>:make! %:r<cr>:cw<cr>
    endif
endfunction
autocmd FileType c,cc,cpp,h,hpp,s call BindF5_C()

function! BindF9_C()
    "http://habrahabr.ru/blogs/vim/40369/
    if filereadable("Makefile")
        set makeprg=make
         map <f9>      :w<cr>:make<cr>:cw<cr>:!./%<<cr>
        imap <f9> <esc>:w<cr>:make<cr>:cw<cr>:!./%<<cr>
    else
         map <f9>      :w<cr>:make %:r<cr>:cw<cr>:!./%<<cr>
        imap <f9> <esc>:w<cr>:make %:r<cr>:cw<cr>:!./%<<cr>
    endif
endfunction
autocmd FileType c,cc,cpp,h,hpp,s call BindF9_C()

" F5 - собрать LaTeX проект
" F9 - просмотр/при необходимости сборка
function! BindF5_LaTeX()
     " map  <F5>      :w<cr>:make!<cr>:cclose<cr>
     " imap <F5> <esc>:w<cr>:make!<cr>:cclose<cr>
     map  <F5>      :w<cr>:make!<cr>
     imap <F5> <esc>:w<cr>:make!<cr>
endfunction
autocmd FileType tex call BindF5_LaTeX()

function! BindF9_LaTeX()
    map  <F9>      :w<cr>:!make! view<cr>
    imap <F9> <esc>:w<cr>:!make! view<cr>
endfunction
autocmd FileType tex call BindF9_LaTeX()

" breakindent.patch
set bri

set showtabline=2
highlight TabLineSel ctermfg=Yellow ctermbg=DarkGray
highlight TabLineFill ctermfg=DarkGray
highlight TabLine cterm=none

" Задаем собственные функции для назначения имен заголовкам табов -->
" Источник: https://habr.com/ru/post/29373/
    function MyTabLine()
        let tabline = ''

        " Формируем tabline для каждой вкладки -->
            for i in range(tabpagenr('$'))
                " Подсвечиваем заголовок выбранной в данный момент вкладки.
                if i + 1 == tabpagenr()
                    let tabline .= '%#TabLineSel#'
                else
                    let tabline .= '%#TabLine#'
                endif

                " Устанавливаем номер вкладки
                let tabline .= '%' . (i + 1) . 'T'

                " Получаем имя вкладки
                let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} |'
            endfor
        " Формируем tabline для каждой вкладки <--

        " Заполняем лишнее пространство
        let tabline .= '%#TabLineFill#%T'

        " Выровненная по правому краю кнопка закрытия вкладки
        if tabpagenr('$') > 1
            let tabline .= '%=%#TabLine#%999XX'
        endif

        return tabline
    endfunction

    function MyTabLabel(n)
        let label = ''
        let buflist = tabpagebuflist(a:n)

        " Имя файла и номер вкладки -->
            let label = substitute(bufname(buflist[tabpagewinnr(a:n) - 1]), '.*/', '', '')

            if label == ''
                let label = '[No Name]'
            endif

            let label .= ' (' . a:n . ')'
        " Имя файла и номер вкладки <--

        " Определяем, есть ли во вкладке хотя бы один
        " модифицированный буфер.
        " -->
            for i in range(len(buflist))
                if getbufvar(buflist[i], "&modified")
                    let label = '[+] ' . label
                    break
                endif
            endfor
        " <--

        return label
    endfunction

    function MyGuiTabLabel()
        return '%{MyTabLabel(' . tabpagenr() . ')}'
    endfunction

    set tabline=%!MyTabLine()
    set guitablabel=%!MyGuiTabLabel()
" Задаем собственные функции для назначения имен заголовкам табов <--


" Настройка отладчика (загрузка плагина, расположение окон) -->
autocmd FileType c,cc,cpp,h,hpp,s packadd termdebug
autocmd FileType c,cc,cpp,h,hpp,s cabbrev gdb Termdebug
let g:termdebug_popup = 0
let g:termdebug_wide = 1
" Настройка отладчика (загрузка плагина, расположение окон) <--

"""""""""""""""""""""
" GnuPG Extensions "
"                  "
""""""""""""""""""""

" Tell the GnuPG plugin to armor new files.
let g:GPGPreferArmor=1

" Tell the GnuPG plugin to sign new files.
let g:GPGPreferSign=1

augroup GnuPGExtra
  " Set extra file options.
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) call SetGPGOptions()
  " Automatically close unmodified files after inactivity.
    autocmd CursorHold *.\(gpg\|asc\|pgp\) quit
augroup END

function SetGPGOptions()
    " Set updatetime to 2 minute.
    set updatetime=300000
    " Fold at markers.
    set foldmethod=marker
    " Remove comment symbols.
    set commentstring=%s
    " Automatically close all folds.
    set foldclose=all
    " Only open folds with insert commands.
    set foldopen=insert
    " Hide tabline
    set showtabline=0
endfunction

" Change the text in folds
" https://stackoverflow.com/a/5984138
" function! MyFoldText()
"    let nl = v:foldend - v:foldstart + 1
"    let comment = substitute(getline(v:foldstart),"^ *","",1)
"    let linetext = substitute(getline(v:foldstart+1),"^ *","",1)
"    let txt = '+ ' . linetext . ' : "' . comment . '" : length ' . nl
"    return txt
" endfunction
" set foldtext=MyFoldText()

" https://vi.stackexchange.com/a/4650
set foldtext=MyFoldText()
function MyFoldText()
  let line = getline(v:foldstart)
  let sub =  substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return v:folddashes . '> ' . sub
endfunction

" Delete last spaces on all lines
" Bind to F12
function DeleteLineEndSpaces()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

nnoremap <F12> :call DeleteLineEndSpaces()<CR>
