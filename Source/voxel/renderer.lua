import "CoreLibs/graphics"


local drawSize = 2


-- TODO Rendering patterns for each pixel is TOO slow. create stencils for each pattern.

function render (image)
	gfx.clear(gfx.kColorWhite)
    gfx.setColor(gfx.kColorBlack)
    for y = 0, 239, drawSize do
	    for x = 0, 399, drawSize do
			gfx.setPattern(patterns[math.ceil(image[y+1][x+1] * #patterns)])
	        gfx.fillRect(x, y, drawSize, drawSize)
	    end
    end
end