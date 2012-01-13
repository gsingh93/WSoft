-- Tree Class --

function tree:new(velocity)
	return {self.velocity = velocity}
end

function tree:setVelocity(velocity)
	self.velocity = velocity
end


--[[-- Random tramp generator
local function generateTramp(n)
	tramp.n = display.newImage("images/trampolineLOW.png")
	x = math.random(tramp.n.contentWidth, display.contentWidth-tramp.n.contentWidth)
	y = math.random(-display.contentHeight+tramp.n.contentHeight, -tramp.n.contentHeight)
	tramp.n.x = x
	tramp.n.y = y
end
-- Random sandbox generator
local function generateSandBox(n)
	sandbox.n = display.newImage("images/sandboxLOW.png")
	x = math.random(sandbox.n.contentWidth, display.contentWidth-sandbox.n.contentWidth)
	y = math.random(-display.contentHeight+sandbox.n.contentHeight, -sandbox.n.contentHeight)
	sandbox.n.x = x
	sandbox.n.y = y
end
	]]--
	
	--[[background1 = display.newImage("images/grass.png", 0, 0)
background2 = display.newImage("images/grass.png", 0, 5-background1.contentHeight)
background3 = display.newImage("images/grass.png", 0, background1.contentHeight)

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
]]--

	
	--[[object.n = display.newImage(object.imagePath)
	x = math.random(object.n.contentWidth, display.contentWidth-object.n.contentWidth)
	y = math.random(-display.contentHeight+object.n.contentHeight, -object.n.contentHeight)
	object.n.x = x
	object.n.y = y
	
	return object.n]]--