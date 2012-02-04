-- Trampoline Class --
module(..., package.seeall)

local Obstacle = require ("obstacle").Obstacle

Trampoline = Obstacle:new()

function Trampoline:new()
	o = {name = "Trampoline", imagePath = "images/trampolineLOW.png", speedChange = 2}
	setmetatable(o, self)
	self.__index = self
	return o
end
