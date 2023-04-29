_F.FogMaskEnable(false)
_F.FogEnable(false)

function uiDemo3()
    local parent = _J.DzGetGameUI();
    local id = 1;
    local name = "ui" .. id

    local frameHandle = _J.DzCreateFrameByTagName(
        "TEXT",
        name,
        parent,
        "txtDemo",
        id
    )

    local point = _C.FRAME_ALIGN_CENTER
    _J.DzFrameSetAbsolutePoint(
        frameHandle,
        point,
        0.2, 0.2
    )

    _J.DzFrameSetSize(frameHandle, 0.1, 0.1)

    -- _J.DzFrameSetTexture(
    --     frameHandle,
    --     "ReplaceableTextures\\CommandButtons\\BTNOrbOfDarkness.blp", 0
    -- )
    _J.DzFrameSetText(frameHandle, "那实打实打算")

    _J.DzFrameShow(frameHandle, true)
end
