_U = {
    id = 0,
    frameHandle = 0,
    mainUi = _J.DzGetGameUI(),

    mClickEvent = _C.MOUSE_ORDER_CLICK,
    mEnterEvent = _C.MOUSE_ORDER_ENTER,
    mLeaveEvent = _C.MOUSE_ORDER_LEAVE,

    -- 加载toc资源
    toc = function(path)
        _J.DzLoadToc(path)
        return _U
    end,

    -- 创建ui(无法读取子Frame)
    createFrame = function(type, template, parent)
        local parent = parent or _U.mainUi;

        _U.id = _U.id + 1
        local name = "ui" .. _U.id

        _U.frameHandle = _J.DzCreateFrameByTagName(
            type,
            name,
            parent,
            template,
            _U.id
        )
        return _U
    end,

    -- 设置定位
    position = function(x, y, point)
        if (_U.frameHandle > 0) then
            local point = point or _C.FRAME_ALIGN_LEFT_BOTTOM
            _J.DzFrameSetAbsolutePoint(
                _U.frameHandle,
                point,
                x, y
            )
        end
        return _U
    end,

    -- 设置相对定位
    relative = function(x, y, referFrameId, point, referPoint)
        if (_U.frameHandle > 0) then
            local point = point or _C.FRAME_ALIGN_LEFT_TOP
            local referPoint = referPoint or _C.FRAME_ALIGN_LEFT_TOP
            _J.DzFrameSetPoint(_U.frameHandle, point, referFrameId, referPoint, x, y)
        end
        return _U
    end,

    -- 设置宽高
    size = function(w, h)
        if _U.frameHandle > 0 then
            _J.DzFrameSetSize(_U.frameHandle, w, h)
        end
        return _U
    end,

    -- 设置文本
    text = function(text)
        if _U.frameHandle > 0 then
            _J.DzFrameSetText(_U.frameHandle, text)
        end
        return _U
    end,

    -- 设置图片
    img = function(path, flag)
        if _U.frameHandle > 0 then
            -- 0 拉伸  缩放适应
            -- 1 平铺  重复平铺
            local flag = flag or 1
            _J.DzFrameSetTexture(
                _U.frameHandle,
                path,
                flag
            )
        end
        return _U
    end,

    -- 设置父级
    setParents = function(parent)
        if _U.frameHandle > 0 then
            _J.DzFrameSetParent(_U.frameHandle, parent)
        end
        return _U
    end,

    -- 事件注册
    on = function(evt, action, sync)
        if (_U.frameHandle > 0) then
            local sync = sync or false
            _J.DzFrameSetScriptByCode(
                _U.frameHandle,
                evt,
                action,
                sync
            )
        end
        return _U
    end,

    -- 显示
    show = function()
        if _U.frameHandle > 0 then
            _J.DzFrameShow(_U.frameHandle, true)
        end

        return _U
    end,
    -- 隐藏
    hide = function()
        if _U.frameHandle > 0 then
            _J.DzFrameShow(_U.frameHandle, false)
        end

        return _U
    end,

    -- 创建FDF中定义的frame 可以读取子Frame(重点)
    create = function(name, id, parent)
        local parent = parent or _U.mainUi;
        local id = id or _U.id + 1

        print(name, id)

        _U.frameHandle = _J.DzCreateFrame(name, parent, id)
        return _U
    end,

    -- 查找子Frame
    find = function(name, id)
        local frame = _J.DzFrameFindByName(name, id);
        if frame then
            _U.frameHandle = frame
        else
            dump(frame, "_U.find error")
        end

        return _U
    end,
}
