-- Tree Class --

module(..., package.seeall)

local Obstacle = require ("obstacle").Obstacle

Tree = Obstacle:new()

function Tree:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
