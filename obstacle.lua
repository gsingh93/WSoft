-- Obstacle Abstract Class
module(..., package.seeall)

local MovingObject = require("movingObject").MovingObject

Obstacle = MovingObject:new()

function Obstacle:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
