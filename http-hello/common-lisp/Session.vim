let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
let NERDTreeMapPreviewSplit = "gi"
let SignatureDeferPlacement =  1 
let GuiLinespace =  0 
let NERDTreeShowHidden =  0 
let SignatureMarkerTextHLDynamic =  0 
let NERDTreeMapCloseChildren = "X"
let NERDTreeMapCloseDir = "x"
let SignatureWrapJumps =  1 
let NERDTreeSortHiddenFirst =  1 
let NERDTreeMinimalUI =  0 
let NERDTreeShowLineNumbers =  0 
let NERDTreeRespectWildIgnore =  0 
let SignatureMarkTextHL = "SignatureMarkText"
let EditorConfig_preserve_formatoptions =  0 
let NERDTreeAutoDeleteBuffer =  0 
let NERDTreeBookmarksFile = "/Users/gregwerbin/.NERDTreeBookmarks"
let NERDTreeWinSize =  31 
let NERDTreeMenuUp = "k"
let EditorConfig_exec_path = ""
let NERDTreeUseTCD =  0 
let NERDTreeMapToggleFiles = "F"
let SignaturePeriodicRefresh =  1 
let NERDTreeMapPreview = "go"
let NERDTreeNotificationThreshold =  100 
let NERDTreeMapActivateNode = "o"
let NERDTreeMapCustomOpen = "<CR>"
let NERDTreeWinPos = "left"
let NERDTreeDirArrowExpandable = "▸"
let NERDTreeMapMenu = "m"
let NERDTreeStatusline = "%{exists('b:NERDTree')?b:NERDTree.root.path.str():''}"
let NERDTreeMapToggleHidden = "I"
let SignatureIncludeMarkers = ")!@#$%^&*("
let GuiFont = "Rec Mono Duotone:h12"
let NERDTreeMapOpenInTabSilent = "T"
let NERDTreeMapHelp = "?"
let NERDTreeMapJumpParent = "p"
let NERDTreeMapToggleFilters = "f"
let NERDTreeMapJumpLastChild = "J"
let GuiLoaded =  1 
let NERDTreeMapJumpPrevSibling = "<C-k>"
let NERDTreeNodeDelimiter = ""
let NERDTreeShowBookmarks =  0 
let NERDTreeRemoveDirCmd = "rm -rf "
let SignatureMarkOrder = "pm"
let EditorConfig_max_line_indicator = "line"
let NERDTreeMouseMode =  1 
let SignatureMarkLineHL = "SignatureMarkLine"
let NERDTreeChDirMode =  0 
let NERDTreeCreatePrefix = "silent"
let NERDTreeAutoCenterThreshold =  3 
let NERDTreeShowFiles =  1 
let NERDTreeMapOpenSplit = "i"
let SignatureEnabledAtStartup =  1 
let NERDTreeCaseSensitiveSort =  0 
let NERDTreeHijackNetrw =  1 
let SignatureMarkerLineHL = "SignatureMarkerLine"
let NERDTreeCascadeSingleChildDir =  1 
let NERDTreeMapRefresh = "r"
let SignatureForceMarkPlacement =  0 
let NERDTreeBookmarksSort =  1 
let NERDTreeHighlightCursorline =  1 
let NERDTreeMapOpenInTab = "t"
let SignatureMarkTextHLDynamic =  0 
let SignatureIncludeMarks = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let NERDTreeMapCWD = "CD"
let NERDTreeNaturalSort =  0 
let NERDTreeMapPreviewVSplit = "gs"
let NERDTreeMapUpdir = "u"
let EditorConfig_verbose =  0 
let NERDTreeGlyphReadOnly = "RO"
let NERDTreeMapChdir = "cd"
let NERDTreeMenuDown = "j"
let NERDTreeMapToggleZoom = "A"
let NERDTreeMarkBookmarks =  1 
let SignatureMarkerTextHL = "SignatureMarkerText"
let NERDTreeMinimalMenu =  0 
let NERDTreeMapRefreshRoot = "R"
let SignatureForceMarkerPlacement =  0 
let NERDTreeAutoCenter =  1 
let NERDTreeCascadeOpenSingleChildDir =  1 
let SignatureErrorIfNoAvailableMarks =  1 
let NERDTreeMapOpenVSplit = "s"
let GuiWindowMaximized =  1 
let GuiWindowFullScreen =  0 
let SignaturePurgeConfirmation =  0 
let NERDTreeMapDeleteBookmark = "D"
let NERDTreeMapJumpNextSibling = "<C-j>"
let GuiWindowId =  0 
let NERDTreeMapJumpRoot = "P"
let SignatureDeleteConfirmation =  0 
let NERDTreeCopyCmd = "cp -r "
let NERDTreeMapQuit = "q"
let NERDTreeMapChangeRoot = "C"
let SignatureForceRemoveGlobal =  0 
let SignaturePrioritizeMarks =  1 
let NERDTreeSortDirs =  1 
let NERDTreeMapOpenExpl = "e"
let NERDTreeMapJumpFirstChild = "K"
let NERDTreeDirArrowCollapsible = "▾"
let NERDTreeMapOpenRecursively = "O"
let NERDTreeMapToggleBookmarks = "B"
let NERDTreeMapUpdirKeepOpen = "U"
let NERDTreeQuitOnOpen =  0 
let SignatureRecycleMarks =  0 
silent only
silent tabonly
exe "cd " . escape(expand("<sfile>:p:h"), ' ')
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +2 http-hello.lisp
badd +1 ~/.config/nvim/plugin/plugin-config.vim
badd +1 http-hello.asd
badd +1 qlfile
badd +1 vlime\ \|\ arglist
argglobal
%argdel
$argadd ~/Personal/polyglot/http-hello/common-lisp/http-hello.lisp
tabnew
tabnew
tabnew
tabrewind
edit ~/.config/nvim/plugin/plugin-config.vim
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 119 + 120) / 240)
exe 'vert 2resize ' . ((&columns * 120 + 120) / 240)
argglobal
balt http-hello.lisp
setlocal fdm=marker
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
96
normal! zo
164
normal! zo
let s:l = 202 - ((31 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 202
normal! 043|
wincmd w
argglobal
if bufexists("~/.local/share/nvim/site/pack/packer/opt/vlime/vim/doc/vlime.txt") | buffer ~/.local/share/nvim/site/pack/packer/opt/vlime/vim/doc/vlime.txt | else | edit ~/.local/share/nvim/site/pack/packer/opt/vlime/vim/doc/vlime.txt | endif
if &buftype ==# 'terminal'
  silent file ~/.local/share/nvim/site/pack/packer/opt/vlime/vim/doc/vlime.txt
endif
balt ~/.config/nvim/plugin/plugin-config.vim
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
silent! normal! zE
let &fdl = &fdl
let s:l = 1118 - ((50 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1118
normal! 051|
wincmd w
exe 'vert 1resize ' . ((&columns * 119 + 120) / 240)
exe 'vert 2resize ' . ((&columns * 120 + 120) / 240)
if exists(':tcd') == 2 | tcd ~/.config/nvim | endif
tabnext
edit ~/Personal/polyglot/http-hello/common-lisp/qlfile
argglobal
balt ~/Personal/polyglot/http-hello/common-lisp/vlime\ \|\ repl\ \|\ Vlime\ Connection\ 1
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 025|
tabnext
edit ~/Personal/polyglot/http-hello/common-lisp/http-hello.asd
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
balt ~/Personal/polyglot/http-hello/common-lisp/vlime\ \|\ arglist
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 9 - ((8 * winheight(0) + 30) / 61)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 9
normal! 037|
tabnext
edit ~/Personal/polyglot/http-hello/common-lisp/http-hello.lisp
argglobal
balt ~/Personal/polyglot/http-hello/common-lisp/http-hello.asd
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
tabnext 4
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0&& getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFI
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
