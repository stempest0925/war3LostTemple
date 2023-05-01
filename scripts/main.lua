require 'scripts.lib.init'

_F.FogEnable(false)
_F.FogMaskEnable(false)

_U.toc("UI\\path.toc")
local console = require 'jass.console'
console.enable = true

-- _J.DzFrameHideInterface()
-- _J.DzFrameEditBlackBorders(0, 0)



function fun()
    -- local parent = _U.createFrame('BACKDROP', "Demo_BorderBack").position(0.04, 0.2).show().frameHandle
    -- _U.createFrame('BUTTON', "Demo_Button", parent).position(0.04, 0.2).show()

    local leftItems = {
        [1] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' },
        [2] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' },
        [3] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' },
        [4] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' },
        [5] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' }
    }

    local bagId = 99
    _U.create("BagFrame", bagId).position(0.04, 0.2).show()
    local _parent = _U.find("LeftFrame", bagId).frameHandle
    console.write(bagId, _parent)

    for i, v in ipairs(leftItems) do
        local position = -0.04 * (i - 1)
        console.write(i, v.icon, position)

        _U.createFrame("BACKDROP", "TestItem", _parent).relative(0, position, _parent).img(v.icon).show()
        -- _U.create("TestItem", i).setParents(_parent).relative(0, position, "LeftFrame").img(v.icon).show()
        -- _U.create("TestItem", i).position(0.2, position, _C.FRAME_ALIGN_CENTER).img(v.icon).show()
        -- _J.DzFrameSetParent(now.frameHandle, _parent)
    end
end

fun()
