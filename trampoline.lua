-- Trampoline Class --
module(..., package.seeall)

local ObstacleClass = require ("obstacle")

Trampoline = ObstacleClass.Obstacle:new()

function Trampoline:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
