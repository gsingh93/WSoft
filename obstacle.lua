-- Obstacle Abstract Class
module(..., package.seeall)

local MovingObject = require("movingObject").MovingObject
local BoundingBox = require("boundingbox").BoundingBox

Obstacle = MovingObject:new()

function Obstacle:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Obstacle:setBoundingBox(o)
	boundingBox = BoundingBox:new({x = o.x, y = o.y,
		width = o.width, height = o.height})
		
	return boundingBox
end
