-- Tree Class --
module(..., package.seeall)

local ObstacleClass = require ("obstacle")

Sandbox = ObstacleClass.Obstacle:new()

function Sandbox:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
