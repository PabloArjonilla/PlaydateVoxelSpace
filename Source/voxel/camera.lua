local pd <const> = playdate
local gfx <const> = pd.graphics
local geo <const> = pd.geometry

class("Camera").extends()

local location          -- x, y position on the map
local height            -- z position on the map
local horizon = 0       -- offset of the horizon position (looking up-down)
local roll = 0          -- roll offset when rolling the camera
local drawDistance  -- distance of the camera looking forward
local fov      -- TODO: Fix working with radians, check clockwise, check this more/less than 90 camera angle (radians, clockwise)

function Camera:init(xStartPosition, yStartPosition, height, drawDistance, fov)
    self.location = geo.point.new(xLocation, yLocation, height)
    self.height = height
    self.horizon = horizon
    self.horizon = drawDistance
    self.horizon = fov
end