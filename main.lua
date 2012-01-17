Tree = require("tree").Tree
Trampoline = require("trampoline").Trampoline
Sandbox = require("sandbox").Sandbox
GlobalConstants = require("globalConstants")

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Random position object genarator
function generateObstacle(object, n)
	object[n] = display.newImage(object.imagePath)
	x = math.random(object[n].contentWidth, display.contentWidth-object[n].contentWidth)
	y = math.random(-display.contentHeight+object[n].contentHeight, -object[n].contentHeight)
	object[n].x = x
	object[n].y = y
	object[n].boundingBox = object:setBoundingBox({x = x, y = y, width = object[n].contentWidth, height = object[n].contentHeight, n = n})
	
	object[n].boundingBox:contains({x = x+1, y = y+1})
	
	return object[n]
end

-- Scroll the object and if it reaches the bottom, remove it and generate another object
local function scrollObject(object, n)
	for i = 1, n do
		object[i].y = object[i].y + object.velocity
		if object[i].y >= display.contentHeight+50 then
			object[i]:removeSelf()
			object[i] = generateObstacle(object, i)
		end
	end
end

-- Scroll backgrounds and trees
local function scroll(event)
	-- Scroll the backgrounds
	background1.y = background1.y + background1.velocity.y
	background2.y = background2.y + background2.velocity.y
	background3.y = background3.y + background3.velocity.y

	-- Move the shadow
	player.shadow.y = player.shadow.y - player.velocity.z
	
	-- Change the z velocity
	if(player.shadow.y < player.y) then
		player.velocity.z = player.velocity.z - gravity
		print(player.velocity.z)
		print(player.shadow.y)
		--os.execute("ping 1.1.1.1 -n 1 -w 1000 > nul")
	elseif (player.shadow.y > player.y) then
		player.velocity.z = -player.velocity.z
	end
	
	if(player.velocity.z > 0) then
		player:scale(1/.99, 1/.99)
		player.shadow:scale(.99, .99)
	else
		player:scale(.99, .99)
		player.shadow:scale(1/.99, 1/.99)
	end
	
	-- If the top of the background reaches the bottom of the screen
	-- Move it right above the screen
	if background1.y >= display.contentHeight then
		background1.y = 5-background1.contentHeight
	elseif background2.y >= display.contentHeight then
		background2.y = 5-background1.contentHeight
	elseif background3.y >= display.contentHeight then
		background3.y = 5-background1.contentHeight
	end
	
	-- Scroll all the obstacles
	scrollObject(tree, n)
	scrollObject(tramp, n)
	scrollObject(sandbox, n)
end

-- Accelerometer
local function onTilt( event )
	player.x = player.x + (10 * event.xGravity)
	--player.y = player.y + (35 * event.yGravity * -1)
	player.shadow.x = player.x
end

-- Set the backgrounds, sizes, and positions
local function initBackground(initY)
	local background = display.newImage("images/grass.png", 0, initY)
	background.width = display.contentWidth
	background:setReferencePoint(display.TopLeftReferencePoint)
	background.velocity = {}
	background.velocity.y = GlobalConstants.INITIAL_VELOCITY
	background.x = 0
	
	return background
end
background1 = initBackground(0)
background2 = initBackground(5-background1.contentHeight)
background3 = initBackground(background1.contentHeight)

-- Creates n trees. TODO: Create a dynamic number of trees and stop overlap of trees
tree = Tree:new({imagePath = "images/tree1small.png"})
tramp = Trampoline:new({imagePath = "images/trampolineLOW.png"})
sandbox = Sandbox:new({imagePath = "images/sandboxLOW.png"})

n = 3
for i = 1, n do
	tree[i] = generateObstacle(tree, i)
	tramp[i] = generateObstacle(tramp, i)
	sandbox[i] = generateObstacle(sandbox, i)
end

-- Create a player and center it
player = display.newImage("images/personLOW.png", display.contentWidth/2, display.contentHeight - 20)
player.x = player.x - player.contentWidth/2
player.y = player.y - player.contentHeight

-- Initialize the player's shadow
player.shadow = display.newImage("images/person_shadowLOW.png", player.x- player.contentWidth/2, player.y - player.contentHeight/2)

-- Set the player's intial z velocity. This will change once cannon is implemented
player.velocity = {}
player.velocity.z = 40

-- Set the value of gravity
gravity = 1

Runtime:addEventListener("enterFrame", scroll)
Runtime:addEventListener("accelerometer", onTilt)

