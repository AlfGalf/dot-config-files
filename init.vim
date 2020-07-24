
" =============================================================================================================
"                                       Alfie Richards nvim config
" =============================================================================================================

" 	Initial
" Set default shell to zsh
set shell=/bin/zsh

"	Plugins
" Start vimplug
call plug#begin()

" COPY OF SORENS CONFIG
"
" Appearance
" ----------
" Display an info bar (lightline) at the bottom of the screen
Plug 'itchyny/lightline.vim'
" Highlight the region just yanked
Plug 'machakann/vim-highlightedyank'
" Only display relative numbers in places that make sense
Plug 'jeffkreeftmeijer/vim-numbertoggle'

" Editing
" -------
" Expand or contract the current selection
Plug 'terryma/vim-expand-region'
" Jump to an instance of two characters (rather than 1 with default f)
Plug 'justinmk/vim-sneak'

" Files
" -----
" Change working directory to the project root when opening a file
Plug 'airblade/vim-rooter'
" Fuzzy file finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Semantic language support
" -------------------------
" Language server support
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
" Completion support
Plug 'lifepillar/vim-mucomplete'

" Syntactic language support
" --------------------------
" Languages under active use
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'plasticboy/vim-markdown'

" Other languages
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vmchale/ion-vim'
Plug 'keith/swift.vim'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
" Extra tools
Plug 'godlygeek/tabular'
Plug 'rhysd/vim-clang-format'

" Utility
" -------
" Protection against modeline vulnerability
Plug 'ciaranm/securemodelines'

call plug#end()

" ===============
" PLUGIN SETTINGS
" ===============

" lightline.vim
" -------------
" Turn off default nvim display of current mode, because it's shown in lightline
set noshowmode
" Set a colour scheme and add a custom filename pattern.
let g:lightline = {
    \   'colorscheme': 'deus',
    \   'component_function': {
    \       'filename': 'LightlineFilename',
    \   },
\ }


function! LightlineFilename()
  return expand('%:t') !=# '' ? @% : '[No Name]'
endfunction

" coc.nvim
" --------
" List of language server extensions to install if they aren't already
let g:coc_global_extensions = [
    \ "coc-clangd",
    \ "coc-git",
    \ "coc-html",
    \ "coc-json",
    \ "coc-markdownlint",
    \ "coc-omnisharp",
    \ "coc-rust-analyzer",
    \ "coc-sourcekit",
    \ "coc-yaml",
    \ ]
" Shorten the update time of nvim to help with delays
set updatetime=300
" Customise some of the colours used in the Coc Pmenu
hi CocFloating ctermbg=black
" Always show the signcolumn, and give it a transparent background
set signcolumn=yes
hi SignColumn ctermbg=none
" Rename the symbol under the cursor with <leader>rn
nmap <silent> gr <Plug>(coc-rename)
" Jump to the definition with gd
nmap <silent> gd <Plug>(coc-definition)
" Jump to implementations with gi
nmap <silent> gi <Plug>(coc-implementation)
" Jump to usages with gu
nmap <silent> gu <Plug>(coc-references)
" Show documentation in the preview window for the symbol under the cursor when pressing K
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction


" fzf.vim
" -------
" Shrink the size of the fzf file finder window
let g:fzf_layout = { 'down': '~20%' }
let $FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
" Open a fuzzy file finder with C-p and a fuzzy buffer finder with leader-;
map <C-p> :Files<CR>
nmap <leader>; :Buffers<CR>
" Run a Rg search with <leader>s
noremap <leader>s :Rg 
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
\ <bang>0)

" vim-mucomplete
" --------------
" mucomplete says this option is required
set completeopt=menu
set completeopt+=menuone
set completeopt+=noinsert
" Turn off completion messages
set shortmess+=c
" Turn off auto-completion at startup
let g:mucomplete#enable_auto_at_startup = 0
" Set up completion chains
let g:mucomplete#chains = {
\   'default': ['tags', 'nsnp'],
\   'rust': {
\     'default': ['omni', 'nsnp'],
\     'rustString.*': [],
\     'rustComment.*': ['spel'],
\   },
\   'vim' : {
\     'default': ['cmd', 'nsnp', 'keyn'],
\     'vimComment.*': [],
\     'vimString.*': ['spel']
\   },
\ }

" rust.vim
" --------
" Turn on automatic formatting on save using nightly rustfmt
let g:rustfmt_command = 'rustup run nightly rustfmt'
let g:rustfmt_autosave = 1

" =================
" LANGUAGE SETTINGS
" =================
"
" Rust
" ----
augroup rust | au!
    " Set the text width in Rust files to 80, for comment wrapping.
    au Filetype rust setlocal textwidth=80
augroup END

" ===============
" EDITOR SETTINGS
" ===============

" Text Editing
" ------------
" Turn on filetype detection and plugin/indent info loading
filetype plugin indent on
" set tabs to have 4 spaces
set ts=4
" Use 4-space indentation
set shiftwidth=4
set softtabstop=4
set expandtab
" Auto-indent on new lines
set autoindent
" Don't insert two spaces after certain characters when using a join command
set nojoinspaces
" Wrap to 100 characters
set textwidth=100
" Format options (default fo=jcroql)
set fo=ca " Auto-wrap comments to textwidth
set fo+=r " Auto-insert the current comment leader when pressing enter in insert mode
set fo+=o " Auto-insert the current comment leader when entering new lines with o
set fo+=q " Allow `gq` to format comments
set fo+=w " Use a single trailing whitespace character to indicate continuing paragraphs
set fo+=n " Format numbered lists as well
set fo+=j " Auto-remove comment characters when joining lines

" Text Display
" ------------
" Set the number of lines to keep visible above and below the cursor at the top and bottom of the 
" screen
set scrolloff=2
" Don't soft-wrap long lines to display them in the buffer
set nowrap
" Display line numbers in the sidebar
set number
" Display line numbers for every line but the current one as an offset
set relativenumber
