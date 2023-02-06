import "CoreLibs/graphics"
pd = playdate
gfx = pd.graphics

import "utils"
import "voxel/engine"

--------------
---- VOXEL SPACE CONFIG
--------------

pd.display.setScale(1)

-- TODO Implement the voxel engine
-- MOCK VOXEL ENGINE Creating a sample image to render

-- RENDER THE IMAGE
function pd.update()
	renderFrame()
	--gfx.clear(gfx.kColorWhite)
	--gfx.drawText(pd.getSecondsSinceEpoch(),0,0)
	pd.drawFPS(0,20)
end
