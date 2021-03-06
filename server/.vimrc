set nocompatible
set ignorecase
set smartcase
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
set smarttab
set autoindent
set smartindent
set nu
set incsearch
set hlsearch
set showmatch
set mouse=a
"set selection=exclusive
set selection=inclusive
set selectmode=mouse,key
map <s-tab> :bnext <cr>
set nobackup
set noswapfile
set clipboard=unnamed

filetype off


" assuming you want to use ultisnips snippet engine
let g:UltiSnipsSnippetDirectories=['UltiSnips']
let g:UltiSnipsEditSplit="vertical"

" ycm config
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion=1

" ultisnips config
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_use_ultisnips_completer = 1
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'


" better key bindings for UltiSnipsExpandTrigger

let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


"Nerdtree settings
" configure the nerdtree window
"let g:NERDTreeWinPos =
"let g:nerdtree_tabs_open_on_console_startup=1
let g:nerdtree_tabs_smart_startup_focus = 1
let g:nerdtree_tabs_open_on_new_tab = 1
let g:nerdtree_tabs_meaningful_tab_names = 1
let g:nerdtree_tabs_autoclose = 1
let g:nerdtree_tabs_synchronize_view = 1
let g:nerdtree_tabs_synchronize_focus = 1
let g:nerdtree_tabs_focus_on_files = 1
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
"autocmd VimEnter * NERDTree
"autocmd VimEnter * NERDTreeMirror
"autocmd VimEnter * NERDTreeMirrorOpen
"autocmd VimEnter * NERDTreeTabsOpen
"autocmd VimEnter * wincmd p


" airline configuration
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme= 'jellybeans'
let g:airline_powerline_fonts = 1

" Go Support
" Automagically run goimports on save
let g:go_fmt_command = "goimports"

" Run lint and vet on save
let g:go_metalinter_autosave = 1

" go hightling
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)


" ctrlp config
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

"let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links'}

let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']


" easy motion config
"
let g:EasyMotion_smartcase = 1
"let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
map <Leader><leader>h <Plug>(easymotion-linebackward)
map <Leader><Leader>j <Plug>(easymotion-j)
map <Leader><Leader>k <Plug>(easymotion-k)
map <Leader><leader>l <Plug>(easymotion-lineforward)
" repeat the last op
map <Leader><leader>. <Plug>(easymotion-repeat)



set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
     
Plugin 'gmarik/Vundle.vim'
	   
" My vim scripts
Plugin 'The-NERD-Commenter'
Plugin 'a.vim'
Plugin 'ervandew/supertab'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'rdnetto/YCM-Generator'
"Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'jiangmiao/auto-pairs'
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
"Plugin 'mhinz/vim-startify'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-fugitive'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'fatih/vim-go'
Plugin 'solarnz/thrift.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'easymotion/vim-easymotion'
"colors configuration
Plugin 'flazz/vim-colorschemes'
Plugin 'vim-airline/vim-airline-themes'
" End my vim scripts

call vundle#end()            " required


filetype plugin indent on    " required

syntax enable
syntax on

colorscheme molokai


" F5 to run c/cpp/java/python
map <F5> :call CompileRun()<CR>
func! CompileRun()
exec "w"
if expand('%:e') == "c"
    exec "!gcc % -o %<.c&&./%<.c"
elseif expand('%:e') == "cpp" || expand('%:e') == "cc"
    exec "!g++ -std=c++11 % -o %<&& ./%< && rm %<" 
elseif expand('%:e') == "java"
    exec "!javac %&&java %:r"
elseif expand('%:e') == "py"
    exec "!python %"
endif
endfun


"python config with virtualenv support
py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  execfile(activate_this, dict(__file__=activate_this))
EOF
