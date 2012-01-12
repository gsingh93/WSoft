-- Random tree generator
local function generateTree(n)
	tree.n = display.newImage("../images/tree1small.png")
	x = math.random(tree.n.contentWidth, display.contentWidth-tree.n.contentWidth)
	y = math.random(-display.contentHeight+tree.n.contentHeight, -tree.n.contentHeight)
	tree.n.x = x
	tree.n.y = y
end
-- Random tramp generator
local function generateTramp(n)
	tramp.n = display.newImage("../images/trampolineLOW.png")
	x = math.random(tramp.n.contentWidth, display.contentWidth-tramp.n.contentWidth)
	y = math.random(-display.contentHeight+tramp.n.contentHeight, -tramp.n.contentHeight)
	tramp.n.x = x
	tramp.n.y = y
end
-- Random sandBox generator
local function generateSandBox(n)
	sandBox.n = display.newImage("../images/sandboxLOW.png")
	x = math.random(sandBox.n.contentWidth, display.contentWidth-sandBox.n.contentWidth)
	y = math.random(-display.contentHeight+sandBox.n.contentHeight, -sandBox.n.contentHeight)
	sandBox.n.x = x
	sandBox.n.y = y
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
		sandBox.n.y = sandBox.n.y + sandBox.velocity
		if sandBox.n.y >= display.contentHeight+50 then
			sandBox.n:removeSelf()
			generateSandBox(n)
		end
	end
end

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

print(display.contentHeight)
print(display.contentWidth)

-- Set the backgrounds, sizes, and positions
background1 = display.newImage("../images/grass.png", 0, 0)
background2 = display.newImage("../images/grass.png", 0, 5-background1.contentHeight)
background3 = display.newImage("../images/grass.png", 0, background1.contentHeight)

background1.width = display.contentWidth
background1:setReferencePoint(display.TopLeftReferencePoint)
background1.velocity = {}
background1.velocity.y = 2
background1.x = 0

background2.width = display.contentWidth
background2:setReferencePoint(display.TopLeftReferencePoint)
background2.velocity = {}
background2.velocity.y = 2
background2.x = 0

background3.width = display.contentWidth
background3:setReferencePoint(display.TopLeftReferencePoint)
background3.velocity = {}
background3.velocity.y = 2
background3.x = 0

-- Creates n trees. TODO: Create a dynamic number of trees and stop overlap of trees
tree = {}
tramp = {}
sandBox = {}
n = 3
for i= 1, n do
	generateTree(n)
	generateTramp(n)
	generateSandBox(n)
end
tree.velocity = 2
tramp.velocity = 2
sandBox.velocity = 2

-- Create a box and center it
box = display.newImage("../images/box.jpg", display.contentWidth/2, display.contentHeight - 20)
box.x = box.x - box.contentWidth/2
box.y = box.y - box.contentHeight

-- Initialize the box's shadow
box.shadow = display.newImage("../images/box.jpg", box.x- box.contentWidth/2, box.y - box.contentHeight/2)

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

