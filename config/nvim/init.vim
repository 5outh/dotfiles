let mapleader = ' '
let maplocalleader = ','

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'leafgarland/typescript-vim'
" Plug 'neovim/nvim-lspconfig'
Plug 'tomlion/vim-solidity'
Plug 'LnL7/vim-nix'
Plug 'tpope/vim-rhubarb' " Needed for :Gbrowse
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'
Plug 'scrooloose/nerdcommenter'
Plug 'skywind3000/vim-preview'
Plug 'pbrisbin/vim-syntax-shakespeare'
Plug 'pangloss/vim-javascript'
Plug 'neovimhaskell/haskell-vim'
Plug 'mxw/vim-jsx'
Plug 'kana/vim-arpeggio'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'haya14busa/incsearch.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'dense-analysis/ale'
Plug 'ayu-theme/ayu-vim'
Plug 'airblade/vim-gitgutter'
Plug 'SirVer/ultisnips'
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug '5outh/yesod-routes.vim'
call plug#end()

set mouse=a
set encoding=utf-8
set list

let g:fzf_layout = { 'window': '-tabnew' }

" let g:deoplete#enable_at_startup = 1

let g:UltiSnipsSnippetDirectories=["usnippets"]

let g:ale_linters = {}
let g:ale_linters['javascript'] = ['prettier', 'eslint']
let g:ale_linters['jsx'] = ['prettier', 'eslint']
let g:ale_linters['haskell'] = ['hlint']

let g:ale_fixers = {}
let g:ale_fixers['haskell'] = ['ormolu', 'stylish-haskell']
let g:ale_fixers['javascript'] = ['ormolu', 'prettier', 'eslint']
let g:ale_fixers['json'] = ['prettier']

let g:ale_haskell_ormolu_options="-o '-XTypeApplications' -o '-XPatternSynonyms'"
let g:ale_haskell_ormolu_executable="fourmolu"

let g:ale_javascript_prettier_use_local_config = 1
let g:ale_javascript_eslint_use_local_config = 1

let g:ale_fix_on_save = 1

let g:LanguageClient_rootMarkers = ['*.cabal', 'stack.yaml']

" Force spaces before comment delimeters
let g:NERDSpaceDelims = 1
" Align comments to the left
let g:NERDDefaultAlign = 'left'

" Javascript
let g:javascript_plugin_flow = 1
let g:javascript_plugin_jsdoc = 1
let g:jsx_ext_required = 0

" Haskell
" Enable highlighting of 'forall'
let g:haskell_enable_quantification = 1
" Stop annoying autoindent
let g:haskell_indent_disable = 1

"Color Scheme etc

set termguicolors
let ayucolor="mirage"
colorscheme ayu
set t_Co=256

set colorcolumn=80,120

" end colors
syntax on
filetype plugin indent on

" allow pasting from clipboard
set clipboard+=unnamedplus

" Set 80-char line color to dark gray
highlight ColorColumn ctermbg=DarkGray

" SPC - SPC turns off highlight
nnoremap <silent> <leader><leader> :noh<CR><C-l>

" screw arrow keys
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
noremap <PageUp> <nop>
noremap <PageDown> <nop>

" Better search
set incsearch
set hlsearch
set smartcase
set ignorecase

" update faster
set updatetime=100

" Filename even with one window:
set laststatus=2

" Background vim with spc-b
nnoremap <Leader>b <C-z>

" Exit terminal with ESC
tnoremap <ESC> <C-\><C-n>

" Line numbers
set number
set relativenumber
set numberwidth=2
highlight LineNr term=bold cterm=none ctermfg=DarkGrey ctermbg=NONE
highlight CursorLineNr term=bold cterm=none ctermfg=DarkGreen ctermbg=NONE

" Default indentation:
set autoindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Highlight the current line in current window in non-insert mode
set cursorline
set cursorcolumn
au InsertEnter * set nocursorline
au InsertLeave * set cursorline

au TermOpen * setlocal nonumber norelativenumber

set scrolloff=5
set nofoldenable

" UltiSnips
let g:UltiSnipsExpandTrigger='<C-j>'

" markdown languages
let g:markdown_fenced_languages = ['java', 'haskell', 'javascript', 'ruby', 'c', 'cpp', 'php', 'sh', 'sql', 'xml']

" incsearch.vim
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

nnoremap <Leader>v :vsplit<cr>
nnoremap <Leader>s :split<cr>

" Open terminal
nnoremap <Leader>st :split<CR><C-w><C-w>:term<CR>
nnoremap <Leader>vt :vsplit<CR><C-w><C-w>:term<CR>

" Fuzzy file search
nnoremap <Leader>e :FZF<cr>

" File history
nnoremap <Leader>h :History<cr>

" Window cycle
map <Leader>w <C-w><C-w>

" Tag preview
nnoremap <C-j> :PreviewTag<CR>
nnoremap <C-k> :PreviewClose<CR>

