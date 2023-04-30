require 'scripts.lib.init'

_F.FogEnable(false)
_F.FogMaskEnable(false)

_U.toc("UI\\path.toc")

-- _J.DzFrameHideInterface()
-- _J.DzFrameEditBlackBorders(0, 0)

function fun()
    -- local parent = _U.createFrame('BACKDROP', "Demo_BorderBack").position(0.04, 0.2).show().frameHandle
    -- _U.createFrame('BUTTON', "Demo_Button", parent).position(0.04, 0.2).show()
    _U.create("BagFrame").position(0.04, 0.2).show()
end

fun()
