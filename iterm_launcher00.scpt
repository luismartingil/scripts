-- luismartingil 2013
-- Applescript to launch an specific terminal configuration
-- Run from terminal with `osascript`

launch "iTerm"

tell application "iTerm"
	activate
	-- make a new terminal
	set myterm to (make new terminal)
	tell myterm
		
		set number of columns to 140
		set number of rows to 80
		
		--set theMessages to {"red", "blue", "yellow"}
		repeat with n from 1 to 3
			set sessionList to {}
			
			-- launch a default shell in a new tab in the same terminal
			launch session n
			
			tell i term application "System Events" to key code 30 using command down
			-- zoom out
			tell i term application "System Events" to keystroke "-" using command down
			tell i term application "System Events" to keystroke "-" using command down
			tell i term application "System Events" to keystroke "-" using command down
			
			tell i term application "System Events" to keystroke "d" using command down
			-- zoom out
			tell i term application "System Events" to keystroke "-" using command down
			tell i term application "System Events" to keystroke "-" using command down
			tell i term application "System Events" to keystroke "-" using command down
			
			tell i term application "System Events" to keystroke "D" using command down
			-- zoom out
			tell i term application "System Events" to keystroke "-" using command down
			tell i term application "System Events" to keystroke "-" using command down
			tell i term application "System Events" to keystroke "-" using command down
			
			tell i term application "System Events" to keystroke "d" using command down
			-- zoom out
			tell i term application "System Events" to keystroke "-" using command down
			tell i term application "System Events" to keystroke "-" using command down
			tell i term application "System Events" to keystroke "-" using command down
			
			tell i term application "System Events" to keystroke "52" using command down
			
			tell first item of sessions
				set name to "name1"
				set background color to "blue"
				set transparency to "0.1"
				write text "ls -lrt"
			end tell
			
			tell second item of sessions
				set name to "name2"
				set background color to "blue"
				set transparency to "0.1"
				write text "ls -lrt"
			end tell
			
			tell third item of sessions
				set name to "name3"
				set background color to "blue"
				set transparency to "0.1"
				write text "ls -lrt"
			end tell
			
			tell fourth item of sessions
				set name to "name4"
				set background color to "blue"
				set transparency to "0.1"
				write text "ls -lrt"
			end tell
			return sessionList
		end repeat
	end tell
end tell
