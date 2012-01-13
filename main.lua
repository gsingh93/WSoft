INITIAL_VELOCITY = 2;

-- Random object genarator
function generateObstacle(object, n)
	object[n] = display.newImage(object.imagePath)
	x = math.random(object[n].contentWidth, display.contentWidth-object[n].contentWidth)
	y = math.random(-display.contentHeight+object[n].contentHeight, -object[n].contentHeight)
	object[n].x = x
	object[n].y = y
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
	if(box.shadow.y < box.y or box.velocity.z > 0) then
		box.velocity.z = box.velocity.z - gravity
		print(box.velocity.z)
		print(box.shadow.y)
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
	for i = 0, n do
		tree.n.y = tree.n.y + tree.velocity
		if tree.n.y >= display.contentHeight+50 then
			tree.n:removeSelf()
			generateTree(n)
		end
	end
		-- Scroll the tramps and if a tramp reaches the bottom, remove it and generate another tramp
	for i = 0, n do
		tramp.n.y = tramp.n.y + tramp.velocity
		if tramp.n.y >= display.contentHeight+50 then
			tramp.n:removeSelf()
			generateTramp(n)
		end
	end
	
	for i = 0, n do
		sandbox.n.y = sandbox.n.y + sandbox.velocity
		if sandbox.n.y >= display.contentHeight+50 then
			sandbox.n:removeSelf()
			generateSandBox(n)
		end
	end
end

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Set the backgrounds, sizes, and positions
function initBackground(initY)
	local background = display.newImage("images/grass.png", 0, initY)
	background.width = display.contentWidth
	background:setReferencePoint(display.TopLeftReferencePoint)
	background.velocity = {}
	background.velocity.y = INITIAL_VELOCITY
	background.x = 0
	
	return background
end
background1 = initBackground(0)
background2 = initBackground(5-background1.contentHeight)
background3 = initBackground(background1.contentHeight)

-- Creates n trees. TODO: Create a dynamic number of trees and stop overlap of trees
tree = {}
tramp = {}
sandbox = {}
tree.velocity = 2
tree.imagePath = "images/tree1small.png"
tramp.velocity = 2
tramp.imagePath = "images/sandboxLOW.png"
sandbox.velocity = 2
sandbox.imagePath = "images/trampolineLOW.png"

n = 3
for i= 1, n do
	tree.i = generateObstacle(tree, i)
	tramp.i = generateObstacle(tramp, i)
	sandbox.i = generateObstacle(sandbox, i)
end

-- Create a box and center it
box = display.newImage("images/box.jpg", display.contentWidth/2, display.contentHeight - 20)
box.x = box.x - box.contentWidth/2
box.y = box.y - box.contentHeight

-- Initialize the box's shadow
box.shadow = display.newImage("images/box.jpg", box.x- box.contentWidth/2, box.y - box.contentHeight/2)

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

