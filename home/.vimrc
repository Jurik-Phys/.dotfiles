" // *** VIM first run *** //
" install font Termins (TTF):
"     root:~# apt install fonts-terminus
" install JavaScript runtime "Deno":
"     root:~# apt install curl
"     user:~$ curl -fsSL https://deno.land/install.sh | sh
"                                  or
"     user:~$ curl -fsSL https://deno.land/install.sh | sh -s -- "v2.5.1"
" install spell dictionary into vim:
"     > ':set spell' or '<F7>'
" build & install xkb-switch:
"     root:~# apt install libxkbfile-dev
"     user:~$ wget -O xkb-switch.zip https://github.com/sergei-mironov/xkb-switch/archive/refs/heads/master.zip
"     user:~$ unzip xkb-switch.zip
"     user:~$ cd xkb-switch-master
"     user:~$ mkdir build && cd build
"     user:~$ cmake ..
"     user:~$ cmake --build . --parallel
"     user:~$ make DESTDIR=$HOME/.vim/xkb-switch/ install
" install ctags:
"     root:~# apt install universal-ctags
" // * * * * * * * * * * * //

" Auto-install the plugin manager "Vim-Plug"
if !filereadable(expand('~/.vim/autoload/plug.vim'))
    silent !mkdir -p ~/.vim/autoload
    silent !wget -q -O ~/.vim/autoload/plug.vim
          \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" List of favorite plugins
call plug#begin('~/.vim/plugged')
    Plug 'dense-analysis/ale'                               " Asynchronous Lint Engine /Syntax and errors highlighter/
    Plug 'shougo/ddc.vim',             { 'tag' : 'v9.4.0'}  " Dark deno-powered completion /ddc.vim/ framework for neovim/Vim
    Plug 'vim-denops/denops.vim',       {'tag' : 'v7.1.0'}  " Denops is ecosystem of Vim/Neovim which allows developers to write plugins in Deno
    Plug 'shougo/ddc-ui-native',     {'commit' : '4468325'} " /UI/ Native popup menu UI for ddc.vim
    Plug 'shougo/ddc-source-around', {'commit' : 'df270c7'} " /Source/ Around completion for ddc.vim
    Plug 'delphinus/ddc-ctags',      {'commit' : 'f188acf'} " /Source/ Universal Ctags completion for ddc.vim
    Plug 'matsui54/ddc-buffer',      {'commit' : 'f332e16'} " /Source/ Collects keywords from current buffer, buffers whose window is in the same tabpage and other
    Plug 'tani/ddc-fuzzy',           {'commit' : 'd6cc18a'} " /Filter/ Fuzzy matching filters for ddc.vim
    Plug 'shougo/ddc-filter-converter_remove_overlap', {'commit': 'f3b519b'} " /Filter/ The filter removes overlapped text in a candidate's word
    Plug 'ervandew/supertab'                                " Supertab is a plugin which allows you to perform all your insert completion
    Plug 'jamessan/vim-gnupg'                               " This script implements transparent editing of gpg encrypted files
    Plug 'lyokha/vim-xkbswitch'                             " This plugin used to switch keyboard layout back and forth when entering and leaving Insert mode.
    Plug 'Asheq/close-buffers.vim'                          " This plug-in allows you to quickly bdelete several buffers at once.
    Plug 'Raimondi/delimitMate'                             " Insert or delete brackets, parens, quotes in pair.
    Plug 'frazrepo/vim-rainbow'                             " Rainbow of brackets
    Plug 'farmergreg/vim-lastplace'                         " Intelligently reopens files at your last edit position.
    Plug 'preservim/tagbar'                                 " Easy way to browse the tags of the current file and get an overview of its structure
    Plug 'https://github.com/tpope/vim-fugitive'            " The Git plugin for Vim
    Plug 'https://github.com/preservim/nerdtree'            " The NERDTree is a file system explorer for the Vim editor
    Plug 'https://github.com/Yggdroot/indentLine'           " Displaying thin vertical lines at each indentation level
    Plug 'https://github.com/sheerun/vim-polyglot'          " A collection of language packs for Vim
    Plug 'ludovicchabant/vim-gutentags'                     " It will re-generate tag files as you work while staying completely out of your way.
call plug#end()

