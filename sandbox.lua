-- Tree Class --
module(..., package.seeall)

local Obstacle = require ("obstacle").Obstacle

Sandbox = Obstacle:new()

function Sandbox:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
