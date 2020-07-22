
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
Plug 'lervag/vimtex'
Plug 'dag/vim-fish'
Plug 'plasticboy/vim-markdown'
" Other languages
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vmchale/ion-vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'uarun/vim-protobuf'
Plug 'jparise/vim-graphql'
Plug 'unisonweb/unison', { 'rtp': 'editor-support/vim' }
Plug 'keith/swift.vim'
Plug 'derekwyatt/vim-scala'
Plug 'elmcast/elm-vim'
Plug 'gleam-lang/gleam.vim'
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

" vimtex
" ------
" Explicitly specify that TeX is always really LaTeX
let g:tex_flavor = 'latex'
" Set the leader key for insert-mode bindings
let g:vimtex_imaps_leader = ';'

" vim-markdown
" ------------
" Disable automatic folding of sections in Markdown files
let g:vim_markdown_folding_disabled = 1

" vim-clang-format
" ----------------
let g:clang_format#code_style = 'llvm'

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
