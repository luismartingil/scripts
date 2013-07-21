#!/usr/bin/osascript
tell application "iTerm"
	
	set myList to {}
	set myList to myList & {{color:"yellow", command:"echo yellow ; ls -lrt", name:"name_yellow", trans:"0.1"}}
	set myList to myList & {{color:"blue", command:"echo blue; ls -lart", name:"name_blue", trans:"0.1"}}
	
	set myterm to (make new terminal)
	
	tell myterm
		repeat with n from 1 to count of myList
			set myitem to (launch session n)
			tell myitem
				set name to name of (item n of myList)
				set background color to color of (item n of myList)
				set transparency to trans of (item n of myList)
				write text command of (item n of myList)
			end tell
		end repeat
	end tell
end tell