#!/usr/bin/osascript
-- Applescript to launch iterm2 terminals/tabs with configurable:
-- ~ List of commands <cmds>
-- ~ Color <color>
-- ~ Name <name>
-- ~ Transparency <trans>
-- ~ Zoom out <zoomout>
-- ~ Split behavior horizontal(h) or vertical(v) <split> :: (h, v)
--
-- Run from terminal with `osascript` or just ./<<script>>
-- Dont unfocus with the mouse/keyboard while executing. the script.
-- Recomended to go full screen (CMD + Enter) if <zoomout> attributes used.
-- Change myTermWindow and myItem(s) as desired.
--
--
-- Author: Luis Martin Gil http://www.luismartingil.com
-- Year : 2013

tell application "iTerm"
	
	-- First tab
	set myItem1 to {}
	set myItem1 to myItem1 & {{color:"yellow", cmds:{"echo yellow", "ls -lrt"}, name:"name_yellow", trans:"0.1", zoomout:4, split:"h"}}
	set myItem1 to myItem1 & {{color:"blue", cmds:{"echo blue1", "ls -lrt"}, name:"name_blue1", trans:"0.1", zoomout:2, split:"v"}}
	set myItem1 to myItem1 & {{color:"blue", cmds:{"echo blue2", "ls -lrt"}, name:"name_blue2", trans:"0.1", zoomout:4, split:"v"}}
	set myItem1 to myItem1 & {{color:"blue", cmds:{"echo blue3", "ls -lrt"}, name:"name_blue3", trans:"0.1", zoomout:6}}
	
	-- Second tab	
	set myItem2 to {}
	set myItem2 to myItem2 & {{color:"red", cmds:{"echo red1", "ls -lrt"}, name:"name_red1", trans:"0.1", zoomout:8, split:"h"}}
	set myItem2 to myItem2 & {{color:"red", cmds:{"echo red2", "ls -lrt"}, name:"name_red2", trans:"0.1", zoomout:4}}
	
	-- Third tab
	set myItem3 to {}
	set myItem3 to myItem3 & {{color:"green", cmds:{"echo green", "ls -lrt"}, name:"name_green", trans:"0.1", zoomout:2, split:"v"}}
	set myItem3 to myItem3 & {{color:"purple", cmds:{"echo purple", "ls -lrt"}, name:"name_purple", trans:"0.1", zoomout:4}}
	
	set myTermWindow to {myItem1, myItem2, myItem3}
	
	set myterm to (make new terminal)
	
	tell myterm
		repeat with n from 1 to count of myTermWindow
			launch session n
			repeat with i from 1 to count of (item n of myTermWindow)
				-- Lets set the properties of the actual tab
				tell the last session to set name to name of (item i of (item n of myTermWindow))
				tell the last session to set background color to color of (item i of (item n of myTermWindow))
				tell the last session to set transparency to trans of (item i of (item n of myTermWindow))
				-- Some commands might require more columns to be readable
				repeat zoomout of (item i of (item n of myTermWindow)) times
					tell i term application "System Events" to keystroke "-" using command down
				end repeat
				-- Lets execute the commands for the tab
				repeat with cmd in cmds of (item i of (item n of myTermWindow))
					tell the last session to write text cmd
				end repeat
				-- Split the pane in a "D" (vertical) or "d" (horizontal) way
				if i is less than (count of (item n of myTermWindow)) then
					if "h" is split of (item i of (item n of myTermWindow)) then
						set split_str to "D"
					else if "v" is split of (item i of (item n of myTermWindow)) then
						set split_str to "d"
					else
						error
						return
					end if
					tell i term application "System Events" to keystroke split_str using command down
				end if
			end repeat
		end repeat
	end tell
end tell