import "CoreLibs/object"

class("MapData").extends()

local values

function MapData:init(imageHeight, imageWidth)
    self.values = table.create(imageHeight,0)
    for y = 1, imageHeight, 1 do
        self.values[y] = table.create(imageWidth,0)
    end
end



--[[
local screenShot = {}
for y = 1, 240, 1 do
    local percentage = y * 100 / 240
    screenShot[y] = {}
    for x = 1, 400, 1 do
        screenShot[y][x] = percentage / 100
    end
end
]]