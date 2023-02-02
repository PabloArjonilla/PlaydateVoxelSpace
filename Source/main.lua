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

-- TODO File reader to substitute the perlin map generator
--[[MOCK FILE READER GENERATING A RANDOM MAP COLOR AND HEIGHTMAP
local mapHeight = 1024
local mapWidth = 1024
local perlinScale = 3
local perlinRepeat = 0
local perlinOctaves = 6
local perlinPersistence = 0.1
local heightMap = MapDataPerlin(mapHeight,mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
local colorMap = MapDataPerlin(mapHeight,mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
]]

-- TODO Implement the voxel engine
-- MOCK VOXEL ENGINE Creating a sample image to render
local mapHeight = 240
local mapWidth = 400
local perlinScale = 10
local perlinRepeat = 0
local perlinOctaves = 6
local perlinPersistence = 0.1

-- RENDER THE IMAGE
playdate.start()


local mapDataPerlin = MapDataPerlin(mapHeight,mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)

local images = {}
images[1] = mapDataPerlin

function pd.update()
	local s,ms = playdate.getSecondsSinceEpoch()
	render(images[1])
	playdate.drawFPS(0,0)
end
