-- Tree Class --

module(..., package.seeall)

local Obstacle = require ("obstacle").Obstacle

Tree = Obstacle:new()

function Tree:new()
	o = {name = "Tree", imagePath = "images/tree1small.png"}
	setmetatable(o, self)
	self.__index = self
	return o
end