set ruler
set noshowcmd " Turn off command display in bottom right

" Map jk to esc (chord)
call arpeggio#map('i', '', 0, 'jk', '<Esc>')

" <leader>? gets full info about lint errors
autocmd FileType haskell nnoremap <buffer> <leader>? :call ale#cursor#ShowCursorDetail()<cr>


" If you use qualified tags, then you have to change iskeyword to include
" a dot.  Unfortunately, that affects a lot of other commands, such as
" w, and \< \> regexes used by * and #.  For me, this is confusing because
" it's inconsistent with vim keys everywhere else.
" This binding temporarily modifies iskeyword just for the ^] command.
nnoremap <silent> <c-]> :setl iskeyword=@,_,.,48-57,39<cr><c-]>
    \:setl iskeyword=@,48-57,_,192-255<cr>

" Open this configuration, useful for looking up commands and adding useful
" things on the fly.
function Config ()
  exec ":edit ~/.config/nvim/init.vim"
endfunction

" Numbered Windows
let i = 1
while i <= 9
    execute 'nnoremap <Leader>' . i . ' :' . i . 'wincmd w<CR>'
    let i = i + 1
endwhile

" Tabs in makefile
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" Git bindings
nmap <Leader>gs :Gstatus<CR>
nmap <Leader>ga :Git add %<CR>
nmap <Leader>gc :tab Git commit --verbose<CR>
nmap <Leader>gC :tab Git commit --verbose --amend<CR>
nmap <Leader>gp :Git push origin HEAD<CR>
nmap <Leader>gP :Git push origin HEAD --force<CR>

" Browse modified git files
nmap <Leader>gf :GitFiles -m<CR>

" Allow comments in json
autocmd FileType json syntax match Comment +\/\/.\+$+

" Use system clipboard in wayland
xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p


" let g:fzf_tags_command = 'fast-tags -R'

" Go to persistent model
command! -bang Model call fzf#vim#ag(expand("<cWORD>") . " sql", fzf#vim#with_preview(), <bang>1)
nnoremap <Leader>m :Model<CR>

hi link ALEError Error
hi Warning term=underline cterm=underline ctermfg=Yellow gui=undercurl guisp=Gold
hi link ALEWarning Warning
hi link ALEInfo SpellCap

" QuickFix nav
map <leader>c :copen<CR>
map <C-h> :cn<CR>
map <C-l> :cp<CR>

" Read externally generated quickfix items into a new quickfix window if file exists
nnoremap <silent> T :cexpr system("cat .quickfix")<CR>

" error format for something like
" src/Ben/Foo.hs:336:38: error: Variable not in scope: processorId :: Text
:set efm=%f:%l:%c:\ %m

" Coc.nvim bindings

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent><nowait> <space>f :<C-u>CocList symbols<cr>

" use [h and ]h to navigate between holes
nnoremap <silent> [h :<C-U>call CocActionAsync('diagnosticPrevious', 'hint')<CR>
nnoremap <silent> ]h :<C-U>call <SID>JumpToNextHole()<CR>

" <leader>d to perform a pattern match, <leader>n to fill a hole
nnoremap <silent> <leader>d  :<C-u>set operatorfunc=<SID>WingmanDestruct<CR>g@l
nnoremap <silent> <leader>n  :<C-u>set operatorfunc=<SID>WingmanFillHole<CR>g@l
nnoremap <silent> <leader>r  :<C-u>set operatorfunc=<SID>WingmanRefine<CR>g@l
nnoremap <silent> <leader>c  :<C-u>set operatorfunc=<SID>WingmanUseCtor<CR>g@l
nnoremap <silent> <leader>a  :<C-u>set operatorfunc=<SID>WingmanDestructAll<CR>g@l

function! s:JumpToNextHole()
  call CocActionAsync('diagnosticNext', 'hint')
endfunction

function! s:GotoNextHole()
  " wait for the hole diagnostics to reload
  sleep 500m
  " and then jump to the next hole
  normal 0
  call <SID>JumpToNextHole()
endfunction

function! s:WingmanRefine(type)
  call CocAction('codeAction', a:type, ['refactor.wingman.refine'])
  call <SID>GotoNextHole()
endfunction

function! s:WingmanDestruct(type)
  call CocAction('codeAction', a:type, ['refactor.wingman.caseSplit'])
  call <SID>GotoNextHole()
endfunction

function! s:WingmanDestructAll(type)
  call CocAction('codeAction', a:type, ['refactor.wingman.splitFuncArgs'])
  call <SID>GotoNextHole()
endfunction

function! s:WingmanFillHole(type)
  call CocAction('codeAction', a:type, ['refactor.wingman.fillHole'])
  call <SID>GotoNextHole()
endfunction

function! s:WingmanUseCtor(type)
  call CocAction('codeAction', a:type, ['refactor.wingman.useConstructor'])
  call <SID>GotoNextHole()
endfunction
