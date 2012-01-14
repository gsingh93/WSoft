Tree = require("tree").Tree
Trampoline = require("trampoline").Trampoline
Sandbox = require("sandbox").Sandbox
GlobalConstants = require("globalConstants")

-- Random object genarator
function generateObstacle(object, n)
	object[n] = display.newImage(object.imagePath)
	x = math.random(object[n].contentWidth, display.contentWidth-object[n].contentWidth)
	y = math.random(-display.contentHeight+object[n].contentHeight, -object[n].contentHeight)
	object[n].x = x
	object[n].y = y
	
	return object[n]
end

-- Scroll backgrounds and trees
local function scroll(event)
	-- Scroll the backgrounds
	background1.y = background1.y + background1.velocity.y
	background2.y = background2.y + background2.velocity.y
	background3.y = background3.y + background3.velocity.y

	-- Move the shadow
	box.shadow.y = box.shadow.y - box.velocity.z
	
	-- Change the z velocity
	if(box.shadow.y < box.y) then
		box.velocity.z = box.velocity.z - gravity
		print(box.velocity.z)
		print(box.shadow.y)
		--os.execute("ping 1.1.1.1 -n 1 -w 1000 > nul")
	elseif (box.shadow.y > box.y) then
		box.velocity.z = -box.velocity.z
	end
	
	if(box.velocity.z > 0) then
		box:scale(1/.99, 1/.99)
		box.shadow:scale(.99, .99)
	else
		box:scale(.99, .99)
		box.shadow:scale(1/.99, 1/.99)
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
	
	-- Scroll the trees and if a tree reaches the bottom, remove it and generate another tree
	for i = 1, n do
		tree[i].y = tree[i].y + tree.velocity
		if tree[i].y >= display.contentHeight+50 then
			tree[i]:removeSelf()
			tree[i] = generateObstacle(tree, i)
		end
	end
	
	-- Scroll the tramps and if a tramp reaches the bottom, remove it and generate another tramp
	for i = 1, n do
		tramp[i].y = tramp[i].y + tramp.velocity
		if tramp[i].y >= display.contentHeight+50 then
			tramp[i]:removeSelf()
			tramp[i] = generateObstacle(tramp, i)
		end
	end
	
	for i = 1, n do
		sandbox[i].y = sandbox[i].y + sandbox.velocity
		if sandbox[i].y >= display.contentHeight+50 then
			sandbox[i]:removeSelf()
			sandbox[i] = generateObstacle(sandbox, i)
		end
	end
end

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

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

-- Create a box and center it
box = display.newImage("images/personLOW.png", display.contentWidth/2, display.contentHeight - 20)
box.x = box.x - box.contentWidth/2
box.y = box.y - box.contentHeight

-- Initialize the box's shadow
box.shadow = display.newImage("images/person_shadowLOW.png", box.x- box.contentWidth/2, box.y - box.contentHeight/2)

-- Set the box's intial z velocity. This will change once cannon is implemented
box.velocity = {}
box.velocity.z = 40

-- Set the value of gravity
gravity = 1

-- Change by jordan
-- Accelerometer
local function onTilt( event )
	box.x = box.x + (10 * event.xGravity)
	--box.y = box.y + (35 * event.yGravity * -1)
end

Runtime:addEventListener("enterFrame", scroll)
Runtime:addEventListener("accelerometer", onTilt)

