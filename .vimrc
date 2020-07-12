set background=dark
set encoding=utf-8
set tabstop=3
set expandtab
set shiftwidth=3
colorscheme solarized
set laststatus=2
set t_Co=256
let g:solarized_termcolors=256
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
set backspace=indent,eol,start
set fillchars+=stl:\ ,stlnc:\ ,vert:\|
"set rtp+=~/.local/lib/python2.7/site-packages/powerline/bindings/vim/
"set guifont=Menlo\ Regular\ for\ Powerline:h10
"set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types:h11
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Plus\ Nerd\ File\ Types\ Mono\ Plus\ Nerd\ File\ Types\ Plus\ Font\ Awesome\ Plus\ Octicons\ Plus\ Pomicons\ 10
set sessionoptions=curdir,buffers,tabpages,resize,winpos,winsize
set nu
set statusline+=%{fugitive#statusline()}
set statusline=%<%f\    " Filename
set statusline+=%w%h%m%r " Options
set statusline+=\ [%{&ff}/%Y]            " filetype
set statusline+=\ [%{getcwd()}]          " current dir
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set nocompatible

filetype off
syntax on

set rtp+=~/.vim/bundle/vundle/

call vundle#rc()

filetype plugin indent on


Bundle 'tpope/vim-fugitive'
Bundle 'lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'bling/vim-airline'
"Bundle 'Lokaltog/vim-powerline'
Bundle 'bling/vim-bufferline'
"Bundle 'kien/ctrlp.vim'
Bundle 'vim-scripts/TwitVim'
Bundle 'majutsushi/tagbar'
Bundle 'Xuyuanp/nerdtree-git-plugin'
Bundle 'scrooloose/nerdtree'
Bundle 'Shougo/unite.vim'
"Bundle 'techlivezheng/vim-plugin-minibufexpl'
Bundle 'scrooloose/syntastic'
"Bundle 'edkolev/tmuxline.vim'
Bundle 'tpope/vim-surround'
Bundle 'hallettj/jslint.vim'
Bundle 'mattn/emmet-vim'
"Bundle 'vim-scripts/phpfolding.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'digitaltoad/vim-jade'
Bundle 'wavded/vim-stylus'
Bundle 'sjl/badwolf'
Bundle 'jistr/vim-nerdtree-tabs'
Plugin 'ryanoasis/vim-devicons'
Plugin 'burnettk/vim-angular'
Bundle 'digitaltoad/vim-pug'
Bundle 'joonty/vdebug'
Bundle 'dag/vim-fish'
Bundle 'Quramy/tsuquyomi'
Plugin 'leafgarland/typescript-vim'

Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'rails.vim'


Bundle 'git://git.wincent.com/command-t.git'


let g:nerdtree_tabs_open_on_console_startup = 1


let g:airline_theme='dark'
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_enable_bufferline = 1
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'unicode'
let g:Powerline_mode_V = "V.LINE"
let g:Powerline_mode_cv = "V.BLOCK"
let g:Powerline_mode_S = "S.LINE"
let g:Powerline_mode_cs = "S.BLOCK"

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '' "'▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '' "'◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

let g:airline#extensions#bufferline#enabled = 1

"let g:molokai_original = 1
let g:rehash256 = 1

"let g:tmuxline_presets = 'nightly_fox'
"let g:airline#extensions#tmuxline#enabled = 1

let g:JSLintHighlightErrorLine = 0

let g:tagbar_right = 1
let g:tagbar_width = 30
let g:tagbar_iconchars = ['', '◢'] 
let g:tagbar_sort = 0

function! AirlineInit()
	let g:airline_section_a = airline#section#create(['mode',' ','branch'])
	let g:airline_section_b = airline#section#create_left(['ffenc','hunks','%f'])
	let g:airline_section_c = airline#section#create(['filetype'])
	let g:airline_section_x = airline#section#create(['%P'])
	let g:airline_section_y = airline#section#create(['%B'])
	let g:airline_section_z = airline#section#create_right(['%l','%c'])	
endfunction
autocmd VimEnter * call AirlineInit()

let loaded_matchparen = 1
autocmd VimLeavePre * silent mksession! ~/.vim/session/lastSession.vim
"autocmd VimEnter * silent source! ~/.vim/session/lastSession.vim



imap <f2> <ESC>:w<CR>
nmap <f2> <ESC>:w<CR>
"imap <C-s> <ESC>:w
"map! <f2> <ESC>:w<CR>

map <silent><leader>v :tabf ~/.vimrc<cr> 

map <f3>:source .vim/session/www.vim<cr>
imap <f3>:source .vim/session/www.vim<cr>

autocmd VimEnter * NERDTree
map <C-n> :NERDTree<CR>

map <F12> :NERDTreeToggle<cr>

"Emmet-vim
let g:user_emmet_install_global = 0
autocmd FileType html,css,php EmmetInstall
let g:user_emmet_mode='a'
let g:user_emmet_leader_key='<C-X>'

"NERDCommenter
map <leader> cc<cr> 
map <leader> cn<cr> 
map <leader> c<space><cr> 
map <leader> ci<cr> 
map <leader> cs<cr> 
map <leader> cy<cr> 
map <leader> c$<cr> 
map <leader> cA<cr> 
map <leader> ca<cr> 
map <leader> cl<cr>
map <leader> cb<cr> 
map <leader> cu<cr>

"NERD option
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_flagship_statusline = 1

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:webdevicons_enable_unite = 1
let g:webdevicons_enable_vimfiler = 1
let g:webdevicons_enable_airline_statusline = 1
let g:webdevicons_enable_ctrlp = 1
let g:WebDevIconsUnicodeDecorateFileNodes = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1
let g:WebDevIconsUnicodeDecorateFolderNodesExactMatches = 1
let g:WebDevIconsUnicodeDecorateFolderNodeDefaultSymbol = 'ƛ'
let g:DevIconsDefaultFolderOpenSymbol = 'ƛ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['js'] = 'ƛ'
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExactSymbols['MyReallyCoolFile.okay'] = 'ƛ'
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['myext'] = 'ƛ'



function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')

"autocmd VimEnter * call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')

if exists("g:loaded_webdevicons")
call webdevicons#refresh()
endif


"Angular
"let g:syntastic_html_tidy_blocklevel_tags = ['ng-app']

"TypeScript
au BufRead,BufNewFile *.ts   setfiletype typescript

"let g:typescript_indent_disable = 1
