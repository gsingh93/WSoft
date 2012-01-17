-- Trampoline Class --
module(..., package.seeall)

local Obstacle = require ("obstacle").Obstacle

Trampoline = Obstacle:new()

function Trampoline:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
