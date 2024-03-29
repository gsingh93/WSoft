-- Moving Object Abstract Class

module(..., package.seeall)

local GlobalConstants = require("globalConstants")

MovingObject = {velocity = GlobalConstants.INITIAL_VELOCITY}

function MovingObject:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end
