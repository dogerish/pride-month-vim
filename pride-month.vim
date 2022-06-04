hi TabLine    term=underline cterm=reverse gui=reverse
let g:rainbowStatus = 0
let g:rainbowColors = [[]]
let i = 0
for line in readfile(expand('<sfile>:p:h') . '/pride-month-colors.vim')
	if (strlen(line) == 0) || (line[0:1] == '"#')
		continue
	elseif line == '" NEXT'
		let i += 1
		let g:rainbowColors = add(g:rainbowColors, [])
		continue
	endif
	let g:rainbowColors[i] = add(g:rainbowColors[i], line)
endfor
func AlternateColors(timer)
	for line in g:rainbowColors[g:rainbowStatus % len(g:rainbowColors)]
		exe line
	endfor
	let g:rainbowStatus += 1
endfunc
let g:rainbowTimer = timer_start(500, 'AlternateColors', {'repeat': -1})
command RainbowStop exe timer_stop(g:rainbowTimer)
