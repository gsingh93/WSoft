-- Bounding Box Class

module(..., package.seeall)

BoundingBox = {}

function BoundingBox:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

-- Checks whether bounding box "box" overlaps with self
function BoundingBox:contains(box)
	if(self.x < box.x and self.x + self.width > box.x) then
		if(self.y < box.y and self.y + self.height > box.y) then
			return true
		end
	end
	
	return false;
end
