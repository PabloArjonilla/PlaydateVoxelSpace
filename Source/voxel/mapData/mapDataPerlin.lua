import "CoreLibs/object"

class("MapDataPerlin").extends(MapData)

function MapDataPerlin:init(mapHeight, mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
 
    local s,ms = playdate.getSecondsSinceEpoch()
    math.randomseed(ms,s)

    local perlin_x = math.random() * 100
    local perlin_y = math.random() * 100
    local perlin_z = math.random() * 100

    self.values = table.create(mapHeight,0)

    for y = 1, mapHeight, 1 do
        perlin_y += 0.1
        self.values[y] = table.create(mapWidth,0)
        for x = 1, mapWidth, 1 do
            perlin_x += 0.1
            self.values[y][x] = playdate.graphics.perlin(perlin_x / perlinScale, perlin_y / perlinScale, perlin_z / perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)
            
        end
        
    end
end