"
" NOTE
" - vimrc: https://raw.githubusercontent.com/anishathalye/dotfiles/master/vimrc
"

set nocompatible " not vi compatible

"------------------
" Install vim-plug
"------------------
function AutoInstallVimPlug()
    " TODO: need refactoring
    if has('nvim')
        if empty(glob('~/.config/nvim/autoload/plug.vim'))
            silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
    else
        if empty(glob('~/.vim/autoload/plug.vim'))
            silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
            autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
        endif
    endif
endfunction

call AutoInstallVimPlug()

"------------------
" Load plugins
"------------------

call plug#begin()
    " colorschemes
    Plug 'morhetz/gruvbox'
    Plug 'junegunn/seoul256.vim'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    " movement, lookup, etc
    Plug 'scrooloose/nerdtree'
    Plug 'easymotion/vim-easymotion'
    Plug 'haya14busa/incsearch.vim'
    Plug 'mbbill/undotree'
    Plug 'junegunn/fzf',
        \ { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    " text editing
    Plug 'reedes/vim-pencil'
    Plug 'reedes/vim-lexical'
    Plug 'plasticboy/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim',
        \ { 'do': { -> mkdp#util#install() },
        \   'for': ['markdown', 'vim-plug'] }

    " coding
    Plug 'vim-utils/vim-man'
    Plug 'tpope/vim-fugitive'

    " coding c++
    Plug 'neoclide/coc.nvim',
        \ { 'for': ['zig',  'cmake',      'rust',
        \           'java', 'json',       'haskell',
        \	        'ts',   'sh',         'cs',
        \	        'yaml', 'c',          'cpp',
    	\	        'd',    'go',         'python',
        \           'dart', 'javascript', 'vim'],
        \	'branch': 'release'},
    Plug 'rhysd/vim-clang-format',
        \  {'for' : ['c', 'cpp']},
    Plug 'jackguo380/vim-lsp-cxx-highlight',
        \  {'for' : ['c', 'cpp']},

    " misc neovim plugins
    if has('nvim')
        Plug 'glacambre/firenvim',
            \ { 'do': { _ -> firenvim#install(0) }}
        Plug 'ThePrimeagen/vim-be-good'
    endif
call plug#end()

" Automatically install missing plugins on startup
function AutoInstallPlugIns()
    autocmd VimEnter *
        \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \|   PlugInstall --sync | PlugUpdate --sync
        \| endif
endfunction

call AutoInstallPlugIns()


function IsPluginInstalled(pname)
    if get(g:plugs, a:pname , {}) == {}
        return 0
    endif
    return 1
endfunction


"------------------
" Syntax and indent
"------------------
syntax on " turn on syntax highlighting
set showmatch " show matching braces when text indicator is over them

" highlight current line, but only in active window
augroup CursorLineOnlyInActiveWindow
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

filetype plugin indent on " enable file type detection
set autoindent

"---------------------
" Basic editing config
"---------------------
set clipboard=unnamedplus " use system clipboard by default (vimx, gvim -v, mvim -v)
set shortmess+=I " disable startup message
set nu " number lines
set rnu " relative line numbering
set incsearch " incremental search (as string is being typed)
set hls " highlight search
set listchars=tab:>>,nbsp:~ " set list to see tabs and non-breakable spaces
set lbr " line break
set scrolloff=5 " show lines above and below cursor (when possible)
set noshowmode " hide mode
set laststatus=2
set backspace=indent,eol,start " allow backspacing over everything
set timeout timeoutlen=1000 ttimeoutlen=100 " fix slow O inserts
set lazyredraw " skip redrawing screen in some cases
set autochdir " automatically set current directory to directory of last opened file
set hidden " allow auto-hiding of edited buffers
set history=8192 " more history
set nojoinspaces " suppress inserting two spaces between sentences
" use 4 spaces instead of tabs during formatting
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
" smart case-sensitive search
set ignorecase
set smartcase
" tab completion for files/buffers
set wildmode=longest,list
set wildmenu
" set mouse+=a " enable mouse mode (scrolling, selection, etc)
" if &term =~ '^screen'
"    " tmux knows the extended mouse mode
"    set ttymouse=xterm2
" endif
set nofoldenable " disable folding by default

" use undo instead of backup or swap file
" set noswapfile
" set nobackup
" set nowritebackup

" use undo
set undodir=~/.vim/undodir
set undofile
" color lolumn
set colorcolumn=80
" highlight ColorColumn ctermbg=0 guibg=lightgrey

"--------------------
" Misc configurations
"--------------------

let ru_newbie=1
if ru_newbie
    " Try to prevent bad habits like using the arrow keys for movement. This is
    " not the only possible bad habit. For example, holding down the h/j/k/l keys
    " for movement, rather than using more efficient movement commands, is also a
    " bad habit. The former is enforceable through a .vimrc, while we don't know
    " how to prevent the latter.
    " Do this in normal mode...
    nnoremap <Left>  :echoe "Use h"<CR>
    nnoremap <Right> :echoe "Use l"<CR>
    nnoremap <Up>    :echoe "Use k"<CR>
    nnoremap <Down>  :echoe "Use j"<CR>
    " ...and in insert mode
    inoremap <Left>  <ESC>:echoe "Use h"<CR>
    inoremap <Right> <ESC>:echoe "Use l"<CR>
    inoremap <Up>    <ESC>:echoe "Use k"<CR>
    inoremap <Down>  <ESC>:echoe "Use j"<CR>
endif

" unbind keys
map <C-a> <Nop>
map <C-x> <Nop>
nmap Q <Nop>

" disable audible bell
set noerrorbells visualbell t_vb=

" open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

"
" remap <Leader> to <space>
let mapleader = " "

" window movement
" <space>j,k,h,l
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l

" quicker buffer circulation
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>

" ~ : change the case of the current character
" <Esc>, <C-c>, <C-[>: leave insert mode
" v     : visual mode
" <S-v> : virual line mode
" <C-v> : vertial visual mode

" I     : insert at the beginning of a line
" A     : append to the end of a line
" / n N : search next and previous
" * #   : search text on a cursor forward and backward

" f<c>, t<c>: jump to charactor <c> (on or before)
" F<c>, T<c>: jump to charactor <c> backward
" ; ,       : continue jumping to the charactor forward or backward
" x         : delete a char
" s         : delete a char and switch to an insert mode

" [[, ]]   : jumping functions
" 12j      : jump down 12 lines
" {, }     : hop back and forth between empty lines
" %        : jump back and forth between matching {([
" di{, ci{ : delete/change inside/around {}
" da{, ca{
" dip, cip, vip: delete/change/visual-select inside a paragraph
" diw      : delete a word if you are in the middle of word

" <C-o>, <C-i> : jump back and forth between old and new cursor position
" <C-^>        : switch between two files
" m{hjkl} - '{hjkl} : local mark
" m{HJKL} - '{HJKL} : global mark

" <C-wv>, <C-ws> : vertical/horizontal split
" <C-wo> : close all splits
" <C-w=> : equalize all 
" <C-wr> : rotate buffers


"---------------------
" Plugin configuration
"---------------------

"---------------------
" color scheme
"--------------------- 
set termguicolors
if has('nvim')
    if IsPluginInstalled('seoul256.vim')
        colo seoul256-light
    endif
    set background=light
else
    if IsPluginInstalled('gruvbox')
        let g:gruvbox_contrast_dark = "hard"
        if !has('gui_running')
            let g:gruvbox_guisp_fallback = "bg"
        endif
        let g:gruvbox_invert_selection='0'
        colorscheme gruvbox
    endif
    set background=dark
endif

"
" airline
" disable the default status line
if IsPluginInstalled('vim-airline')
    set noshowmode
    set noruler
    set laststatus=0
    set noshowcmd
    set shortmess=F
    " do not use powerline font and tabline
    " since I use nvim only for browser plugin
    if !has('nvim')
        let g:airline_powerline_fonts = 1
        let g:airline#extensions#tabline#enabled = 1
        let g:airline#extensions#tabline#buffer_nr_show = 1
    endif
endif

"---------------------
" navigation
"--------------------- 

"
" nerdtree
if IsPluginInstalled('nerdtree')
    nnoremap <Leader>n :NERDTreeToggle<CR>
    nnoremap <Leader>f :NERDTreeFind<CR>
endif

"
" easymotion
" <Space><Space> {w,b,f}
if IsPluginInstalled('vim-easymotion')
    map <Space> <Plug>(easymotion-prefix)
endif

"
" incsearch
" <Ctrl>-j, <Ctrl>-k
if IsPluginInstalled('incsearch.vim')
    map / <Plug>(incsearch-forward)
    map ? <Plug>(incsearch-backward)
    map g/ <Plug>(incsearch-stay)
    "
    " incsearch-easymotion
    " map z/ <Plug>(incsearch-easymotion-/)
    " map z? <Plug>(incsearch-easymotion-?)
    " map zg/ <Plug>(incsearch-easymotion-stay)
endif


"
" undotree
if IsPluginInstalled('undotree')
    nnoremap <leader>u :UndotreeShow<CR>
endif

" fzf
" command line: <Ctrl-t>, <Ctrl-r>, <Alt-c>
" vim command
"   GFiles, Files, Buffers, Rg
"   <leader>ps : project search
"   <C-p>      : git file open
if IsPluginInstalled('fzf')
    if executable('rg')
        let g:rg_derive_root='true'
    endif
    nnoremap <leader>ps :Rg<Space>
    nnoremap <C-p> :GFiles<CR>
endif


" pencil
if IsPluginInstalled('vim-pencil')
    let g:airline_section_x = '%{PencilMode()}'
    let g:pencil#wrapModeDefault = 'hard'
    let g:pencil#textwidth = 79
    let g:pencil#mode_indicators = {'hard': 'H', 'auto': 'A', 'soft': 'S', 'off': '',}
    let g:pencil#autoformat = 0
    let g:pencil#cursorwrap = 0

    nnoremap <silent> Q gqap " format current paragraph 
    xnoremap <silent> Q gq   " format current buffer selected
endif


"---------------------
" Text editing
"--------------------- 

"
" lexical
"
" ]s [s : move the cursor to next/previous misspelled word
" z= or <C-x><C-s> : suggest alternatives
" zg : mark it correct
" zw : mark it incorrect
" zug : unmark it correct
" zuw : unmark it incorrect
" set nospell : turn off auto spell checker
" set spell: turn on auto spell chcker
"
" <leader>t or <C-x><C-t>: thesaurus lookup
" <leader>k or <C-x><C-k>: dictionary completion
"
" note: <C-S> <C-Q>: terminal freeze / unfreeze
if IsPluginInstalled('vim-lexical')
    let g:lexical#spell = 1
    let g:lexical#spelllang = ['en_us']
    let g:lexical#thesaurus = ['~/.vim/thesaurus/mthesaur.txt',]
    let g:lexical#spellfile = ['~/.vim/spell/en.utf-8.add',]
    let g:lexical#spell_key = '<leader>s'
    let g:lexical#thesaurus_key = '<leader>t'
    let g:lexical#dictionary_key = '<leader>k'
endif

"
" markdown
"
" gx: open the link under the cursor 
" ]]: go to next header.
" [[: go to previous header.
" ][: go to next sibling header if any.
" []: go to previous sibling header if any.
" ]c: go to Current header.
" ]u: go to parent header (Up).
" zr: reduces fold level throughout the buffer
" zR: opens all folds
" zm: increases fold level throughout the buffer
" zM: folds everything all the way
" za: open a fold your cursor is on
" zA: open a fold your cursor is on recursively
" zc: close a fold your cursor is on
" zC: close a fold your cursor is on recursively
if IsPluginInstalled('vim-markdown')
    let g:markdown_fenced_languages = [
        \ 'bash=sh',
        \ 'c',
        \ 'javascript',
        \ 'json',
        \ 'perl',
        \ 'python',
        \ 'yaml',
        \ 'go',
    \]
    let g:markdown_syntax_conceal = 0
    let g:markdown_folding = 1
    let g:vim_markdown_math = 1
    let g:vim_markdown_auto_insert_bullets = 0
    let g:vim_markdown_new_list_item_indent = 0
    
    " markdown-preview
    " https://github.com/iamcco/markdown-preview.nvim
    "
    " :MarkdownPreview        " start the preview
    " :MarkdownPreviewStop    " stop the preview
    let g:mkdp_refresh_slow = 1
    let g:mkdp_markdown_css = $HOME . '.markdown.css'
endif


" latex
" <leaer>m      make!
let g:tex_flavor = "latex"
let g:tex_conceal = ""


"---------------------
" Coding
"--------------------- 

" cscope and ctags for Linux kernel (5.8)
" KBUILD_ABS_SRCTREE=1 make ARCH=x86_64 cscope tags -j2

"
" cscope
" build database: cscope -Rbq
function IsAbsCscopeDB(fname)
    let is_abs = split( system("head " . a:fname . " | grep $'\t@/' | wc -l") )
    if is_abs[0] == "1"
        return 1
    endif
endfunction

function GetCscopeDB()
    " add any database in either current or parent directories
    let db = ""
    if filereadable("cscope.out")
        let db = "cscope.out"
    elseif filereadable("../cscope.out")
        let db = "../cscope.out"
    elseif filereadable("../../cscope.out")
        let db = "../../cscope.out"
    elseif filereadable("../../../cscope.out")
        let db = "../../../cscope.out"
    elseif filereadable("../../../../cscope.out")
        let db = "../../../../cscope.out"
    elseif filereadable("../../../../../cscope.out")
        let db = "../../../../../cscope.out"
    elseif filereadable("../../../../../../cscope.out")
        let db = "../../../../../../cscope.out"
    elseif filereadable("../../../../../../../cscope.out")
        let db = "../../../../../../../cscope.out"
    elseif filereadable("../../../../../../../../cscope.out")
        let db = "../../../../../../../../cscope.out"
    " add database pointed by environment variable
    elseif $CSCOPE_DB != ""
        let db = "$CSCOPE_DB"
    endif
    return db
endfunction

set csto=0   " choose the first option
set cst      " replace ctags
set nocsverb " no verborse

let db = GetCscopeDB() 
if db != ""
    cs add db
    if IsAbsCscopeDB(db)
        set nocsre   " use absolute path
    else
        set csre     " interprete relative path to the location of cscope.out
    endif
endif
 
set csverb

"
" ctags
" build database: ctags -R `pwd`
set tags=./tags,./../tags,./../../tags,./../../../tags,./../../../../tags,./../../../../../tags,./../../../../../../tags,./../../../../../../../tags,./../../../../../../../../tags,tags

"
" vim-man
" vim command: Man <printf>

"
" vim-fugitive
" vim command: Git <commit>

" TODO
" Let's try termdebug, which looks useful for debugging.
" https://www.dannyadam.com/blog/2019/05/debugging-in-vim/


"---------------------
" C++ Coding
"--------------------- 
" - c++: https://chmanie.com/post/2020/07/17/modern-c-development-in-neovim/
" - c++: https://gist.github.com/p1v0t/42a34744b5e4f5980e5f4e1c980ec859
" - kernel workflow: https://cs4118.github.io/dev-guides/kernel-workflow.html
" TODO: - coc: https://www.youtube.com/watch?v=OXEVhnY621M
" TODO: - auto complte: https://www.youtube.com/watch?v=2f8h45YR494

" TODO
" - CoC configuration
" - clang-format: visual select, etc
" - linux kernel coding convention
" - make file type plugin

"
" coc.nvim
if IsPluginInstalled('coc.nvim')
    let g:coc_disable_startup_warning = 1 " for old vim
    
    autocmd BufNew,BufEnter *.c,*.C,*.cpp,*.cxx,*.h,*.hpp,*.tpp,*.S,*.s,*.asm
                            \ execute "silent! CocEnable"
    autocmd BufLeave        *.c,*.C,*.cpp,*.cxx,*.h,*.hpp,*.tpp,*.S,*.s,*.asm
                            \ execute "silent! CocDisable"
    
    source ~/.coc.vim " loading (almost) default coc configuration
endif


"
" vim-clang-format
" let g:clang_format#auto_format=1
if IsPluginInstalled('vim-clang-format')
    nnoremap <Leader>f :<C-u>ClangFormat<CR>
endif

"
" vim-lsp-cxx-highlight
if IsPluginInstalled('vim-lsp-cxx-highlight')
    let g:cpp_class_scope_highlight = 1
    let g:cpp_member_variable_highlight = 1
    let g:cpp_class_decl_highlight = 1
endif


"---------------------
" Per file type
"--------------------- 

augroup filetype
  autocmd!
  autocmd Filetype latex,tex
                            \   call pencil#init({'wrap': 'hard', 'autoformat': 0})
                            \ | call lexical#init()
                            \ | setl spell spl=en_us
                            \ | nnoremap <buffer> <silent> <leader>m :wa <CR> <ESC> :make! <CR>
  autocmd Filetype text
                            \   call pencil#init({'wrap': 'hard', 'autoformat': 0})
                            \ | call lexical#init()
                            \ | execute "silent! CocDisable"
                            \ | setl spell spl=en_us
  autocmd FileType markdown,mkd
                            \   call pencil#init({'wrap': 'hard', 'autoformat': 0})
                            \ | call lexical#init()
                            \ | execute "silent! CocDisable"
                            \ | setl spell spl=en_us
  autocmd FileType rst
                            \   call pencil#init({'wrap': 'hard', 'autoformat': 0})
                            \ | call lexical#init()
                            \ | execute "silent! CocDisable"
                            \ | setl spell spl=en_us
augroup END

