import "CoreLibs/graphics"
pd = playdate
gfx = pd.graphics

--import "utils"

--import "voxel/fileReader.lua"
--import "voxel/renderer.lua"
--import "voxel/perlinMap.lua"
--import "voxel/mapData/mapData"
--import "voxel/renderer"
import "voxel/patterns"

--------------
---- VOXEL SPACE CONFIG
--------------
local cameraFOV = 90
local cameraDrawDistance = 400
local pattern = {{16/17,  8/17, 14/17,  6/17},
{ 4/17, 12/17,  2/17, 10/17},
{13/17,  5/17, 15/17,  7/17},
{ 1/17,  9/17,  3/17, 11/17}}

--------------
---- MAP SETUP
--------------
local s,ms
local perlin_x
local perlin_y
local perlin_z

function updateSeeds()
	s,ms = playdate.getSecondsSinceEpoch()
	math.randomseed(ms,s)
	perlin_x = math.random() * 100
	perlin_y = math.random() * 100
	perlin_z = math.random() * 100
end

function generatePerlinMap(mapHeight, mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)

	updateSeeds()

    local values = table.create(mapHeight,0)
    py = perlin_y
    for y = 1, mapHeight, 1 do
	    py += 0.1
        values[y] = table.create(mapWidth,0)
		px = perlin_x
	    for x = 1, mapWidth, 1 do
	        px += 0.1
            values[y][x] = gfx.perlin(px / perlinScale, py / perlinScale, perlin_z / perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
        end
    end

    return values
end

-- TODO delete this, this is a mock dither render. duplicated code from previous method
function drawPerlinMap(mapHeight, mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)

	updateSeeds()

	local patternHeight = #pattern
	local patternWidth = #pattern[1]

    local values = table.create(mapHeight,0)
    py = perlin_y
    for y = 1, mapHeight, 1 do
	    py += 0.1
        values[y] = table.create(mapWidth,0)
		px = perlin_x
	    for x = 1, mapWidth, 1 do
	        px += 0.1
            local p = gfx.perlin(px / perlinScale, py / perlinScale, perlin_z / perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
			
			--print(p .. '' pattern[y%=patternHeight][x%=patternWidth])
			
			if (p > pattern[y%patternHeight+1][x%patternWidth+1]) then
 				gfx.setColor(gfx.kColorWhite)
			else
				gfx.setColor(gfx.kColorBlack)
			end
			gfx.drawPixel(x,y)
		end
    end

    return values
end

-- TODO File reader to substitute the perlin map generator. 
-- TODO Try using 8 bit images.
-- TODO Dont run this here, create a loading bar.
local mapHeight = 512
local mapWidth = 512
local perlinScale = 3
local perlinRepeat = 0
local perlinOctaves = 6
local perlinPersistence = 0.1
--local heightMap = generatePerlinMap(mapHeight,mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
--local colorMap = generatePerlinMap(mapHeight,mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)



-- TODO Implement the voxel engine
-- MOCK VOXEL ENGINE Creating a sample image to render
local mapHeight = 240
local mapWidth = 400
local perlinScale = 10
local perlinRepeat = 0
local perlinOctaves = 6
local perlinPersistence = 0.1

local images = table.create(10,0)

drawPerlinMap(mapHeight, mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)


--for i = 1, 10, 1 do
	--images[i] = generatePerlinMap(mapHeight, mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
	--updateSeeds()
--end
--local map1 = generatePerlinMap(mapHeight, mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)

-- RENDER THE IMAGE

function pd.update()
	
end
