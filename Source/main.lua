import "CoreLibs/graphics"
pd = playdate
gfx = pd.graphics

import "utils"

--import "voxel/fileReader.lua"
-- import "voxel/renderer.lua"
--import "voxel/perlinMap.lua"
--import "voxel/mapData/mapData"
import "voxel/mapData/mapDataPerlin"
import "voxel/renderer"

-- Generating a 1024 x 1024 perlin map
local mapHeight = 1024
local mapWidth = 1024
local perlinScale = 3
local perlinRepeat = 0
local perlinOctaves = 6
local perlinPersistence = 0.1

--local heightMap = MapDataPerlin(mapHeight,mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
--local colorMap = MapDataPerlin(mapHeight,mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)

local mapHeight = 240
local mapWidth = 400
local perlinScale = 3
local perlinRepeat = 0
local perlinOctaves = 6
local perlinPersistence = 0.1

local mockImage = MapDataPerlin(mapHeight,mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
render(mockImage)
pd.stop()

if playdate.update == nil then
	playdate.update = function() end
	playdate.graphics.drawText("Please uncomment one of the import statements.", 15, 100)
end
