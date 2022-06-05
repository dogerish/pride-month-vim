hi TabLine    term=underline cterm=reverse gui=reverse
let s:rainbowStatus = 0
let s:rainbowColors = [[]]
let i = 0
for line in readfile(expand('<sfile>:p:h') . '/pride-month-colors.vim')
	if strlen(line) == 0 || line[0:1] == '"#'
		continue
	elseif line == '" NEXT'
		let i += 1
		call add(s:rainbowColors, [])
		continue
	endif
	call add(s:rainbowColors[i], line)
endfor
func AlternateColors(timer)
	for line in s:rainbowColors[s:rainbowStatus]
		exe line
	endfor
	let s:rainbowStatus = (s:rainbowStatus + 1) % len(s:rainbowColors)
endfunc
call AlternateColors(0)
let s:rainbowTimer = timer_start(500, 'AlternateColors', {'repeat': -1})
command RainbowStop call timer_stop(s:rainbowTimer) | hi clear
