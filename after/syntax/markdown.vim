" concealing

" NOTE: the syntax group mkdListItem is defined by the either
" 'preservim/vim-markdown' or  'ixru/nvim-markdown'

" " syn match mkdListItem /^>\=\s*[*+-]\s\+-\@!.*$/
" syn match mkdListItemBullet1 /^>\=\s*\zs[*+-]/ contained containedin=mkdListItem conceal cchar=◉
" syn match mkdListItem2 /^>\=\s\{4\}[*+-]/ contained containedin=mkdListItem
" syn match mkdListItemBullet2 /[*+-]/ contained containedin=mkdListItem2 conceal cchar=○
" syn match mkdListItem3 /^>\=\s\{8\}[*+-]/ contained containedin=mkdListItem
" syn match mkdListItemBullet3 /[*+-]/ contained containedin=mkdListItem3 conceal cchar=✸

" hi clear Conceal
" " hi link Conceal Keyword
" " hi link Conceal Function
" hi link Conceal DiagnosticInfo
