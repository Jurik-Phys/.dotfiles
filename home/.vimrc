" Setting up Vundle - the vim plugin bundler {{{
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
        let iCanHazVundle=0
    endif
    set nocompatible              " be iMproved, required
    filetype off                  " required
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()
    " Let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " Add your bundles here
    Plugin 'dense-analysis/ale'                         " Asynchronous Lint Engine /Syntax and errors highlighter/
    Plugin 'https://github.com/tpope/vim-fugitive'      " So awesome, it should be illegal
    Plugin 'https://github.com/preservim/nerdtree'      " The NERDTree is a file system explorer for the Vim editor
    Plugin 'https://github.com/Yggdroot/indentLine'     " Displaying thin vertical lines at each indentation level
    Plugin 'https://github.com/sheerun/vim-polyglot'    " A collection of language packs for Vim
    Plugin 'ludovicchabant/vim-gutentags'               " It will re-generate tag files as you work while staying completely out of your way.
    Plugin 'Shougo/ddc.vim'                             " Dark deno-powered completion /ddc.vim/ framework for neovim/Vim
    Plugin 'vim-denops/denops.vim'                      " Denops is ecosystem of Vim/Neovim which allows developers to write plugins in Deno
    Plugin 'Shougo/ddc-ui-native'                       " /UI/ Native popup menu UI for ddc.vim
    Plugin 'Shougo/ddc-source-around'                   " /Source/ Around completion for ddc.vim
    Plugin 'matsui54/ddc-buffer'                        " /Source/ Collects keywords from current buffer, buffers whose window is in the same tabpage and other
    Plugin 'delphinus/ddc-ctags'                        " /Source/ Universal Ctags completion for ddc.vim
    Plugin 'Shougo/ddc-filter-converter_remove_overlap' " /Filter/ The filter removes overlapped text in a candidate's word.
    Plugin 'tani/ddc-fuzzy'                             " /Filter/ Fuzzy matching filters for ddc.vim.
    Plugin 'ervandew/supertab'                          " Supertab is a plugin which allows you to perform all your insert completion
    Plugin 'jamessan/vim-gnupg'                         " This script implements transparent editing of gpg encrypted files
    Plugin 'lyokha/vim-xkbswitch'                       " This plugin used to switch keyboard layout back and forth when entering and leaving Insert mode.
    Plugin 'Asheq/close-buffers.vim'                    " This plug-in allows you to quickly bdelete several buffers at once.
    Plugin 'jiangmiao/auto-pairs'                       " Insert or delete brackets, parens, quotes in pair.

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
    " Plugin 'vim-denops/denops.vim'
        " [Temporarly workaround for old vim
        " Disable warning "Denops requires Vim 9.1.0448 or Neovim 0.10.0"
        let g:denops_disable_version_check = 1
    " Plugin 'dense-analysis/ale'
        " Setup react linter to 'eslint'
        let g:ale_linters = { 'javascriptreact' : ['eslint']}
        " Символ ошибки на полях
        let g:ale_sign_error = '>>'
        " Шиирокий вертикальный разделитель для уведомлений
        let g:ale_sign_column_always = 1
        " Запуск линтера, только при сохранении
        let g:ale_lint_on_text_changed = 'never'
        let g:ale_lint_on_insert_leave = 0
        let g:ale_c_cc_options = '-std=c11 -Wall'
        let g:ale_cpp_cc_options = '-std=gnu++1z -Wall'
        let g:ale_cpp_parse_headers = 0
        " Hardcoded include path for same projects:
            let options   = ''
            " Find header files in "./src" project directory
            let options ..= '-I./src '
            " MicroTeX library include
            let options ..= '-I./ext/MicroTeX '
            " MPICH Project
            let options ..= '-I/usr/include/x86_64-linux-gnu/mpich '
            " Local Qt6
            let options ..= '-I/opt/Qt/6.4.1/gcc_64/include -I/opt/Qt/6.4.1/gcc_64/include/QtWidgets -I/opt/Qt/6.4.1/gcc_64/include/QtGui -I/opt/Qt/6.4.1/gcc_64/include/QtCore '
            " System wide Qt5
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtConcurrent '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtCore '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtDBus '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtGui '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtNetwork '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtOpenGL '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtOpenGLExtensions '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtPlatformHeaders '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtPrintSupport '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtQuickControls2 '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtQuickTemplates2 '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtSql '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtTest '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtWidgets '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtX11Extras '
            let options ..= '-I/usr/include/x86_64-linux-gnu/qt5/QtXml '
            let g:ale_cpp_cc_options = options

    " Plugin 'preservim/nerdtree'
    silent! map <F2> :NERDTreeFind<CR>              " Find directory in NERDTree with current file
    silent! map <F3> :NERDTreeToggle<CR>            " Toggle NERDTree panel
    let NERDTreeShowHidden=1
    let NERDTreeIgnore=['^moc_', '\.o$']
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    " Plugin 'Yggdroot/indentLine'
    let g:indentLine_char_list = ['|', '¦', '┆', '┊']

    "Plugin ervandew/supertab
    let g:SuperTabDefaultCompletionType = "<c-x><c-]>"

    " Plugin 'ludovicchabant/vim-gutentags'
    let g:gutentags_add_default_project_roots = 0 " Disable default root markers
    let g:gutentags_project_root = ['.gutentags','.vimGutenTags']
    let g:gutentags_ctags_exclude = [ '.git', 'build', 'depends', 'docs', '.md', '.cache', 'tags', '.css', '.vim' ]
    set tag=./tags,tags;$HOME " Find file with name 'tags' in current dir and upper up-to $HOME

    " Plugin ddc.vim
    call ddc#custom#patch_global('ui', 'native')
    call ddc#custom#patch_global('sources', [ 'ctags', 'around', 'buffer'])
    call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_fuzzy'],
      \   'sorters': ['sorter_fuzzy'],
      \   'converters': ['converter_fuzzy', 'converter_remove_overlap' ],
      \ },
      \ 'around': {
        \ 'mark' : '[A]',
      \ },
      \ 'buffer': {
        \ 'mark' : '[B]',
      \ },
      \   'ctags' : {
      \ 'mark' : '[C]',
      \ },
      \ })
    call ddc#enable()

    " Plugin vim-xkbswitch
    " It requires OS dependent keyboard layout switcher
    let g:XkbSwitchEnabled = 1

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
        autocmd ColorScheme * hi StatusLine   ctermfg=DarkGray     ctermbg=Yellow
                          \ | hi StatusLineNC ctermfg=DarkGray     ctermbg=White
                          \ | hi VertSplit    ctermfg=DarkGray
                          \ | hi Folded       ctermfg=LightCyan    ctermbg=DarkGray
                          \ | hi Keyword      ctermfg=Brown
                          \ | hi Function     ctermfg=Yellow
                          \ | hi String       ctermfg=Yellow
                          \ | hi Normal       ctermfg=DarkGreen    ctermbg=Black
                          \ | hi Keyword      ctermfg=LightCyan
                          \ | hi Statement    ctermfg=Yellow
                          \ | hi Constant     ctermfg=DarkMagenta
                          \ | hi Number       ctermfg=DarkMagenta
                          \ | hi PreProc      ctermfg=DarkMagenta
                          \ | hi Identifier   ctermfg=Yellow
                          \ | hi Type         ctermfg=Brown
                          \ | hi Special      ctermfg=LightGray
                          \ | hi Comment      ctermfg=DarkCyan
                          \ | hi Todo         ctermfg=DarkMagenta  ctermbg=Black
                          \ | hi MatchParen   ctermfg=LightGray    ctermbg=DarkGray
                          \ | hi Pmenu        ctermfg=White        ctermbg=DarkGray
                          \ | hi PmenuSel     ctermfg=Black        ctermbg=LightGray
                          \ | hi PmenuSbar                         ctermbg=DarkGray
                          \ | hi PmenuThumb                        ctermbg=LightGray
                          \ | hi TabLineSel   ctermfg=White        ctermbg=237
                          \ | hi TabLineFill  ctermfg=DarkGray
                          \ | hi TabLine      ctermfg=Yellow                         cterm=none
                          \ | hi Visual                            ctermbg=DarkGray
                          \ | hi CursorLine                        ctermbg=DarkGray  cterm=none
                          \ | hi ColorColumn                       ctermbg=017
                          \ | hi Directory    ctermfg=DarkCyan
                          \ | hi NERDTreeDirSlash  ctermfg=DarkCyan
                          \ | hi NERDTreeCWD ctermfg=LightGray
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