" Block of Plugins config {{{
    " Check installed ddc.vim plugin before setup
    if filereadable(expand('~/.vim/plugged/ddc.vim/autoload/ddc.vim'))
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
    endif

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
        " compile_commands.json over 'set(CMAKE_EXPORT_COMPILE_COMMANDS ON)'
        " Find 'compile_commands.json' into 'build' directory
        let g:ale_cpp_clangd_options = '--compile-commands-dir=build'
        " Hardcoded include path for same projects:
            let options   = ''
            " Find header files in './src' project directory
            let options ..= '-I./src '
            " MPICH Project
            let options ..= '-I/usr/include/x86_64-linux-gnu/mpich '
            let g:ale_cpp_cc_options = options

    " Plugin 'preservim/nerdtree'
    silent! map <F2> :NERDTreeFind<CR>              " Find directory in NERDTree with current file
    silent! map <F3> :NERDTreeToggle<CR>            " Toggle NERDTree panel
    let NERDTreeShowHidden=1
    "Hide work files:
        " C/C++
         let NERDTreeIgnore=['^moc_', '\.o$', 'tags.lock', 'tags', 'tags.temp']
        " LaTeX
        let NERDTreeIgnore+=['\.aux$', '\.xdv$', '\.toc$', '\.run.xml$','\.out$','\.bbl$', '\.bcf$', '\.blg$', '\.fdb_latexmk$', '\.fls$', 'xelatex.log']
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

    " Fix strange line jump after insert into end of line
    set completeopt=preview

    " Plugin vim-xkbswitch
    " It requires OS dependent keyboard layout switcher
    let g:XkbSwitchEnabled = 1
    let g:XkbSwitchLib="~/.vim/xkb-switch/usr/local/lib/"

    " Plugin 'vim-rainbow'
    " Включение подсветки для правильной работы плагина
    syntax on
    autocmd FileType c,cc,cpp,h,hpp,s,tex call rainbow#load()
    let g:rainbow_ctermfgs = ['Yellow', 'Yellow', 'Brown', 'DarkMagenta']
    let g:rainbow_guifgs = ['Yellow', 'Yellow', '#af5f00', '#b218b2']

    " Plugin 'delimitMate'
    let g:delimitMate_expand_space = 1
    let g:delimitMate_expand_cr = 1
    let g:delimitMate_jump_expansion = 1

    " Plugin 'tagbar'
    let g:tagbar_sort = 0
    nmap <S-F4> :TagbarToggle<CR>
    nmap <F4> :TagbarOpen j<CR>

" GVim fallback font setup
if has("gui_running")
    if !empty(system("fc-list | grep -i 'Terminus (TTF)'"))
        set guifont=Terminus\ \(TTF\)\ 12
    elseif !empty(system("fc-list | grep -i 'Noto Mono'"))
        set guifont=Noto\ Mono\ 12
    else
        set guifont=Monospace\ 12
    endif
endif

" Настройка цветовой схемы (terminal & gui)
augroup MyColors
    autocmd!
    autocmd VimEnter    * hi StatusLine       ctermfg=DarkGray     ctermbg=Yellow
                      \                         guifg=#ffff54        guibg=#6c6c6c     gui=none
                      \ | hi StatusLineNC     ctermfg=DarkGray     ctermbg=White
                      \                         guifg=#6c6c6c        guibg=White
                      \ | hi LineNr           ctermfg=Yellow
                      \                         guifg=#ffff54
                      \ | hi SignColumn       ctermbg=DarkGray
                      \                         guibg=#6c6c6c                           gui=none
                      \ | hi VertSplit        ctermfg=DarkGray
                      \                         guifg=#6c6c6c
                      \ | hi Folded           ctermfg=LightCyan    ctermbg=DarkGray
                      \                         guifg=#54ffff        guibg=#6c6c6c
                      \ | hi Keyword          ctermfg=LightCyan
                      \                         guifg=#54ffff
                      \ | hi Function         ctermfg=Yellow
                      \                         guifg=#ffff54
                      \ | hi String           ctermfg=Yellow
                      \                         guifg=#ffff54
                      \ | hi Normal           ctermfg=DarkGreen    ctermbg=Black
                      \                         guifg=#18b218          guibg=#272727
                      \ | hi Statement        ctermfg=Yellow
                      \                         guifg=#ffff54                           gui=none
                      \ | hi Constant         ctermfg=DarkMagenta
                      \                         guifg=#b218b2
                      \ | hi Number           ctermfg=DarkMagenta
                      \                         guifg=#b218b2
                      \ | hi PreProc          ctermfg=DarkMagenta
                      \                         guifg=#b218b2
                      \ | hi Identifier       ctermfg=Yellow
                      \                         guifg=#ffff54
                      \ | hi Type             ctermfg=Brown
                      \                         guifg=#af5f00                          gui=none
                      \ | hi Special          ctermfg=LightGray
                      \                         guifg=LightGray
                      \ | hi Comment          ctermfg=DarkCyan
                      \                         guifg=#18b2b2
                      \ | hi Todo             ctermfg=DarkMagenta  ctermbg=Black
                      \                         guifg=#b218b2        guibg=#272727
                      \ | hi SpellBad         ctermfg=DarkRed      ctermbg=Black     cterm=none
                      \                         guifg=#ff3622        guibg=#272727     gui=none
                      \ | hi SpellCap         ctermfg=LightGreen   ctermbg=Black
                      \                         guifg=#87ffaf        guibg=#272727     gui=none
                      \ | hi SpellLocal       ctermfg=DarkGreen    ctermbg=Black
                      \                         guifg=#18b218        guibg=#272727
                      \ | hi MatchParen       ctermfg=LightGray    ctermbg=DarkGray
                      \                         guifg=#f6f3e8        guibg=#857b6f
                      \ | hi Pmenu            ctermfg=White        ctermbg=DarkGray
                      \                         guifg=#f6f3e8        guibg=#444444
                      \ | hi PmenuSel         ctermfg=Black        ctermbg=LightGray
                      \                         guifg=#000000        guibg=#f6f3e8
                      \ | hi PmenuSbar                             ctermbg=DarkGray
                      \ | hi PmenuThumb                            ctermbg=LightGray
                      \ | hi TabLineSel       ctermfg=White        ctermbg=237
                      \ | hi TabLineFill      ctermfg=DarkGray
                      \ | hi TabLine          ctermfg=Yellow                         cterm=none
                      \ | hi Visual                                ctermbg=DarkGray
                      \                                              guibg=#6c6c6c
                      \ | hi CursorLine       ctermfg=White        ctermbg=DarkGray  cterm=none
                      \                         guifg=#ffffff        guibg=#6c6c6c
                      \ | hi ColorColumn                           ctermbg=024
                      \                                              guibg=#053d73
                      \ | hi NonText          ctermfg=Gray
                      \                         guifg=#a8a8a8                          gui=none
                      \ | hi Directory        ctermfg=DarkCyan
                      \                         guifg=#18b2b2
                      \ | hi NERDTreeDirSlash ctermfg=DarkCyan
                      \                         guifg=#18b2b2
                      \ | hi NERDTreeCWD      ctermfg=LightGray
                      \                         guifg=#dedede
                      \ | hi TagbarScope       ctermfg=LightCyan   ctermbg=none
                      \                         guifg=#54ffff                          gui=none
                      \ | hi TagbarFoldIcon   ctermfg=LightCyan    ctermbg=none
                      \                         guifg=#54ffff                          gui=none
                      \ | hi TagbarType       ctermfg=Brown
                      \                         guifg=#af5f00                          gui=none
                      \ | hi TagbarNestedKind ctermfg=DarkMagenta  ctermbg=none
                      \                         guifg=#b218b2                          gui=none
                      \ | hi TagbarKind       ctermfg=LightCyan    ctermbg=none
                      \                         guifg=#54ffff                          gui=none
                      \ | hi TagbarHighlight  ctermfg=Yellow       ctermbg=none
                      \                         guifg=#ffff54                          gui=none
                      \ | hi TagbarSignature  ctermfg=Gray         ctermbg=none
                      \                         guifg=#a8a8a8                          gui=none
                      \ | hi TagbarVisibilityPublic    ctermfg=DarkGray
                      \                                  guifg=#6c6c6c                 gui=none
                      \ | hi TagbarVisibilityPrivate   ctermfg=DarkGray
                      \                                  guifg=#6c6c6c                 gui=none
                      \ | hi TagbarVisibilityProtected ctermfg=DarkGray
                      \                                guifg=#6c6c6c                   gui=none
