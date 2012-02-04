Tree = require("tree").Tree
Trampoline = require("trampoline").Trampoline
Sandbox = require("sandbox").Sandbox
GlobalConstants = require("globalConstants")

-- Minimum amount of space between obstacles
PADDING = 10

-- Hide the status bar
display.setStatusBar(display.HiddenStatusBar)

-- Random position object genarator
function generateObstacle(obstacleType, player)
	obstacle = display.newImage(obstacleType.imagePath)
	
	obstacle.x = math.random(obstacle.contentWidth, display.contentWidth-obstacle.contentWidth)
	obstacle.y = math.random(-display.contentHeight+obstacle.contentHeight, -obstacle.contentHeight)
	
	for i,v in ipairs(tree) do
		print(overlap(obstacle, tree[i]))
		if(overlap(obstacle, tree[i])) then
			print(obstacleType.name .. " on top of tree. Trying again")
			print("Original Coords:")
			print(obstacle.x)
			print(obstacle.y)
			obstacle = generateObstacle(obstacleType)
			print("Final Coordinates:")
			print(obstacle.x)
			print(obstacle.y)
			print("We're back")
		end
	end
	
	for i,v in ipairs(sandbox) do
		print(overlap(obstacle, sandbox[i]))
		if(overlap(obstacle, sandbox[i])) then
			print(obstacleType.name .. " on top of sandbox. Trying again")
			print("Original Coords:")
			print(obstacle.x)
			print(obstacle.y)
			obstacle = generateObstacle(obstacleType)
			print("Final Coordinates:")
			print(obstacle.x)
			print(obstacle.y)
			print("We're back")
		end
	end
	
	for i,v in ipairs(tramp) do
		print(overlap(obstacle, tramp[i]))
		if(overlap(obstacle, tramp[i])) then
			print(obstacleType.name .. " on top of tramp. Trying again")
			print("Original Coords:")
			print(obstacle.x)
			print(obstacle.y)
			obstacle = generateObstacle(obstacleType)
			print("Final Coordinates:")
			print(obstacle.x)
			print(obstacle.y)
			print("We're back")
		end
	end
	print("-----")
	
	return obstacle
end

-- Scroll the object and if it reaches the bottom, remove it and generate another object
local function scrollObject(object)
	for i,v in ipairs(object) do
		object[i].y = object[i].y + object.velocity
		if object[i].y >= display.contentHeight+50 then
			object[i]:removeSelf()
			object[i] = generateObstacle(object)
			player.shadow:toFront()
			player:toFront()
		end
	end
end

function overlap(object1, object2)

	local xdiff = math.abs(object2.x - object1.x) - PADDING
	local ydiff = math.abs(object2.y - object1.y) - PADDING
	
	local w1 = object1.width
	local w2 = object2.width
	local h1 = object1.height
	local h2 = object2.height
	
	if xdiff < (w1+w2)*0.5  and ydiff < (h1+h2)*0.5 then
		return true
	else
		return false
	end
end

-- This can be simplified. Possibly by changing the way backgrounds work
local function changeVelocity(speedChange)
	background1.velocity.y = background1.velocity.y + speedChange
	background2.velocity.y = background2.velocity.y + speedChange
	background3.velocity.y = background3.velocity.y + speedChange
	
	tree.velocity = tree.velocity + speedChange
	tramp.velocity = tramp.velocity + speedChange
	sandbox.velocity = sandbox.velocity + speedChange
	
	if (background1.velocity.y <= 0) then
		--pause(10)
		changeVelocity(2)
	end
end

-- Scroll backgrounds and trees
local function scroll(event)

	-- Scroll the backgrounds
	background1.y = background1.y + background1.velocity.y
	background2.y = background2.y + background2.velocity.y
	background3.y = background3.y + background3.velocity.y
	

	
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
	scrollObject(tree)
	scrollObject(tramp)
	scrollObject(sandbox)
	
		-- Move the shadow
	player.shadow.y = player.shadow.y - player.velocity.z
	
	-- Change the z velocity
	if(player.shadow.y < player.y) then
		player.velocity.z = player.velocity.z - gravity
		--print(player.velocity.z)
		--print(player.shadow.y)
		--pause(1)
	elseif (player.shadow.y > player.y) then
		player.velocity.z = -player.velocity.z
		
		for i,v in ipairs(tramp) do
			if(overlap(player, tree[i])) then
				changeVelocity(tree.speedChange)
			elseif(overlap(player, tramp[i])) then
				changeVelocity(tramp.speedChange)
			elseif(overlap(player, sandbox[i])) then
				changeVelocity(sandbox.speedChange)
			end
		end
		
		-- Because the scaling is not exact, this stops the objects from growing
		-- or shrinking continuously
		player.xScale = 1.0
		player.yScale = 1.0
		player.shadow.xScale = 1.0
		player.shadow.yScale = 1.0
		player.shadow.y = player.y
		--pause(1)
	end
	
	if(player.velocity.z > 0) then
		player:scale(1/.99, 1/.99)
		player.shadow:scale(.99, .99)
	else
		player:scale(.99, .99)
		player.shadow:scale(1/.99, 1/.99)
	end
end

-- Accelerometer
local function onTilt( event )
	player.x = player.x + (25 * event.xGravity)
	--player.y = player.y + (35 * event.yGravity * -1)
	player.shadow.x = player.x
end

function pause (pauseTime)
	os.execute("timeout " .. pauseTime)
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

-- Creates n obstacles. TODO: Create a dynamic number of obstacles
tree = Tree:new()
tramp = Trampoline:new()
sandbox = Sandbox:new()

n = 3
for i = 1, n do
	tree[i] = generateObstacle(tree)
	tramp[i] = generateObstacle(tramp)
	sandbox[i] = generateObstacle(sandbox)
end

-- Create a player and center it
player = display.newImage("images/personLOW.png", display.contentWidth/2, display.contentHeight - 20)
player.x = player.x - player.contentWidth/2
player.y = player.y - player.contentHeight

parent = player.parent

-- Initialize the player's shadow
player.shadow = display.newImage("images/person_shadowLOW.png", player.x - player.contentWidth/2, player.y - player.contentHeight/2)

parent:insert(player)

-- Set the player's intial z velocity. This will change once cannon is implemented
player.velocity = {}
player.velocity.z = 40

-- Set the value of gravity
gravity = 1

Runtime:addEventListener("enterFrame", scroll)
Runtime:addEventListener("accelerometer", onTilt)

