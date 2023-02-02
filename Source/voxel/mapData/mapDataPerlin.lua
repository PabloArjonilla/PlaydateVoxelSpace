import "CoreLibs/object"

class("MapDataPerlin").extends(MapData)

local s,ms = playdate.getSecondsSinceEpoch()
math.randomseed(ms,s)

local perlin_x = math.random() * 100
local perlin_y = math.random() * 100
local perlin_z = math.random() * 100


function MapDataPerlin:init(mapHeight, mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
    
    local py = perlin_y
    self.values = {}
    for y = 1, mapHeight, 1 do

	    local px = perlin_x
	    py += 0.1
        self.values [y] = {}
	    for x = 1, mapWidth, 1 do
	        px += 0.1
            self.values[y][x] = gfx.perlin(px / perlinScale, py / perlinScale, perlin_z / perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
        end
    end
end
