-- _J.DzFrameHideInterface()
-- _J.DzFrameEditBlackBorders(0, 0)

_U.toc("UI\\path.toc")
local console = require 'jass.console'
console.enable = true


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
    -- console.write(bagId, _parent)

    for i, v in ipairs(leftItems) do
        local position = -0.04 * (i - 1)
        -- console.write(i, v.icon, position)

        _U.createFrame("BACKDROP", "TestItem", _parent).relative(0, position, _parent).img(v.icon).show()
        -- _U.create("TestItem", i).setParents(_parent).relative(0, position, "LeftFrame").img(v.icon).show()
        -- _U.create("TestItem", i).position(0.2, position, _C.FRAME_ALIGN_CENTER).img(v.icon).show()
        -- _J.DzFrameSetParent(now.frameHandle, _parent)
    end
end

function chooseHero()
    local _id = 101
    -- 要在这一步就拿到frameHandle才行
    local _parent = _U.create("CH_Frame", _id).position(0.04, 0.2).show().frameHandle

    local heroList = {
        [1] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' },
        [2] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' },
        [3] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' },
        [4] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' },
        [5] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' },
        [6] = { icon = 'ReplaceableTextures\\CommandButtonsDisabled\\DISBTN3M1.blp' },
    }

    console.write('当前ID', _parent._id)

    -- 一行6个，一个0.032，边距0.0125
    for i, v in ipairs(heroList) do
        local x = i == 1 and 0.0125 or (0.0125 * i + 0.032 * (i - 1));
        local y = 0;
        console.write(x, y)
        -- 之前为什么会无法成功呢？因为在下面使用_parent，指针已经变了，可以打印以下id看下，ID已经丢失了。
        console.write('当前ID', _parent._id)
        _U.createFrame("BACKDROP", "CH_Hero", _parent).relative(x, y, _parent).img(v.icon)
            .show()
    end
end

-- fun()
