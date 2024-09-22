set hlsearch
set incsearch
set nowrapscan
set number
set relativenumber
set ruler
set shiftwidth=2
set showcmd
set softtabstop=4
set wildmenu
set expandtab

call plug#begin()
  " Use release branch (recommend)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}

  Plug 'preservim/nerdtree'
  Plug 'preservim/tagbar'

  Plug 'rhysd/vim-clang-format'

  Plug 'airblade/vim-gitgutter'

  Plug 'tpope/vim-fugitive'

  Plug 'kshenoy/vim-signature'

  Plug 'sickill/vim-monokai'
  Plug 'clangd/coc-clangd'
  Plug 'jiangmiao/auto-pairs'
  Plug 'itchyny/lightline.vim'
call plug#end()

let mapleader = ","

"====================
" colorscheme
"====================
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
set termguicolors
set background=dark
colorscheme solarized8

"====================
" misc switch
"====================
inoremap <CR> <ESC>
nnoremap <Space> :

nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>x :x<CR>
nnoremap <leader>b :ls<CR>:b 
nnoremap <leader>e :e <C-R>=expand("%:h") . "/" <CR>
nnoremap <leader>t :tabe <C-R>=expand("%:h") . "/" <CR>
nnoremap <leader>a :vertical resize +10<CR>
nnoremap <leader>z :vertical resize -10<CR>

"====================
" window switch
"====================
nnoremap `j <C-W>j
nnoremap `k <C-W>k
nnoremap `l <C-W>l
nnoremap `h <C-W>h

"====================
" lightline
"====================
set laststatus=2
let g:lightline = {
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'readonly', 'bufnum', 'filename', 'modified' ] ],
        \   'right': [[ 'lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
        \ },
        \ 'inactive': {
        \   'left': [ [ 'bufnum', 'filename' ]],
        \   'right': [ [ 'lineinfo', 'percent' ] ]
        \ },
        \ 'tab': {
        \   'active': ['tabnum', 'filename', 'modified'],
        \   'inactive': ['tabnum', 'filename', 'modified']
        \ },
        \ 'component': {
        \   'cwd': '%{getcwd()}'
        \ },
        \ 'component_function': {
        \   'gitbranch': 'FugitiveHead'
        \ }
        \ }

"====================
" tab config
"====================
noremap <C-N> :tabnew<CR>
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt

"====================
" nerdtree config
"====================

let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

nnoremap <leader>nn :NERDTreeToggle<CR>
nnoremap <leader>ne :NERDTree 
nnoremap <leader>nf :NERDTreeFind<CR>
nnoremap <leader>no :NERDTreeFocus<CR>

"====================
" tagbar config
"====================
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:tagbar_show_linenumbers = 2
nnoremap <leader>tt :TagbarToggle<CR>

"====================
" clang-format
"====================
let g:clang_format#command="clang-format-4.0"
noremap <leader>f :ClangFormat<CR>

"====================
" fugitive config
"====================
nnoremap <leader>gv :Gvsplit master:%<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gs :Git<CR><C-W>H<CR>
nnoremap <leader>ge :Gedit <C-R><C-G>

"====================
" command abbrev
"====================

"====================
" coc config
"====================
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ca  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Formatting selected code.
xmap <leader>fm  <Plug>(coc-format-selected)
" Use K to show documentation in preview window.
nnoremap <leader>doc :call <SID>show_documentation()<CR>

" see coc.nvim/plugin/coco.vim for more mapping details
nmap <leader>gd :<C-u>call CocActionAsync('jumpDeclaration')<CR>
nmap <leader>gi :<C-u>call CocActionAsync("jumpDefinition")<CR>
nmap <leader>gr :<C-u>call CocActionAsync('jumpReferences')<CR>

autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
" inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
hi link CocHighlightText SpellBad
autocmd CursorHold * silent call CocActionAsync('highlight')

"====================
" => Helper functions
"====================
func! DeleteTillSlash()
    let g:cmd = getcmdline()

    if has("win16") || has("win32")
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\]\\).*", "\\1", "")
    else
        let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*", "\\1", "")
    endif

    if g:cmd == g:cmd_edited
        if has("win16") || has("win32")
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[\\\\\]\\).*\[\\\\\]", "\\1", "")
        else
            let g:cmd_edited = substitute(g:cmd, "\\(.*\[/\]\\).*/", "\\1", "")
        endif
    endif   

    return g:cmd_edited
endfunc
" $q is super useful when browsing on the command line
" it deletes everything until the last slash 
cno <C-B> <C-\>eDeleteTillSlash()<CR>
