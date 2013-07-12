#!/usr/bin/osascript
-- luismartingil 2013
-- Applescript to launch an specific terminal configuration
-- Run from terminal with `osascript` or just ./<<script>>
-- Dont unfocus with the mouse/keyboard while executing. the script.


tell application "iTerm"
	
	set colorList to {"blue", "red", "yellow", "green", "blue"} as list
	
	--activate
	set myterm to (make new terminal)
	tell myterm
		repeat with colorItem in colorList
			set Lsession to (make new session)
			tell Lsession
				set name to colorItem
				set background color to colorItem
				set transparency to "0.1"
				--delay 0.5
			end tell
		end repeat
	end tell
	
	set mytermcount to count of terminal
	
	repeat with i from 1 to mytermcount by 1
		set myterm to (terminal i)
		
		tell myterm
			
			-- Count the number of sessions/tabs
			-- open in this terminal window
			set mytabcount to count of session
			
			-- Open each session in turn
			repeat with j from 1 to mytabcount by 1
				set mysession to (session j)
				
				-- If we find irssi, go to it
				--tell mysession
				--	write text "ls -lrt"
				--end tell
				
			end repeat
		end tell
	end repeat
	
end tell