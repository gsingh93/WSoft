-- Random tree generator
local function generateTree(n)
	tree.n = display.newImage("tree1small.png")
	x = math.random(tree.n.contentWidth, display.contentWidth-tree.n.contentWidth)
	y = math.random(-display.contentHeight+tree.n.contentHeight, -tree.n.contentHeight)
	tree.n.x = x
	tree.n.y = y
	print(tree.n.x, tree.n.y)
end
	
-- Scroll backgrounds and trees
local function scroll(event)
	-- Scroll the backgrounds
	background1.y = background1.y + background1.velocity
	background2.y = background2.y + background2.velocity
	background3.y = background3.y + background3.velocity
	
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
end

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

print(display.contentHeight)
print(display.contentWidth)

-- Set the backgrounds, sizes, and positions
background1 = display.newImage("grass.png", 0, 0)
background2 = display.newImage("grass.png", 0, 5-background1.contentHeight)
background3 = display.newImage("grass.png", 0, background1.contentHeight)

background1.width = display.contentWidth
background1:setReferencePoint(display.TopLeftReferencePoint)
background1.velocity = 2

background1.x = 0

background2.width = display.contentWidth
background2:setReferencePoint(display.TopLeftReferencePoint)
background2.velocity = 2
background2.x = 0

background3.width = display.contentWidth
background3:setReferencePoint(display.TopLeftReferencePoint)
background3.velocity = 2
background3.x = 0

-- Creates n trees. TODO: Create a dynamic number of trees and stop overlap of trees
tree = {}
n = 3
for i= 1, n do
	generateTree(n)
end
tree.velocity = 2

-- Create a box and center it
local box = display.newImage("box.jpg", display.contentWidth/2, display.contentHeight - 20)
box.x = box.x - box.contentWidth/2
box.y = box.y - box.contentHeight


Runtime:addEventListener("enterFrame", scroll)
