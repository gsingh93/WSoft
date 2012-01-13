-- Obstacle Abstract Class
module(..., package.seeall)

local MovingObjectClass = require("movingObject")

Obstacle = MovingObjectClass.MovingObject:new()

function Obstacle:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
