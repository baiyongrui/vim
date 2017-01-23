execute pathogen#infect()
syntax on
filetype plugin indent on

set nu

set hlsearch

set smartindent
set autoindent
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

set laststatus=2

set equalalways

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

inoremap ( ()<Esc>:call ParenthesisInsert(')')<CR>i
inoremap [ []<LEFT>
inoremap " ""<Esc>:call ParenthesisInsert('\"')<CR>i
inoremap ' ''<LEFT>
inoremap { {}<LEFT>

let g:leavechar = '' 
let g:curParenPos = -1
function ParenthesisInsert(curChar)
	let g:leavechar = a:curChar
	let g:curParenPos = col('.')
endfunction

function JumpOutParenthesis()
	let curPos = col('.')
	let	pos = match(getline('.'),g:leavechar,curPos)
	if g:curParenPos != -1 && curPos >= g:curParenPos && pos != -1 && pos >= curPos
		call cursor(line('.'),pos+1)
		let g:leavechar = ''
		let g:curParenPos = -1
		return "\<RIGHT>"
	else
		return "\t"
	endif
endfunction

inoremap <TAB> <c-r>=JumpOutParenthesis()<CR>

function ParenthesisCloseSkip()
	let line = getline('.')
	let char = line[col('.')]

	if char == ')'
		execute "normal! l"
	else
		normal! a)
	endif
endfunction

inoremap ) <ESC>:call ParenthesisCloseSkip()<CR>a
inoremap <C-e> <C-o>A
