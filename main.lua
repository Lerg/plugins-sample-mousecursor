display.setStatusBar(display.HiddenStatusBar)

local widget = require('widget')
local mousecursor = require('plugin.mousecursor')

local cursors = {}

display.setDefault('background', 1)

local xl, xr, y = display.contentWidth * .25, display.contentWidth * .75, display.contentCenterY
local w, h = display.contentWidth * 0.45, 50

widget.newButton{
	x = xl, y = y - 120,
	width = w, height = h,
	label = 'Arrow',
	onRelease = function()
		if not cursors.arrow then
			cursors.arrow = mousecursor.newCursor('arrow')
		end
		cursors.arrow:show()
	end
}

widget.newButton{
	x = xr, y = y - 120,
	width = w, height = h,
	label = 'Crosshair',
	onRelease = function()
		if not cursors.crosshair then
			cursors.crosshair = mousecursor.newCursor('crosshair')
		end
		cursors.crosshair:show()
	end
}

widget.newButton{
	x = xl, y = y - 80,
	width = w, height = h,
	label = 'Custom image',
	onRelease = function()
		if not cursors.image then
			local filename = 'cursor.png'
			-- Detect windows.
			if (system.getInfo('environment') == 'simulator' and (system.getInfo('architectureInfo') == 'x86' or system.getInfo('architectureInfo') == 'x64')) or system.getInfo('platform') == 'win32' then
				filename = 'cursor.ani'
			end
			cursors.image = mousecursor.newCursor{
				filename = filename,
				x = 32,	y = 32
			}
		end
		cursors.image:show()
	end
}

widget.newButton{
	x = xr, y = y - 80,
	width = w, height = h,
	label = 'Operation not allowed',
	onRelease = function()
		if not cursors.operationNotAllowed then
			cursors.operationNotAllowed = mousecursor.newCursor('operation not allowed')
		end
		cursors.operationNotAllowed:show()
	end
}

widget.newButton{
	x = xl, y = y - 40,
	width = w, height = h,
	label = 'Pointing hand',
	onRelease = function()
		if not cursors.pointingHand then
			cursors.pointingHand = mousecursor.newCursor('pointing hand')
		end
		cursors.pointingHand:show()
	end
}

widget.newButton{
	x = xr, y = y - 40,
	width = w, height = h,
	label = 'Help',
	onRelease = function()
		if not cursors.help then
			cursors.help = mousecursor.newCursor('help')
		end
		cursors.help:show()
	end
}

widget.newButton{
	x = xl, y = y,
	width = w, height = h,
	label = 'Show',
	onRelease = function()
		mousecursor.show()
	end
}

widget.newButton{
	x = xr, y = y,
	width = w, height = h,
	label = 'Hide',
	onRelease = function()
		mousecursor.hide()
	end
}

widget.newButton{
	x = xl, y = y + 40,
	width = w, height = h,
	label = 'Show crosshair',
	onRelease = function()
		if cursors.crosshair then
			cursors.crosshair:show()
		end
	end
}

widget.newButton{
	x = xr, y = y + 40,
	width = w, height = h,
	label = 'Hide crosshair',
	onRelease = function()
		if cursors.crosshair then
			cursors.crosshair:hide()
		end
	end
}

local mouseXLabel = display.newText{
	text = 'X:',
	x = 20, y = display.contentHeight - 20,
	fontSize = 16
}
mouseXLabel:setFillColor(0, 0, 0.5)
mouseXLabel.anchorX = 0

local mouseYLabel = display.newText{
	text = 'Y:',
	x = 80, y = display.contentHeight - 20,
	fontSize = 16
}
mouseYLabel:setFillColor(0, 0, 0.5)
mouseYLabel.anchorX = 0

Runtime:addEventListener('mouse', function(event)
	mouseXLabel.text = 'X: ' .. event.x
	mouseYLabel.text = 'Y: ' .. event.y
end)

local function onSystemEvent( event )
    print( "System event name and type: " .. event.name, event.type )
end
  
Runtime:addEventListener('system', function(event)
	if event.type == 'applicationExit' then
		for k, cursor in pairs(cursors) do
			cursor:destroy()
		end
	end
end)