augroup END

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
" <F6> Change encoding
" <F6> File encoding for open
" ucs-2le - MS Windows unicode encoding
set  wildmenu
set  wcm=<Tab>
menu Encoding.CP1251     :FencManualEncoding cp1251<CR>
menu Encoding.KOI8-R     :FencManualEncoding koi8-r<CR>
menu Encoding.CP866      :FencManualEncoding cp866<CR>
menu Encoding.UTF-8      :FencManualEncoding utf-8<CR>
menu Encoding.UCS-2LE    :FencManualEncoding ucs-2le<CR>
map  <F6> :emenu Encoding.<Tab>

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
  autocmd BufNewFile,BufRead *.cls set syntax=tex
augroup END

" LaTeX. Отключение ошибочного выделения символа "_"
" TODO: Установить VimTeX (Vim должен быть 9.1+)
autocmd FileType tex syntax clear texOnlyMath

" При активации проверки орфографии
" через ':set spell' или '<F7>'
" и отсутствии требуемых словарей
" будет предложено их скачать
set spelllang=ru,en
set wildmenu
set wcm=<Tab>
menu Spell.words z=
menu Spell.next ]s
menu Spell.prev [s
menu Spell.word_good zg
menu Spell.word_wrong zw
menu Spell.word_ignore zG

imap <F7> <Esc>:set spell!<CR>
nmap <F7> :set spell!<CR>

nmap <F8> z=
imap <F8> <Esc>z=

imap <C-F7> <Esc>:emenu Spell.<TAB>
nmap <C-F7> :emenu Spell.<TAB>

" Disable swapfile
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
autocmd BufEnter *.tex,*.cls setlocal colorcolumn=121

" >> Настройка отладчика (загрузка плагина, расположение окон)
packadd! termdebug
let g:termdebug_config = {'wide': 1, 'popup': 0}
cabbrev gdb Termdebug
" << Настройка отладчика (загрузка плагина, расположение окон)

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

" https://vi.stackexchange.com/a/4650
set foldtext=MyFoldText()
function MyFoldText()
  let line = getline(v:foldstart)
  let sub =  substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
  return v:folddashes . '> ' . sub
endfunction

" Mark last spaces on line
highlight ExtraWhitespace ctermbg=Red guibg=#ff3622
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
