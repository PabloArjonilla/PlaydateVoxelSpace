pd = playdate

-------------
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

-- TODO File reader to substitute the perlin map generator. 
-- TODO Try using 8 bit images.
-- TODO Dont run this here, create a loading bar.
local mapHeight = 1024
local mapWidth = 1024
local perlinScale = 3
local perlinRepeat = 0
local perlinOctaves = 6
local perlinPersistence = 0.1
local map = generatePerlinMap(mapHeight,mapWidth, perlinScale, perlinRepeat, perlinOctaves, perlinPersistence)


-----------------
---- CAMERA SETUP
-----------------

local cameraX = 512  
local cameraY = 512      -- x, y position on the map
local cameraZ= 70       -- z position on the map
local cameraHorizon = 60    -- offset of the horizon position (looking up-down)
local cameraRoll = 0          -- roll offset when rolling the camera
local cameraDrawDistance = 200 -- distance of the camera looking forward
local cameraFOV = 1.5 * 3.141592   -- TODO: Fix working with radians, check clockwise, check this more/less than 90 camera angle (radians, clockwise)

-----------------
---- ENGINE SETUP
-----------------
local scaleFactor = 70
local pattern = {{8/9, 4/9, 7/9, 3/9},
{2/9, 6/9, 1/9, 5/9},
{7/9, 3/9, 8/9, 4/9},
{1/9, 5/9, 2/9, 6/9}}

local patternHeight = #pattern
local patternWidth = #pattern[1]


function renderFrame ()

    local sinangle = math.sin(cameraFOV)
    local cosangle = math.cos(cameraFOV)

    local plx = cosangle * cameraDrawDistance + sinangle * cameraDrawDistance
    local ply = sinangle * cameraDrawDistance - cosangle * cameraDrawDistance

    local prx = cosangle * cameraDrawDistance - sinangle * cameraDrawDistance
    local pry = sinangle * cameraDrawDistance + cosangle * cameraDrawDistance

    for i = 0, pd.display.getWidth() ,  1 do

        local xDelta = (plx + ((prx - plx) / pd.display.getWidth() * i)) / cameraDrawDistance
        local yDelta = (ply + ((pry - ply) / pd.display.getWidth() * i)) / cameraDrawDistance
  
        local xRay = cameraX
        local yRay = cameraY

        local maxHeight = pd.display.getHeight()
       
        for z = 1, cameraDrawDistance, 1 do
            xRay += xDelta
            yRay += yDelta

            local sampedPixel = map[math.floor(yRay)][math.floor(xRay)]

            local projectedHeight = math.floor((((cameraZ - (sampedPixel*255)) / z * scaleFactor) + cameraHorizon))

            if projectedHeight < 0 then
                projectedHeight = 0
            elseif projectedHeight > pd.display.getHeight() then
                projectedHeight = pd.display.getHeight()
            end            
            
            if projectedHeight < maxHeight then

                for  y = projectedHeight, maxHeight, 1 do
            
                    if y >= 1 then
                       
                       --[[
                        if sampedPixel < pattern[y%patternHeight+1][i%patternWidth+1] then
                            gfx.setColor(gfx.kColorBlack)
                        else
                            gfx.setColor(gfx.kColorWhite)
                        end
                        gfx.drawPixel(i+1,y)
                        ]]
                    end
                end
                maxHeight = projectedHeight
            end
	    end
    end
end

