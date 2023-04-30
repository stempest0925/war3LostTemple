require 'scripts.lib.init'

_F.FogEnable(false)
_F.FogMaskEnable(false)

_U.toc("UI\\path.toc")
function fun()
    _U.createFrame('TEXT', "txtDemo").position(0.2, 0.2).show()
end

fun()
-- _J.DzFrameHideInterface()
-- _J.DzFrameEditBlackBorders(0, 0)

-- function fun2()
--     local handle = _J.DzCreateFrameByTagName("BACKDROP", 'UI1', _J.DzGetGameUI(), "Demo_SizeBack", 1)
--     _J.DzFrameSetAbsolutePoint(handle, _C.FRAME_ALIGN_CENTER, 0.1, 0.1)
--     -- _J.DzFrameSetSize(handle, 0.1, 0.1)
--     -- _J.DzFrameSetText(handle, "那实打实打算")
--     _J.DzFrameShow(handle, true)
-- end
-- fun2()
