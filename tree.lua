-- Tree Class --
module(..., package.seeall)

local ObstacleClass = require ("obstacle")

Tree = ObstacleClass.Obstacle:new()

function Tree:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