" Выйти из пустых скобок в режиме вставки
" по нажатию <Esc>
function! JumpFromBrackets()
  let line = getline('.')
  if (line[col('.') - 2] == '{' && line[col('.') - 1] == '}') ||
    \(line[col('.') - 2] == '[' && line[col('.') - 1] == ']') ||
    \(line[col('.') - 2] == '(' && line[col('.') - 1] == ')') ||
    \(line[col('.') - 2] == "'" && line[col('.') - 1] == "'") ||
    \(line[col('.') - 2] == '"' && line[col('.') - 1] == '"') ||
    \(line[col('.') - 2] == '<' && line[col('.') - 1] == '>')
    return "\<Esc>la"
  endif
  return "\<Esc>"
endfunction

inoremap <expr> <Esc> JumpFromBrackets()

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

function! EnFilePosition()
    let total_lines = line('$')
    let current_line = line('.')
    if total_lines == 1
        return 'ALL'
    elseif current_line == 1
        return 'TOP'
    elseif current_line == total_lines
        return 'END'
    else
        return printf('%02d%%', (current_line * 100 / total_lines))
    endif
endfunction

set statusline=%<[wID\ %{winnr()}]\ %t%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %l,%{printf('%03d\ [%03d\]',virtcol('.'),strdisplaywidth(getline('.')))}\ %{EnFilePosition()}
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
" Disable latex symbol conversion
let g:tex_conceal = ""

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
                let tabline .= ' %{MyTabLabel(' . (i + 1) . ')} '
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

" Цветовая индикация столбца ограничителя
" Мягкое ограничение ширины строк исходого кода
autocmd BufEnter *.c,*.cpp,*.h,*.hpp setlocal colorcolumn=81
autocmd BufEnter *.tex setlocal colorcolumn=121

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
    " Disable IndentLine plugin
    autocmd BufReadCmd,FileReadCmd *.\(gpg\|asc\|pgp\) let g:indentLine_enabled = 0
    " Reload colorscheme to workaround black & green color
    autocmd User GnuPG colorscheme wombat
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

" Mark last spaces on line
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufWinEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhitespace /\s\+$/
au BufWinLeave * call clearmatches()

" Delete last spaces on all lines
" Bind to F12
function DeleteLineEndSpaces()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc

nnoremap <F12> :call DeleteLineEndSpaces()<CR>

" :AddBeginEnd command to add filename into begin and end of file
command! AddBeginEnd execute 'normal ggO' . '<Esc>v^xi' . '// Begin ' . expand('%:t') . '<Esc>o' . '<Esc>v^xGo' . '<Esc>v^xi// End ' . expand('%:t') . '<Esc>O' . '<Esc>v^x' . '<Esc>ggji'

" :BuffOnly command for delete all hidden buffers
" :BuffOnly! for delete hidden buffers with unsaved changes
command -bang BuffOnly execute ( <bang>0 ? 'Bdelete! hidden' : 'Bdelete hidden' )
