JassJapi = require "jass.japi"

---@class _J JAPI
_J = {
    _lib = nil,
    _tips = {},
    _formatter = require "scripts.lib.japi.formatter",
    _triumph = require "scripts.lib.japi.triumph",
}

---@type table<string,any>
_J._cache = _J._cache or {
    ["DzLoadToc"] = {},
    ["GetZ"] = {},
}

---@private
_J.echo = function(msg)
    if (_J._tips[msg] == nil) then
        _J._tips[msg] = 1
        if (DEBUGGING) then
            print("<JAPI> " .. msg)
        else
            echo("<JAPI> " .. msg)
        end
    end
end

---@private
---@param method string
---@return boolean
_J.has = function(method)
    if (type(method) ~= 'string') then
        return false
    end
    if (type(JassJapi[method]) == "function") then
        return true
    end
    return false
end

---@private
---@param method string
---@param params table|nil
_J.formatter = function(method, params)
    if (type(params) == "table" and type(_J._formatter[method]) == 'function') then
        _J._formatter[method](params)
    end
end

---@private
---@param method string
---@param params table|nil
_J.triumph = function(method, params, result)
    if (type(_J._triumph[method]) == 'function') then
        return _J._triumph[method](params, result)
    end
    return result
end

---@private
---@param method string
---@param params table|nil
---@return any
_J.exec = function(method, params)
    if (type(method) ~= 'string') then
        return false
    end
    if (type(JassJapi[method]) ~= "function") then
        _J.echo(method .. " function does not exist!")
        return false
    end
    _J.formatter(method, params)
    if (params == nil) then
        res = JassJapi[method]()
    else
        res = JassJapi[method](table.unpack(params))
    end
    return _J.triumph(method, params, res)
end

------------------------------------------------------------------------------------------------------------------------

_J.DzAPI_CommonFunc_GetARGBColorValue = function(...)
    return _J.exec("DzAPI_CommonFunc_GetARGBColorValue", { ... })
end

_J.DzAPI_CommonFunc_GetARGBColorValuePercent = function(...)
    return _J.exec("DzAPI_CommonFunc_GetARGBColorValuePercent", { ... })
end

_J.DzAPI_CommonFunc_SetARGBColorValue = function(...)
    return _J.exec("DzAPI_CommonFunc_SetARGBColorValue", { ... })
end

_J.DzAPI_CommonFunc_SetARGBColorValuePercent = function(...)
    return _J.exec("DzAPI_CommonFunc_SetARGBColorValuePercent", { ... })
end

_J.DzAPI_Map_ChangeStoreItemCoolDown = function(...)
    return _J.exec("DzAPI_Map_ChangeStoreItemCoolDown", { ... })
end

_J.DzAPI_Map_ChangeStoreItemCount = function(...)
    return _J.exec("DzAPI_Map_ChangeStoreItemCount", { ... })
end

---@return string
_J.DzAPI_Map_GetActivityData = function()
    return _J.exec("DzAPI_Map_GetActivityData", nil)
end

--- 获取当前游戏时间
--- 获取创建地图的游戏时间
--- 时间换算为时间戳
---@return number
_J.DzAPI_Map_GetGameStartTime = function()
    return _J.exec("DzAPI_Map_GetGameStartTime", nil)
end

--- 获取公会名称
---@param whichPlayer userdata
---@return string
_J.DzAPI_Map_GetGuildName = function(whichPlayer)
    return _J.exec("DzAPI_Map_GetGuildName", { whichPlayer })
end

--- 获取公会职责
--- 获取公会职责 Member=10 Admin=20 Leader=30
---@param whichPlayer userdata
---@return number
_J.DzAPI_Map_GetGuildRole = function(whichPlayer)
    return _J.exec("DzAPI_Map_GetGuildRole", { whichPlayer })
end

--- 获取天梯等级
--- 取值1~25，青铜V是1级
---@param whichPlayer userdata
---@return number
_J.DzAPI_Map_GetLadderLevel = function(whichPlayer)
    return _J.exec("DzAPI_Map_GetLadderLevel", { whichPlayer })
end

--- 获取天梯排名
--- 排名>1000的获取值为0
---@param whichPlayer userdata
---@return number
_J.DzAPI_Map_GetLadderRank = function(whichPlayer)
    return _J.exec("DzAPI_Map_GetLadderRank", { whichPlayer })
end

--- 获取全局服务器存档值
---@param key string
---@return number
_J.DzAPI_Map_GetMapConfig = function(key)
    return _J.exec("DzAPI_Map_GetMapConfig", { key })
end

--- 获取玩家地图等级
--- 获取玩家地图等级【RPG大厅限定】
---@param whichPlayer userdata
---@return number
_J.DzAPI_Map_GetMapLevel = function(whichPlayer)
    return _J.exec("DzAPI_Map_GetMapLevel", { whichPlayer })
end

--- 获取玩家地图等级排名
--- 排名>100的获取值为0
---@param whichPlayer userdata
---@return number
_J.DzAPI_Map_GetMapLevelRank = function(whichPlayer)
    return _J.exec("DzAPI_Map_GetMapLevelRank", { whichPlayer })
end

--- 获取天梯和匹配的模式
--- 返回数值与作者之家设置对应
_J.DzAPI_Map_GetMatchType = function()
    return _J.exec("DzAPI_Map_GetMatchType", nil)
end

--- 获取玩家平台VIP标志
---@param whichPlayer userdata
---@return number
_J.DzAPI_Map_GetPlatformVIP = function(whichPlayer)
    return _J.exec("DzAPI_Map_GetPlatformVIP", { whichPlayer })
end

--- 玩家是否平台VIP
---@param whichPlayer userdata
---@return boolean
_J.DzAPI_Map_IsPlatformVIP = function(whichPlayer)
    local res = _J.DzAPI_Map_GetPlatformVIP(whichPlayer)
    if (type(res) == "number") then
        return math.floor(res) > 0
    end
    return false
end

--- 读取公共服务器存档组数据
--- 服务器存档组有100个KEY，每个KEY64个字符长度，可以多张地图读取和保存，使用前先在作者之家服务器存档组设置
---@param whichPlayer userdata
---@param key string
---@return string
_J.DzAPI_Map_GetPublicArchive = function(whichPlayer, key)
    return _J.exec("DzAPI_Map_GetPublicArchive", { whichPlayer, key })
end

--- 读取服务器Boss掉落装备类型
---@param whichPlayer userdata
---@param key string
---@return string
_J.DzAPI_Map_GetServerArchiveDrop = function(whichPlayer, key)
    return _J.exec("DzAPI_Map_GetServerArchiveDrop", { whichPlayer, key })
end

---@param whichPlayer userdata
---@param key string
---@return number
_J.DzAPI_Map_GetServerArchiveEquip = function(whichPlayer, key)
    return _J.exec("DzAPI_Map_GetServerArchiveEquip", { whichPlayer, key })
end

---@param whichPlayer userdata
---@param key string
---@return string
_J.DzAPI_Map_GetServerValue = function(whichPlayer, key)
    return _J.exec("DzAPI_Map_GetServerValue", { whichPlayer, key })
end

---@param whichPlayer userdata
---@return number
_J.DzAPI_Map_GetServerValueErrorCode = function(whichPlayer)
    return _J.exec("DzAPI_Map_GetServerValueErrorCode", { whichPlayer })
end

--- 读取玩家服务器存档成功
--- 如果返回false代表读取失败,反之成功,之后游戏里平台不会再发送“服务器保存失败”的信息，所以希望地图作者在游戏开始给玩家发下信息服务器存档是否正确读取。
---@param whichPlayer userdata
---@return boolean
_J.GetPlayerServerValueSuccess = function(whichPlayer)
    local res = _J.DzAPI_Map_GetServerValueErrorCode(whichPlayer)
    if (type(res) == "number") then
        return math.floor(res) == 0
    end
    return false
end

_J.DzAPI_Map_GetUserID = function(...)
    return _J.exec("DzAPI_Map_GetUserID", { ... })
end

--- 玩家是否拥有该商城道具（平台地图商城）
--- 平台地图商城玩家拥有该道具返还true
---@param whichPlayer userdata
---@param key string
---@return boolean
_J.DzAPI_Map_HasMallItem = function(whichPlayer, key)
    return _J.exec("DzAPI_Map_HasMallItem", { whichPlayer, key })
end

--- 判断是否是蓝V
---@param whichPlayer userdata
---@return boolean
_J.DzAPI_Map_IsBlueVIP = function(whichPlayer)
    return _J.exec("DzAPI_Map_IsBlueVIP", { whichPlayer })
end

--- 判断地图是否在RPG天梯
---@return boolean
_J.DzAPI_Map_IsRPGLadder = function()
    return _J.exec("DzAPI_Map_IsRPGLadder", nil)
end

--- 判断当前地图是否rpg大厅来的
---@return boolean
_J.DzAPI_Map_IsRPGLobby = function()
    return _J.exec("DzAPI_Map_IsRPGLobby", nil)
end

--- 判断是否是红V
---@param whichPlayer userdata
---@return boolean
_J.DzAPI_Map_IsRedVIP = function(whichPlayer)
    return _J.exec("DzAPI_Map_IsRedVIP", { whichPlayer })
end

---@param whichPlayer userdata
---@param key string
---@param value string
_J.DzAPI_Map_Ladder_SetPlayerStat = function(whichPlayer, key, value)
    return _J.exec("DzAPI_Map_Ladder_SetPlayerStat", { whichPlayer, key, value })
end

--- 天梯提交玩家排名
---@param whichPlayer userdata
---@param value number
_J.DzAPI_Map_Ladder_SubmitPlayerRank = function(whichPlayer, value)
    return _J.DzAPI_Map_Ladder_SetPlayerStat(whichPlayer, "RankIndex", math.floor(value))
end

--- 天梯提交字符串数据
---@param whichPlayer userdata
---@param key string
---@param value string
_J.DzAPI_Map_Ladder_SetStat = function(whichPlayer, key, value)
    return _J.exec("DzAPI_Map_Ladder_SetStat", { whichPlayer, key, value })
end

--- 天梯提交获得称号
---@param whichPlayer userdata
---@param value string
_J.DzAPI_Map_Ladder_SubmitTitle = function(whichPlayer, value)
    return _J.DzAPI_Map_Ladder_SetStat(whichPlayer, value, "1")
end

--- 设置玩家额外分
---@param whichPlayer userdata
---@param value string
_J.DzAPI_Map_Ladder_SubmitPlayerExtraExp = function(whichPlayer, value)
    return _J.DzAPI_Map_Ladder_SetStat(whichPlayer, "ExtraExp", math.floor(value))
end

--- 活动完成
--- 完成平台活动[RPG大厅限定]
---@param whichPlayer userdata
---@param key string
---@param value string
_J.DzAPI_Map_MissionComplete = function(whichPlayer, key, value)
    return _J.exec("DzAPI_Map_MissionComplete", { whichPlayer, key, value })
end

--- 触发boss击杀
---@param whichPlayer userdata
---@param key string
_J.DzAPI_Map_OrpgTrigger = function(whichPlayer, key)
    return _J.exec("DzAPI_Map_OrpgTrigger", { whichPlayer, key })
end

--- 服务器公共存档组保存
--- 存储服务器存档组，服务器存档组有100个KEY，每个KEY64个字符串长度，使用前请在作者之家服务器存档组进行设置
---@param whichPlayer userdata
---@param key string
---@param value string
_J.DzAPI_Map_SavePublicArchive = function(whichPlayer, key, value)
    return _J.exec("DzAPI_Map_SavePublicArchive", { whichPlayer, key, value })
end

--- 保存服务器存档
---@param whichPlayer userdata
---@param key string
---@param value string
_J.DzAPI_Map_SaveServerValue = function(whichPlayer, key, value)
    return _J.exec("DzAPI_Map_SaveServerValue", { whichPlayer, key, value })
end

--- 设置房间显示的数据
--- 为服务器存档显示的数据，对应作者之家的房间key
---@param whichPlayer userdata
---@param key string
---@param value string
_J.DzAPI_Map_Stat_SetStat = function(whichPlayer, key, value)
    return _J.exec("DzAPI_Map_Stat_SetStat", { whichPlayer, key, value })
end

--- 平台统计
--- 一般用于统计游戏里某些事件的触发次数，可在作者之家查看。【第二个子key是以后备用暂时不要填】
---@param whichPlayer userdata
---@param eventKey string
---@param eventType string
---@param value number integer
_J.DzAPI_Map_Statistics = function(whichPlayer, eventKey, eventType, value)
    return _J.exec("DzAPI_Map_Statistics", { whichPlayer, eventKey, eventType, value })
end

_J.DzAPI_Map_ToggleStore = function(...)
    return _J.exec("DzAPI_Map_ToggleStore", { ... })
end

_J.DzAPI_Map_UpdatePlayerHero = function(...)
    return _J.exec("DzAPI_Map_UpdatePlayerHero", { ... })
end

--- 局数消耗商品调用
--- 仅对局数消耗型商品有效
---@param whichPlayer userdata
---@param key string
_J.DzAPI_Map_UseConsumablesItem = function(whichPlayer, key)
    return _J.exec("DzAPI_Map_UseConsumablesItem", { whichPlayer, key })
end

_J.DzAPI_UnitType_CountUnitTypeDataArrayAbilID = function(...)
    return _J.exec("DzAPI_UnitType_CountUnitTypeDataArrayAbilID", { ... })
end

_J.DzAPI_UnitType_CountUnitTypeDataArrayBoolean = function(...)
    return _J.exec("DzAPI_UnitType_CountUnitTypeDataArrayBoolean", { ... })
end

_J.DzAPI_UnitType_CountUnitTypeDataArrayItemID = function(...)
    return _J.exec("DzAPI_UnitType_CountUnitTypeDataArrayItemID", { ... })
end

_J.DzAPI_UnitType_CountUnitTypeDataArrayReal = function(...)
    return _J.exec("DzAPI_UnitType_CountUnitTypeDataArrayReal", { ... })
end

_J.DzAPI_UnitType_CountUnitTypeDataArrayString = function(...)
    return _J.exec("DzAPI_UnitType_CountUnitTypeDataArrayString", { ... })
end

_J.DzAPI_UnitType_CountUnitTypeDataArrayTechID = function(...)
    return _J.exec("DzAPI_UnitType_CountUnitTypeDataArrayTechID", { ... })
end

_J.DzAPI_UnitType_CountUnitTypeDataArrayUnitID = function(...)
    return _J.exec("DzAPI_UnitType_CountUnitTypeDataArrayUnitID", { ... })
end

_J.DzAPI_UnitType_CountUnitTypeDataRequires = function(...)
    return _J.exec("DzAPI_UnitType_CountUnitTypeDataRequires", { ... })
end

_J.DzAPI_UnitType_CountUnitTypeDataRequiresamount = function(...)
    return _J.exec("DzAPI_UnitType_CountUnitTypeDataRequiresamount", { ... })
end

_J.DzAPI_UnitType_GetEnum_PreventOrReguirePlace = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_PreventOrReguirePlace", { ... })
end

_J.DzAPI_UnitType_GetEnum_PreventOrReguirePlaceCheck = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_PreventOrReguirePlaceCheck", { ... })
end

_J.DzAPI_UnitType_GetEnum_Primary = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_Primary", { ... })
end

_J.DzAPI_UnitType_GetEnum_TargetTypeCheck = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_TargetTypeCheck", { ... })
end

_J.DzAPI_UnitType_GetEnum_TargetTypeSeries = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_TargetTypeSeries", { ... })
end

_J.DzAPI_UnitType_GetEnum_armor = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_armor", { ... })
end

_J.DzAPI_UnitType_GetEnum_atkType = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_atkType", { ... })
end

_J.DzAPI_UnitType_GetEnum_buffType = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_buffType", { ... })
end

_J.DzAPI_UnitType_GetEnum_deathType = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_deathType", { ... })
end

_J.DzAPI_UnitType_GetEnum_defType = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_defType", { ... })
end

_J.DzAPI_UnitType_GetEnum_movetp = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_movetp", { ... })
end

_J.DzAPI_UnitType_GetEnum_race = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_race", { ... })
end

_J.DzAPI_UnitType_GetEnum_regenType = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_regenType", { ... })
end

_J.DzAPI_UnitType_GetEnum_type = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_type", { ... })
end

_J.DzAPI_UnitType_GetEnum_typeCheck = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_typeCheck", { ... })
end

_J.DzAPI_UnitType_GetEnum_warpsOn = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_warpsOn", { ... })
end

_J.DzAPI_UnitType_GetEnum_weapTp = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_weapTp", { ... })
end

_J.DzAPI_UnitType_GetEnum_weapType = function(...)
    return _J.exec("DzAPI_UnitType_GetEnum_weapType", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataAbilID = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataAbilID", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataArrayAbilID = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataArrayAbilID", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataArrayBoolean = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataArrayBoolean", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataArrayItemID = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataArrayItemID", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataArrayReal = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataArrayReal", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataArrayString = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataArrayString", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataArrayTechID = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataArrayTechID", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataArrayUnitID = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataArrayUnitID", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataBoolean = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataBoolean", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataInt = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataInt", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataReal = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataReal", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataRequires = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataRequires", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataRequiresamount = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataRequiresamount", { ... })
end

_J.DzAPI_UnitType_GetUnitTypeDataString = function(...)
    return _J.exec("DzAPI_UnitType_GetUnitTypeDataString", { ... })
end

_J.DzAPI_UnitType_GettUnitTypeDataRequirescount = function(...)
    return _J.exec("DzAPI_UnitType_GettUnitTypeDataRequirescount", { ... })
end

_J.DzAPI_UnitType_ResizeUnitTypeDataArrayAbilID = function(...)
    return _J.exec("DzAPI_UnitType_ResizeUnitTypeDataArrayAbilID", { ... })
end

_J.DzAPI_UnitType_ResizeUnitTypeDataArrayBoolean = function(...)
    return _J.exec("DzAPI_UnitType_ResizeUnitTypeDataArrayBoolean", { ... })
end

_J.DzAPI_UnitType_ResizeUnitTypeDataArrayItemID = function(...)
    return _J.exec("DzAPI_UnitType_ResizeUnitTypeDataArrayItemID", { ... })
end

_J.DzAPI_UnitType_ResizeUnitTypeDataArrayReal = function(...)
    return _J.exec("DzAPI_UnitType_ResizeUnitTypeDataArrayReal", { ... })
end

_J.DzAPI_UnitType_ResizeUnitTypeDataArrayString = function(...)
    return _J.exec("DzAPI_UnitType_ResizeUnitTypeDataArrayString", { ... })
end

_J.DzAPI_UnitType_ResizeUnitTypeDataArrayTechID = function(...)
    return _J.exec("DzAPI_UnitType_ResizeUnitTypeDataArrayTechID", { ... })
end

_J.DzAPI_UnitType_ResizeUnitTypeDataArrayUnitID = function(...)
    return _J.exec("DzAPI_UnitType_ResizeUnitTypeDataArrayUnitID", { ... })
end

_J.DzAPI_UnitType_ResizeUnitTypeDataRequires = function(...)
    return _J.exec("DzAPI_UnitType_ResizeUnitTypeDataRequires", { ... })
end

_J.DzAPI_UnitType_ResizeUnitTypeDataRequiresamount = function(...)
    return _J.exec("DzAPI_UnitType_ResizeUnitTypeDataRequiresamount", { ... })
end

_J.DzAPI_UnitType_SetEnum_PreventOrReguirePlace = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_PreventOrReguirePlace", { ... })
end

_J.DzAPI_UnitType_SetEnum_PreventOrReguirePlaceModify = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_PreventOrReguirePlaceModify", { ... })
end

_J.DzAPI_UnitType_SetEnum_Primary = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_Primary", { ... })
end

_J.DzAPI_UnitType_SetEnum_TargetTypeModify = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_TargetTypeModify", { ... })
end

_J.DzAPI_UnitType_SetEnum_TargetTypeSeries = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_TargetTypeSeries", { ... })
end

_J.DzAPI_UnitType_SetEnum_armor = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_armor", { ... })
end

_J.DzAPI_UnitType_SetEnum_atkType = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_atkType", { ... })
end

_J.DzAPI_UnitType_SetEnum_buffType = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_buffType", { ... })
end

_J.DzAPI_UnitType_SetEnum_deathType = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_deathType", { ... })
end

_J.DzAPI_UnitType_SetEnum_defType = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_defType", { ... })
end

_J.DzAPI_UnitType_SetEnum_movetp = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_movetp", { ... })
end

_J.DzAPI_UnitType_SetEnum_race = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_race", { ... })
end

_J.DzAPI_UnitType_SetEnum_regenType = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_regenType", { ... })
end

_J.DzAPI_UnitType_SetEnum_type = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_type", { ... })
end

_J.DzAPI_UnitType_SetEnum_typeModify = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_typeModify", { ... })
end

_J.DzAPI_UnitType_SetEnum_warpsOn = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_warpsOn", { ... })
end

_J.DzAPI_UnitType_SetEnum_weapTp = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_weapTp", { ... })
end

_J.DzAPI_UnitType_SetEnum_weapType = function(...)
    return _J.exec("DzAPI_UnitType_SetEnum_weapType", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataAbilID = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataAbilID", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataArrayAbilID = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataArrayAbilID", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataArrayBoolean = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataArrayBoolean", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataArrayItemID = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataArrayItemID", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataArrayReal = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataArrayReal", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataArrayString = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataArrayString", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataArrayTechID = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataArrayTechID", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataArrayUnitID = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataArrayUnitID", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataBoolean = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataBoolean", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataInt = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataInt", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataReal = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataReal", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataRequires = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataRequires", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataRequiresamount = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataRequiresamount", { ... })
end

_J.DzAPI_UnitType_SetUnitTypeDataString = function(...)
    return _J.exec("DzAPI_UnitType_SetUnitTypeDataString", { ... })
end

_J.DzAPI_UnitstateToInteger = function(...)
    return _J.exec("DzAPI_UnitstateToInteger", { ... })
end

--- 触发点击frame
---@param frameId number integer
_J.DzClickFrame = function(frameId)
    return _J.exec("DzClickFrame", { frameId })
end

_J.DzConvertWorldPosition = function(...)
    return _J.exec("DzConvertWorldPosition", { ... })
end

--- 新建Frame
--- 名字为fdf文件中的名字，ID默认填0。重复创建同名Frame会导致游戏退出时显示崩溃消息，如需避免可以使用Tag创建
---@param frame string
---@param parent number integer
---@param id number integer
---@return number integer
_J.DzCreateFrame = function(frame, parent, id)
    return _J.exec("DzCreateFrame", { frame, parent, id })
end

--- 新建Frame[Tag]
--- 此处名字可以自定义，类型和模版填写fdf文件中的内容。通过此函数创建的Frame无法获取到子Frame
---@param frameType string
---@param name string
---@param parent number integer
---@param template string
---@param id number integer
---@return number integer
_J.DzCreateFrameByTagName = function(frameType, name, parent, template, id)
    return _J.exec("DzCreateFrameByTagName", { frameType, name, parent, template, id })
end

---@param frame string
---@param parent number integer
---@param id number integer
---@return number integer
_J.DzCreateSimpleFrame = function(frame, parent, id)
    return _J.exec("DzCreateSimpleFrame", { frame, parent, id })
end

_J.DzDebugString = function(...)
    return _J.exec("DzDebugString", { ... })
end

--- 销毁
--- 销毁一个被重复创建过的Frame会导致游戏崩溃，重复创建同名Frame请使用Tag创建
---@param frameId number integer
_J.DzDestroyFrame = function(frameId)
    return _J.exec("DzDestroyFrame", { frameId })
end

--- 设置可破坏物位置
---@param d userdata destructable
---@param x number floor(2)
---@param y number floor(2)
_J.DzDestructablePosition = function(d, x, y)
    return _J.exec("DzDestructablePosition", { d, x, y })
end

_J.DzDotaInfo_IsPlayerRandom = function(...)
    return _J.exec("DzDotaInfo_IsPlayerRandom", { ... })
end

_J.DzDotaInfo_IsRepicked = function(...)
    return _J.exec("DzDotaInfo_IsRepicked", { ... })
end

_J.DzDotaInfo_Item = function(...)
    return _J.exec("DzDotaInfo_Item", { ... })
end

_J.DzDotaInfo_Item_HE = function(...)
    return _J.exec("DzDotaInfo_Item_HE", { ... })
end

_J.DzDotaInfo_Item_TM = function(...)
    return _J.exec("DzDotaInfo_Item_TM", { ... })
end

--- 原生 - 使用宽屏模式
---@param enable boolean
_J.DzEnableWideScreen = function(enable)
    return _J.exec("DzEnableWideScreen", { enable })
end

_J.DzEvent_Building_Cancel = function(...)
    return _J.exec("DzEvent_Building_Cancel", { ... })
end

_J.DzEvent_Building_Dead = function(...)
    return _J.exec("DzEvent_Building_Dead", { ... })
end

_J.DzEvent_Building_Finish = function(...)
    return _J.exec("DzEvent_Building_Finish", { ... })
end

_J.DzEvent_Building_Start = function(...)
    return _J.exec("DzEvent_Building_Start", { ... })
end

_J.DzEvent_Hero_Dead = function(...)
    return _J.exec("DzEvent_Hero_Dead", { ... })
end

_J.DzEvent_Hero_Level = function(...)
    return _J.exec("DzEvent_Hero_Level", { ... })
end

_J.DzEvent_Item_Drop = function(...)
    return _J.exec("DzEvent_Item_Drop", { ... })
end

_J.DzEvent_Item_Pickup = function(...)
    return _J.exec("DzEvent_Item_Pickup", { ... })
end

_J.DzEvent_Item_Sell = function(...)
    return _J.exec("DzEvent_Item_Sell", { ... })
end

_J.DzEvent_Item_Use = function(...)
    return _J.exec("DzEvent_Item_Use", { ... })
end

_J.DzEvent_Tech_Cancel = function(...)
    return _J.exec("DzEvent_Tech_Cancel", { ... })
end

_J.DzEvent_Tech_Finish = function(...)
    return _J.exec("DzEvent_Tech_Finish", { ... })
end

_J.DzEvent_Tech_Start = function(...)
    return _J.exec("DzEvent_Tech_Start", { ... })
end

_J.DzEvent_Unit_Cancel = function(...)
    return _J.exec("DzEvent_Unit_Cancel", { ... })
end

_J.DzEvent_Unit_ChangeOwner = function(...)
    return _J.exec("DzEvent_Unit_ChangeOwner", { ... })
end

_J.DzEvent_Unit_Dead = function(...)
    return _J.exec("DzEvent_Unit_Dead", { ... })
end

_J.DzEvent_Unit_Finish = function(...)
    return _J.exec("DzEvent_Unit_Finish", { ... })
end

_J.DzEvent_Unit_Hired = function(...)
    return _J.exec("DzEvent_Unit_Hired", { ... })
end

_J.DzEvent_Unit_Start = function(...)
    return _J.exec("DzEvent_Unit_Start", { ... })
end

--- 异步执行函数
---@param funcName string
_J.DzExecuteFunc = function(funcName)
    return _J.exec("DzExecuteFunc", { funcName })
end

--- 限制鼠标移动，在frame内
---@param frame number integer
---@param enable boolean
_J.DzFrameCageMouse = function(frame, enable)
    return _J.exec("DzFrameCageMouse", { frame, enable })
end

--- 清空frame所有锚点
---@param frame number integer
_J.DzFrameClearAllPoints = function(frame)
    return _J.exec("DzFrameClearAllPoints", { frame })
end

--- 修改游戏渲染黑边: 上方高度:upperHeight,下方高度:bottomHeight
---@param upperHeight number floor(3)
---@param bottomHeight number floor(3)
_J.DzFrameEditBlackBorders = function(upperHeight, bottomHeight)
    return _J.exec("DzFrameEditBlackBorders", { upperHeight, bottomHeight })
end

--- 获取名字为name的子FrameID:Id"
--- ID默认填0，同名时优先获取最后被创建的。非Simple类的Frame类型都用此函数来获取子Frame
---@param name string
---@param id number integer
---@return number integer
_J.DzFrameFindByName = function(name, id)
    return _J.exec("DzFrameFindByName", { name, id })
end

--- 获取Frame的透明度(0-255)
---@param frame number integer
---@return number integer
_J.DzFrameGetAlpha = function(frame)
    return _J.exec("DzFrameGetAlpha", { frame })
end

--- 原生 - 玩家聊天信息框
---@return number integer
_J.DzFrameGetChatMessage = function()
    return _J.exec("DzFrameGetChatMessage", nil)
end

--- 原生 - 技能按钮
--- 技能按钮:(row, column)
--- 参考物编中的技能按钮(x,y)坐标
--- (x,y)对应(column,row)反一下
---@param row number integer
---@param column number integer
---@return number integer
_J.DzFrameGetCommandBarButton = function(row, column)
    return _J.exec("DzFrameGetCommandBarButton", { row, column })
end

--- frame控件是否启用
---@param frame number integer
---@return boolean
_J.DzFrameGetEnable = function(frame)
    return _J.exec("DzFrameGetEnable", { frame })
end

--- 获取Frame的高度
---@param frame number integer
---@return number floor
_J.DzFrameGetHeight = function(frame)
    return _J.exec("DzFrameGetHeight", { frame })
end

--- 原生 - 英雄按钮
--- 左侧的英雄头像，参数表示第N+1个英雄，索引从0开始
---@param buttonId number integer
---@return number integer
_J.DzFrameGetHeroBarButton = function(buttonId)
    return _J.exec("DzFrameGetHeroBarButton", { buttonId })
end

--- 原生 - 英雄血条
--- 左侧的英雄头像下的血条，参数表示第N+1个英雄，索引从0开始
---@param buttonId number integer
---@return number integer
_J.DzFrameGetHeroHPBar = function(buttonId)
    return _J.exec("DzFrameGetHeroHPBar", { buttonId })
end

--- 原生 - 英雄蓝条
--- 左侧的英雄头像下的蓝条，参数表示第N+1个英雄，索引从0开始
---@param buttonId number integer
---@return number integer
_J.DzFrameGetHeroManaBar = function(buttonId)
    return _J.exec("DzFrameGetHeroManaBar", { buttonId })
end

--- 原生 - 物品栏按钮
--- 索引从0开始
---@param buttonId number integer
---@return number integer
_J.DzFrameGetItemBarButton = function(buttonId)
    return _J.exec("DzFrameGetItemBarButton", { buttonId })
end

--- 原生 - 小地图
---@return number integer
_J.DzFrameGetMinimap = function()
    return _J.exec("DzFrameGetMinimap", nil)
end

--- 原生 - 小地图按钮
--- 小地图右侧竖排按钮，索引从0开始
---@param buttonId number integer
---@return number integer
_J.DzFrameGetMinimapButton = function(buttonId)
    return _J.exec("DzFrameGetMinimapButton", { buttonId })
end

--- 获取 Frame 的名称
---@param frame number integer
---@return string
_J.DzFrameGetName = function(frame)
    return _J.exec("DzFrameGetName", { frame })
end

--- 获取 Frame 的 Parent
---@param frame number integer
---@return number integer
_J.DzFrameGetParent = function(frame)
    return _J.exec("DzFrameGetParent", { frame })
end

--- 原生 - 单位大头像
--- 小地图右侧的大头像
---@return number integer
_J.DzFrameGetPortrait = function()
    return _J.exec("DzFrameGetPortrait", nil)
end

--- 获取 Frame 内的文字
--- 支持EditBox, TextFrame, TextArea, SimpleFontString
---@param frame number integer
---@return string
_J.DzFrameGetText = function(frame)
    return _J.exec("DzFrameGetText", { frame })
end

--- 获取 Frame 的字数限制
--- 支持EditBox
---@param frame number integer
---@return number integer
_J.DzFrameGetTextSizeLimit = function(frame)
    return _J.exec("DzFrameGetTextSizeLimit", { frame })
end

--- 原生 - 鼠标提示
--- 鼠标移动到物品或技能按钮上显示的提示窗，初始位于技能栏上方
---@return number integer
_J.DzFrameGetTooltip = function()
    return _J.exec("DzFrameGetTooltip", nil)
end

--- 原生 - 上方消息框
--- 高维修费用 等消息
---@return number integer
_J.DzFrameGetTopMessage = function()
    return _J.exec("DzFrameGetTopMessage", nil)
end

--- 原生 - 系统消息框
--- 包含显示消息给玩家 及 显示Debug消息等
---@return number integer
_J.DzFrameGetUnitMessage = function()
    return _J.exec("DzFrameGetUnitMessage", nil)
end

--- 原生 - 界面按钮
--- 左上的菜单等按钮，索引从0开始
---@param buttonId number integer
---@return number integer
_J.DzFrameGetUpperButtonBarButton = function(buttonId)
    return _J.exec("DzFrameGetUpperButtonBarButton", { buttonId })
end

--- 获取frame当前值
--- 支持Slider、SimpleStatusBar、StatusBar
---@param frame number integer
---@return number floor
_J.DzFrameGetValue = function(frame)
    return _J.exec("DzFrameGetValue", { frame })
end

--- 原生 - 隐藏界面元素
--- 不再在地图初始化时调用则会残留小地图和时钟模型
_J.DzFrameHideInterface = function()
    return _J.exec("DzFrameHideInterface", nil)
end

--- 设置绝对位置
--- 设置 frame 的 Point 锚点 在 (x, y)
---@param frame number integer
---@param point number integer
---@param x number floor(3)
---@param y number floor(3)
_J.DzFrameSetAbsolutePoint = function(frame, point, x, y)
    return _J.exec("DzFrameSetAbsolutePoint", { frame, point, x, y })
end

--- 移动所有锚点到Frame
--- 移动 frame 的 所有锚点 到 relativeFrame 上
---@param frame number integer
---@param relativeFrame number integer
---@return boolean
_J.DzFrameSetAllPoints = function(frame, relativeFrame)
    return _J.exec("DzFrameSetAllPoints", { frame, relativeFrame })
end

--- 设置frame的透明度(0-255)
---@param frame number integer
---@param alpha number integer
_J.DzFrameSetAlpha = function(frame, alpha)
    return _J.exec("DzFrameSetAlpha", { frame, alpha })
end

--- 设置动画
---@param frame number integer
---@param animId number integer 播放序号的动画
---@param autoCast boolean 自动播放
_J.DzFrameSetAnimate = function(frame, animId, autoCast)
    return _J.exec("DzFrameSetAnimate", { frame, animId, autoCast })
end

--- 设置动画进度
--- 自动播放为false时可用
---@param frame number integer
---@param offset number float(5) 进度
_J.DzFrameSetAnimateOffset = function(frame, offset)
    return _J.exec("DzFrameSetAnimateOffset", { frame, offset })
end

--- 启用/禁用 frame
---@param frame number integer
---@param enable boolean
_J.DzFrameSetEnable = function(frame, enable)
    return _J.exec("DzFrameSetEnable", { frame, enable })
end

--- 设置frame获取焦点
---@param frame number integer
---@param enable boolean
---@return boolean
_J.DzFrameSetFocus = function(frame, enable)
    return _J.exec("DzFrameSetFocus", { frame, enable })
end

--- 设置字体
--- 设置 frame 的字体为 font, 大小 height, flag flag
--- 支持EditBox、SimpleFontString、SimpleMessageFrame以及非SimpleFrame类型的例如TEXT，flag作用未知
---@param frame number integer
---@param fileName string
---@param height number float(5)
---@param flag number integer
_J.DzFrameSetFont = function(frame, fileName, height, flag)
    return _J.exec("DzFrameSetFont", { frame, fileName, height, flag })
end

--- 设置最大/最小值
--- 设置 frame 的 最小值为 Min 最大值为 Max
--- 支持Slider、SimpleStatusBar、StatusBar
---@param frame number integer
---@param minValue number float(5)
---@param maxValue number float(5)
_J.DzFrameSetMinMaxValue = function(frame, minValue, maxValue)
    return _J.exec("DzFrameSetMinMaxValue", { frame, minValue, maxValue })
end

--- 设置模型
--- 设置 frame 的模型文件为 modelFile ModelType:modelType Flag:flag
---@param frame number integer
---@param modelFile string
---@param modelType number integer
---@param flag number integer
_J.DzFrameSetModel = function(frame, modelFile, modelType, flag)
    return _J.exec("DzFrameSetModel", { frame, modelFile, modelType, flag })
end

--- 设置父窗口
--- 设置 frame 的父窗口为 parent
---@param frame number integer
---@param parent number integer
_J.DzFrameSetParent = function(frame, parent)
    return _J.exec("DzFrameSetParent", { frame, parent })
end

--- 设置相对位置
--- 设置 frame 的 Point 锚点 (跟随relativeFrame 的 relativePoint 锚点) 偏移(x, y)
---@param frame number integer
---@param point number integer
---@param relativeFrame string string
---@param relativePoint number integer
---@param x number float(5)
---@param y number float(5)
_J.DzFrameSetPoint = function(frame, point, relativeFrame, relativePoint, x, y)
    return _J.exec("DzFrameSetPoint", { frame, point, relativeFrame, relativePoint, x, y })
end

--- 设置优先级
--- 设置 frame 优先级:int
---@param frame number integer
---@param priority number integer
_J.DzFrameSetPriority = function(frame, priority)
    return _J.exec("DzFrameSetPriority", { frame, priority })
end

--- 设置缩放
--- 设置 frame 的缩放 scale
---@param frame number integer
---@param scale number float(5)
_J.DzFrameSetScale = function(frame, scale)
    return _J.exec("DzFrameSetScale", { frame, scale })
end

--- 注册UI事件回调(func name)
--- 注册 frame 的 eventId 事件 运行:funcName 是否同步:sync
---@param frame number integer
---@param eventId number integer
---@param funcName string
---@param sync boolean
_J.DzFrameSetScript = function(frame, eventId, funcName, sync)
    return _J.exec("DzFrameSetScript", { frame, eventId, funcName, sync })
end

--- 注册UI事件回调(func handle)
--- 注册 frame 的 eventId 事件 运行:funcHandle 是否同步:sync
--- 运行触发器时需要打开同步
---@param frame number integer
---@param eventId number integer
---@param funcHandle function
---@param sync boolean
_J.DzFrameSetScriptByCode = function(frame, eventId, funcHandle, sync)
    return _J.exec("DzFrameSetScriptByCode", { frame, eventId, funcHandle, sync })
end

--- 设置frame大小
---@param frame number integer
---@param w number float(5) 宽
---@param h number float(5) 高
_J.DzFrameSetSize = function(frame, w, h)
    return _J.exec("DzFrameSetSize", { frame, w, h })
end

--- 设置frame步进值
--- 支持Slider
---@param frame number integer
---@param step number float(3) 步进
_J.DzFrameSetStepValue = function(frame, step)
    return _J.exec("DzFrameSetStepValue", { frame, step })
end

--- 设置frame文本
--- 支持EditBox, TextFrame, TextArea, SimpleFontString、GlueEditBoxWar3、SlashChatBox、TimerTextFrame、TextButtonFrame、GlueTextButton
---@param frame number integer
---@param text string
_J.DzFrameSetText = function(frame, text)
    return _J.exec("DzFrameSetText", { frame, text })
end

--- 设置frame对齐方式
--- 支持TextFrame、SimpleFontString、SimpleMessageFrame
---@param frame number integer
---@param align number integer ，参考blizzard:^FRAME_ALIGN
_J.DzFrameSetTextAlignment = function(frame, align)
    return _J.exec("DzFrameSetTextAlignment", { frame, align })
end

---@param frame number integer
---@param color number integer
_J.DzFrameSetTextColor = function(frame, color)
    return _J.exec("DzFrameSetTextColor", { frame, color })
end

--- 设置frame字数限制
---@param frame number integer
---@param limit number integer
_J.DzFrameSetTextSizeLimit = function(frame, limit)
    return _J.exec("DzFrameSetTextSizeLimit", { frame, limit })
end

--- 设置frame贴图
--- 支持Backdrop、SimpleStatusBar
---@param frame number integer
---@param texture string 贴图路径
---@param flag number integer 是否平铺
_J.DzFrameSetTexture = function(frame, texture, flag)
    return _J.exec("DzFrameSetTexture", { frame, texture, flag })
end

--- 设置提示
--- 设置 frame 的提示Frame为 tooltip
--- 设置tooltip
---@param frame number integer
---@param tooltip number integer
_J.DzFrameSetTooltip = function(frame, tooltip)
    return _J.exec("DzFrameSetTooltip", { frame, tooltip })
end

---@param funcName string
_J.DzFrameSetUpdateCallback = function(funcName)
    return _J.exec("DzFrameSetUpdateCallback", { funcName })
end

---@param funcHandle function
_J.DzFrameSetUpdateCallbackByCode = function(funcHandle)
    return _J.exec("DzFrameSetUpdateCallbackByCode", { funcHandle })
end

--- 设置frame当前值
--- 支持Slider、SimpleStatusBar、StatusBar
---@param frame number integer
---@param value number float(5)
_J.DzFrameSetValue = function(frame, value)
    return _J.exec("DzFrameSetValue", { frame, value })
end

--- 设置frame颜色
---@param frame number integer
---@param vertexColor number integer
_J.DzFrameSetVertexColor = function(frame, vertexColor)
    return _J.exec("DzFrameSetVertexColor", { frame, vertexColor })
end

--- 设置frame显示与否
---@param frame number integer
---@param enable boolean
_J.DzFrameShow = function(frame, enable)
    return _J.exec("DzFrameShow", { frame, enable })
end

_J.DzGetClientHeight = function(...)
    return _J.exec("DzGetClientHeight", { ... })
end

_J.DzGetClientWidth = function(...)
    return _J.exec("DzGetClientWidth", { ... })
end

--- 取 RGBA 色值
--- 返回一个整数，用于设置Frame颜色
---@param r number integer
---@param g number integer
---@param b number integer
---@param a number integer
---@return number integer
_J.DzGetColor = function(r, g, b, a)
    return _J.exec("DzGetColor", { r, g, b, a })
end

_J.DzGetConvertWorldPositionX = function(...)
    return _J.exec("DzGetConvertWorldPositionX", { ... })
end

_J.DzGetConvertWorldPositionY = function(...)
    return _J.exec("DzGetConvertWorldPositionY", { ... })
end

_J.DzGetGameMode = function(...)
    return _J.exec("DzGetGameMode", { ... })
end

--- 原生 - 游戏UI
--- 一般用作创建自定义UI的父节点
---@return number integer
_J.DzGetGameUI = function()
    return _J.exec("DzGetGameUI", nil)
end

--- 获取客户端语言
--- 对不同语言客户端返回不同
---@return string
_J.DzGetLocale = function()
    return _J.exec("DzGetLocale", nil)
end

--- 鼠标所在的Frame控件指针
--- 不是所有类型的Frame都能响应鼠标，能响应的有BUTTON，TEXT等
---@return number integer
_J.DzGetMouseFocus = function()
    return _J.exec("DzGetMouseFocus", nil)
end

--- 获取鼠标在游戏内的坐标X
---@return number
_J.DzGetMouseTerrainX = function()
    return _J.exec("DzGetMouseTerrainX", nil)
end

--- 获取鼠标在游戏内的坐标Y
---@return number
_J.DzGetMouseTerrainY = function()
    return _J.exec("DzGetMouseTerrainY", nil)
end

--- 获取鼠标在游戏内的坐标Z
---@return number
_J.DzGetMouseTerrainZ = function()
    return _J.exec("DzGetMouseTerrainZ", nil)
end

--- 获取鼠标在屏幕的坐标X
---@return number
_J.DzGetMouseX = function()
    return _J.exec("DzGetMouseX", nil)
end

--- 获取鼠标游戏窗口坐标X
---@return number integer
_J.DzGetMouseXRelative = function()
    return _J.exec("DzGetMouseXRelative", nil)
end

--- 获取鼠标在屏幕的坐标Y
---@return number
_J.DzGetMouseY = function()
    return _J.exec("DzGetMouseY", nil)
end

--- 获取鼠标游戏窗口坐标Y
---@return number integer
_J.DzGetMouseYRelative = function()
    return _J.exec("DzGetMouseYRelative", nil)
end

_J.DzGetPlayerInitGold = function(...)
    return _J.exec("DzGetPlayerInitGold", { ... })
end

_J.DzGetPlayerName = function(...)
    return _J.exec("DzGetPlayerName", { ... })
end

_J.DzGetPlayerSelectedHero = function(...)
    return _J.exec("DzGetPlayerSelectedHero", { ... })
end

--- 事件响应 - 获取触发的按键
--- 响应 [硬件] - 按键事件
---@return number integer
_J.DzGetTriggerKey = function()
    return _J.exec("DzGetTriggerKey", nil)
end

--- 事件响应 - 获取触发硬件事件的玩家
--- 响应 [硬件] - 按键事件 滚轮事件 窗口大小变化事件
---@return userdata player
_J.DzGetTriggerKeyPlayer = function()
    return _J.exec("DzGetTriggerKeyPlayer", nil)
end

--- 事件响应 - 获取同步的数据
--- 响应 [同步] - 同步消息事件
---@return string
_J.DzGetTriggerSyncData = function()
    return _J.exec("DzGetTriggerSyncData", nil)
end

--- 事件响应 - 获取同步数据的玩家
--- 响应 [同步] - 同步消息事件
---@return userdata player
_J.DzGetTriggerSyncPlayer = function()
    return _J.exec("DzGetTriggerSyncPlayer", nil)
end

--- 事件响应 - 触发的Frame
---@return number integer
_J.DzGetTriggerUIEventFrame = function()
    return _J.exec("DzGetTriggerUIEventFrame", nil)
end

--- 事件响应 - 获取触发ui的玩家
---@return userdata player
_J.DzGetTriggerUIEventPlayer = function()
    return _J.exec("DzGetTriggerUIEventPlayer", nil)
end

--- 获取升级所需经验
--- 获取单位 unit 的 level级 升级所需经验
---@param whichUnit userdata
---@param level number integer
---@return number integer
_J.DzGetUnitNeededXP = function(whichUnit, level)
    return _J.exec("DzGetUnitNeededXP", { whichUnit, level })
end

--- 获取鼠标指向的单位
---@return userdata unit
_J.DzGetUnitUnderMouse = function()
    return _J.exec("DzGetUnitUnderMouse", nil)
end

--- 事件响应 - 获取滚轮变化值
--- 响应 [硬件] - 鼠标滚轮事件，正负区分上下
---@return number integer
_J.DzGetWheelDelta = function()
    return _J.exec("DzGetWheelDelta", nil)
end

--- 获取魔兽窗口高度
---@return number integer
_J.DzGetWindowHeight = function()
    return _J.exec("DzGetWindowHeight", nil)
end

--- 获取魔兽窗口宽度
---@return number integer
_J.DzGetWindowWidth = function()
    return _J.exec("DzGetWindowWidth", {})
end

--- 获取魔兽窗口X坐标
---@return number integer
_J.DzGetWindowX = function()
    return _J.exec("DzGetWindowX", nil)
end

--- 获取魔兽窗口Y坐标
---@return number integer
_J.DzGetWindowY = function()
    return _J.exec("DzGetWindowY", nil)
end

--- 判断按键是否按下
---@param iKey number integer 参考blizzard:^GAME_KEY
---@return boolean
_J.DzIsKeyDown = function(iKey)
    return _J.exec("DzIsKeyDown", { iKey })
end

--- 鼠标是否在游戏内
---@return boolean
_J.DzIsMouseOverUI = function()
    return _J.exec("DzIsMouseOverUI", nil)
end

--- 判断游戏窗口是否处于活动状态
---@return boolean
_J.DzIsWindowActive = function()
    return _J.exec("DzIsWindowActive", nil)
end

--- 加载Toc文件列表
--- 加载--> file.toc
--- 载入自己的fdf列表文件
---@return boolean
_J.DzLoadToc = function(tocFilePath)
    if (_J._cache["DzLoadToc"][tocFilePath] == true) then
        return true
    end
    _J._cache["DzLoadToc"][tocFilePath] = true
    return _J.exec("DzLoadToc", { tocFilePath })
end

---@param enable boolean
_J.DzOriginalUIAutoResetPoint = function(enable)
    return _J.exec("DzOriginalUIAutoResetPoint", { enable })
end

_J.DzPlatform_GameStart = function(...)
    return _J.exec("DzPlatform_GameStart", { ... })
end

_J.DzPlatform_HasGameOver = function(...)
    return _J.exec("DzPlatform_HasGameOver", { ... })
end

_J.DzPlatform_HasGameOver_Player = function(...)
    return _J.exec("DzPlatform_HasGameOver_Player", { ... })
end

--- 原生 - 修改屏幕比例(FOV)
---@param value number float(5)
_J.DzSetCustomFovFix = function(value)
    return _J.exec("DzSetCustomFovFix", { value })
end

--- 设置内存数值
--- 设置内存数据 address=value
---@param address number integer
---@param value number float(5)
_J.DzSetMemory = function(address, value)
    return _J.exec("DzSetMemory", { address, value })
end

--- 设置鼠标的坐标
---@param x number integer
---@param y number integer
_J.DzSetMousePos = function(x, y)
    return _J.exec("DzSetMousePos", { x, y })
end

_J.DzSetParams = function(...)
    return _J.exec("DzSetParams", { ... })
end

--- 替换单位类型
--- 替换whichUnit的单位类型为:id
--- 不会替换大头像中的模型
---@param whichUnit userdata
---@param id number|string
_J.DzSetUnitID = function(whichUnit, id)
    return _J.exec("DzSetUnitID", { whichUnit, id })
end

--- 替换单位模型
--- 替换whichUnit的模型:path
--- 不会替换大头像中的模型
---@param whichUnit userdata
---@param model string
_J.DzSetUnitModel = function(whichUnit, model)
    return _J.exec("DzSetUnitModel", { whichUnit, model })
end

--- 设置单位位置 - 本地调用
---@param whichUnit userdata
---@param x number float(2)
---@param y number float(2)
_J.DzSetUnitPosition = function(whichUnit, x, y)
    return _J.exec("DzSetUnitPosition", { whichUnit, x, y })
end

--- 替换单位贴图
--- 只能替换模型中有Replaceable ID x 贴图的模型，ID为索引。不会替换大头像中的模型
---@param whichUnit userdata
---@param path string
---@param texId number integer
_J.DzSetUnitTexture = function(whichUnit, path, texId)
    return _J.exec("DzSetUnitTexture", { whichUnit, path, texId })
end

--- 原生 - 设置小地图背景贴图
---@param blp string
_J.DzSetWar3MapMap = function(blp)
    return _J.exec("DzSetWar3MapMap", { blp })
end

--- 获取子SimpleFontString
--- ID默认填0，同名时优先获取最后被创建的。SimpleFontString为fdf中的Frame类型
---@param name string
---@param id number integer
_J.DzSimpleFontStringFindByName = function(name, id)
    return _J.exec("DzSimpleFontStringFindByName", { name, id })
end

--- 获取子SimpleFrame
--- ID默认填0，同名时优先获取最后被创建的。SimpleFrame为fdf中的Frame类型
---@param name string
---@param id number integer
_J.DzSimpleFrameFindByName = function(name, id)
    return _J.exec("DzSimpleFrameFindByName", { name, id })
end

--- 获取子SimpleTexture
--- ID默认填0，同名时优先获取最后被创建的。SimpleTexture为fdf中的Frame类型
---@param name string
---@param id number integer
_J.DzSimpleTextureFindByName = function(name, id)
    return _J.exec("DzSimpleTextureFindByName", { name, id })
end

_J.DzSyncBuffer = function(...)
    return _J.exec("DzSyncBuffer", { ... })
end

--- 同步游戏数据
--- 同步 标签：prefix  发送数据：data
---@param prefix string
---@param data string
_J.DzSyncData = function(prefix, data)
    return _J.exec("DzSyncData", { prefix, data })
end

---@param trig userdata
---@param key number integer
---@param status number integer
---@param sync boolean
---@param funcName string
_J.DzTriggerRegisterKeyEvent = function(trig, key, status, sync, funcName)
    return _J.exec("DzTriggerRegisterKeyEvent", { trig, key, status, sync, funcName })
end

---@param trig userdata
---@param key number integer
---@param status number integer
---@param sync boolean
---@param funcHandle function
_J.DzTriggerRegisterKeyEventByCode = function(trig, key, status, sync, funcHandle)
    return _J.exec("DzTriggerRegisterKeyEventByCode", { trig, key, status, sync, funcHandle })
end

---@param trig userdata
---@param btn number integer
---@param status number integer
---@param sync boolean
---@param funcName string
_J.DzTriggerRegisterMouseEvent = function(trig, btn, status, sync, funcName)
    return _J.exec("DzTriggerRegisterMouseEvent", { trig, btn, status, sync, funcName })
end

---@param trig userdata
---@param btn number integer
---@param status number integer
---@param sync boolean
---@param funcHandle function
_J.DzTriggerRegisterMouseEventByCode = function(trig, btn, status, sync, funcHandle)
    return _J.exec("DzTriggerRegisterMouseEventByCode", { trig, btn, status, sync, funcHandle })
end

---@param trig userdata
---@param sync boolean
---@param funcName string
_J.DzTriggerRegisterMouseMoveEvent = function(trig, sync, funcName)
    return _J.exec("DzTriggerRegisterMouseMoveEvent", { trig, sync, funcName })
end

---@param trig userdata
---@param sync boolean
---@param funcHandle function
_J.DzTriggerRegisterMouseMoveEventByCode = function(trig, sync, funcHandle)
    return _J.exec("DzTriggerRegisterMouseMoveEventByCode", { trig, sync, funcHandle })
end

---@param trig userdata
---@param sync boolean
---@param funcName string
_J.DzTriggerRegisterMouseWheelEvent = function(trig, sync, funcName)
    return _J.exec("DzTriggerRegisterMouseWheelEvent", { trig, sync, funcName })
end

---@param trig userdata
---@param sync boolean
---@param funcHandle function
_J.DzTriggerRegisterMouseWheelEventByCode = function(trig, sync, funcHandle)
    return _J.exec("DzTriggerRegisterMouseWheelEventByCode", { trig, sync, funcHandle })
end

--- 数据同步
--- 标签为 prefix 的数据被同步 | 来自平台:server
--- 来自平台的参数填false
---@param trig userdata
---@param prefix string
---@param server boolean
_J.DzTriggerRegisterSyncData = function(trig, prefix, server)
    return _J.exec("DzTriggerRegisterSyncData", { trig, prefix, server })
end

---@param trig userdata
---@param sync boolean
---@param funcName string
_J.DzTriggerRegisterWindowResizeEvent = function(trig, sync, funcName)
    return _J.exec("DzTriggerRegisterWindowResizeEvent", { trig, sync, funcName })
end

---@param trig userdata
---@param sync boolean
---@param funcHandle function
_J.DzTriggerRegisterWindowResizeEventByCode = function(trig, sync, funcHandle)
    return _J.exec("DzTriggerRegisterWindowResizeEventByCode", { trig, sync, funcHandle })
end

_J.DzUnitDisableAttack = function(...)
    return _J.exec("DzUnitDisableAttack", { ... })
end

_J.DzUnitDisableInventory = function(...)
    return _J.exec("DzUnitDisableInventory", { ... })
end

_J.DzUnitLearningSkill = function(...)
    return _J.exec("DzUnitLearningSkill", { ... })
end

_J.DzUnitSilence = function(...)
    return _J.exec("DzUnitSilence", { ... })
end

_J.EXBlendButtonIcon = function(...)
    return _J.exec("EXBlendButtonIcon", { ... })
end

_J.EXDclareButtonIcon = function(...)
    return _J.exec("EXDclareButtonIcon", { ... })
end

_J.EXDisplayChat = function(...)
    return _J.exec("EXDisplayChat", { ... })
end

--- 重置特效变换
--- 重置 effect
--- 清空所有的旋转和缩放，重置为初始状态
---@param effect userdata
_J.EXEffectMatReset = function(effect)
    return _J.exec("EXEffectMatReset", { effect })
end

--- 特效绕X轴旋转
--- effect 绕X轴旋转 angle 度
--- 多次调用，效果会叠加，不想叠加需要先重置为初始状态
---@param effect userdata
---@param angle number float(5)
_J.EXEffectMatRotateX = function(effect, angle)
    return _J.exec("EXEffectMatRotateX", { effect, angle })
end

--- 特效绕Y轴旋转
--- effect 绕Y轴旋转 angle 度
--- 多次调用，效果会叠加，不想叠加需要先重置为初始状态
---@param effect userdata
---@param angle number float(5)
_J.EXEffectMatRotateY = function(effect, angle)
    return _J.exec("EXEffectMatRotateY", { effect, angle })
end

--- 特效绕Z轴旋转
--- effect 绕Z轴旋转 angle 度
--- 多次调用，效果会叠加，不想叠加需要先重置为初始状态
---@param effect userdata
---@param angle number float(5)
_J.EXEffectMatRotateZ = function(effect, angle)
    return _J.exec("EXEffectMatRotateZ", { effect, angle })
end

--- 缩放特效
--- 设置 effect 的X轴缩放，Y轴缩放，Z轴缩放
--- 多次调用，效果会叠加，不想叠加需要先重置为初始状态。设置为2,2,2时相当于大小变为2倍。设置为负数时，就是镜像翻转
---@param effect userdata
---@param x number float(5)
---@param y number float(5)
---@param z number float(5)
_J.EXEffectMatScale = function(effect, x, y, z)
    return _J.exec("EXEffectMatScale", { effect, x, y, z })
end

---@param script string
_J.EXExecuteScript = function(script)
    return _J.exec("EXExecuteScript", { script })
end

---@param abil userdata ability
---@param level number integer
---@param dataType number integer
---@return number integer
_J.EXGetAbilityDataInteger = function(abil, level, dataType)
    return _J.exec("EXGetAbilityDataInteger", { abil, level, dataType })
end

---@param abil userdata ability
---@param level number integer
---@param dataType number integer
---@return number float
_J.EXGetAbilityDataReal = function(abil, level, dataType)
    return _J.exec("EXGetAbilityDataReal", { abil, level, dataType })
end

---@param abil userdata ability
---@param level number integer
---@param dataType number integer
---@return string
_J.EXGetAbilityDataString = function(abil, level, dataType)
    return _J.exec("EXGetAbilityDataString", { abil, level, dataType })
end

---@param abil userdata ability
---@return number integer
_J.EXGetAbilityId = function(abil)
    return _J.exec("EXGetAbilityId", { abil })
end

---@param abil userdata ability
---@param stateType number integer
---@return number float
_J.EXGetAbilityState = function(abil, stateType)
    return _J.exec("EXGetAbilityState", { abil, stateType })
end

_J.EXGetAbilityString = function(...)
    return _J.exec("EXGetAbilityString", { ... })
end

---@param buffCode number integer
---@param dataType number integer
---@return string
_J.EXGetBuffDataString = function(buffCode, dataType)
    return _J.exec("EXGetBuffDataString", { buffCode, dataType })
end

--- 获取特效大小
---@param effect userdata
---@return number float
_J.EXGetEffectSize = function(effect)
    return _J.exec("EXGetEffectSize", { effect })
end

--- 获取特效X轴坐标
---@param effect userdata
---@return number float
_J.EXGetEffectX = function(effect)
    return _J.exec("EXGetEffectX", { effect })
end

--- 获取特效Y轴坐标
---@param effect userdata
---@return number float
_J.EXGetEffectY = function(effect)
    return _J.exec("EXGetEffectY", { effect })
end

--- 获取特效Z轴坐标
---@param effect userdata
---@return number float
_J.EXGetEffectZ = function(effect)
    return _J.exec("EXGetEffectZ", { effect })
end

---@param eddType number integer
---@return number integer
_J.EXGetEventDamageData = function(eddType)
    return _J.exec("EXGetEventDamageData", { eddType })
end

--- 是物理伤害
--- 响应'受到伤害'单位事件,不能用在等待之后
---@return boolean
_J.isEventPhysicalDamage = function()
    return 0 ~= _J.EXGetEventDamageData(EVENT_DAMAGE_DATA_IS_PHYSICAL)
end

--- 是攻击伤害
--- 响应'受到伤害'单位事件,不能用在等待之后
---@return boolean
_J.isEventAttackDamage = function()
    return 0 ~= _J.EXGetEventDamageData(EVENT_DAMAGE_DATA_IS_ATTACK)
end

--- 是远程伤害
--- 响应'受到伤害'单位事件,不能用在等待之后
---@return boolean
_J.isEventRangedDamage = function()
    return 0 ~= _J.EXGetEventDamageData(EVENT_DAMAGE_DATA_IS_RANGED)
end

--- 单位所受伤害的伤害类型是 damageType
--- 响应'受到伤害'单位事件,不能用在等待之后
---@param damageType userdata 参考 blizzard:^DAMAGE_TYPE
---@return boolean
_J.isEventDamageType = function(damageType)
    return damageType == cj.ConvertDamageType(_J.EXGetEventDamageData(EVENT_DAMAGE_DATA_DAMAGE_TYPE))
end

--- 单位所受伤害的武器类型是 是 weaponType
--- 响应'受到伤害'单位事件,不能用在等待之后
---@param weaponType userdata 参考 blizzard:^WEAPON_TYPE
---@return boolean
_J.isEventWeaponType = function(weaponType)
    return weaponType == cj.ConvertWeaponType(_J.EXGetEventDamageData(EVENT_DAMAGE_DATA_WEAPON_TYPE))
end

--- 单位所受伤害的攻击类型是 是 attackType
--- 响应'受到伤害'单位事件,不能用在等待之后
---@param attackType userdata 参考 blizzard:^ATTACK_TYPE
---@return boolean
_J.isEventAttackType = function(attackType)
    return attackType == cj.ConvertAttackType(_J.EXGetEventDamageData(EVENT_DAMAGE_DATA_ATTACK_TYPE))
end

---@param itemCode number integer
---@param dataType number integer
---@return string
_J.EXGetItemDataString = function(itemCode, dataType)
    return _J.exec("EXGetItemDataString", { itemCode, dataType })
end

---@param whichUnit userdata
---@param abilityID number string|integer
_J.EXGetUnitAbility = function(whichUnit, abilityID)
    return _J.exec('EXGetUnitAbility', { whichUnit, abilityID })
end

---@param whichUnit userdata
---@param index number integer
_J.EXGetUnitAbilityByIndex = function(whichUnit, index)
    return _J.exec('EXGetUnitAbilityByIndex', { whichUnit, index })
end

_J.EXGetUnitArrayString = function(...)
    return _J.exec("EXGetUnitArrayString", { ... })
end

_J.EXGetUnitInteger = function(...)
    return _J.exec("EXGetUnitInteger", { ... })
end

_J.EXGetUnitReal = function(...)
    return _J.exec("EXGetUnitReal", { ... })
end

_J.EXGetUnitString = function(...)
    return _J.exec("EXGetUnitString", { ... })
end

---@param whichUnit userdata
---@param enable boolean
_J.EXPauseUnit = function(whichUnit, enable)
    return _J.exec("EXPauseUnit", { whichUnit, enable })
end

--- 单位添加晕眩
---@param whichUnit userdata
_J.UnitAddSwim = function(whichUnit)
    return _J.EXPauseUnit(whichUnit, true)
end

--- 单位移除晕眩
--- 别用来移风暴之锤之类的晕眩。因为它只会移除晕眩并不会移除晕眩的buff
---@param whichUnit userdata
_J.UnitRemoveSwim = function(whichUnit)
    return _J.EXPauseUnit(whichUnit, false)
end

_J.EXSetAbilityAEmeDataA = function(...)
    return _J.exec("EXSetAbilityAEmeDataA", { ... })
end

_J.EXSetAbilityDataInteger = function(...)
    return _J.exec("EXSetAbilityDataInteger", { ... })
end

_J.EXSetAbilityDataReal = function(...)
    return _J.exec("EXSetAbilityDataReal", { ... })
end

_J.EXSetAbilityDataString = function(...)
    return _J.exec("EXSetAbilityDataString", { ... })
end

---@param ability userdata
---@param stateType number integer
---@param value number floor(3)
_J.EXSetAbilityState = function(ability, stateType, value)
    return _J.exec('EXSetAbilityState', { ability, stateType, value })
end

_J.EXSetAbilityString = function(...)
    return _J.exec("EXSetAbilityString", { ... })
end

---@param buffCode number integer
---@param dataType number integer
---@param value string
_J.EXSetBuffDataString = function(buffCode, dataType, value)
    return _J.exec("EXSetBuffDataString", { buffCode, dataType, value })
end

--- 设置特效大小
---@param e userdata
---@param size number float(3)
_J.EXSetEffectSize = function(e, size)
    return _J.exec("EXSetEffectSize", { e, size })
end

--- 设置特效动画速度
---@param e userdata
---@param speed number float(3)
_J.EXSetEffectSpeed = function(e, speed)
    return _J.exec("EXSetEffectSpeed", { e, speed })
end

--- 移动特效到坐标
---@param e userdata
---@param x number float(3)
---@param y number float(3)
_J.EXSetEffectXY = function(e, x, y)
    return _J.exec("EXSetEffectXY", { e, x, y })
end

---设置特效高度
---@param e userdata
---@param z number float(3)
_J.EXSetEffectZ = function(e, z)
    return _J.exec("EXSetEffectZ", { e, z })
end

---@param amount number float(3)
---@return boolean
_J.EXSetEventDamage = function(amount)
    return _J.exec("EXSetEventDamage", { amount })
end

---@param itemCode number integer
---@param dataType number integer
---@param value string
---@return boolean
_J.EXSetItemDataString = function(itemCode, dataType, value)
    return _J.exec("EXSetItemDataString", { itemCode, dataType, value })
end

_J.EXSetUnitArrayString = function(...)
    return _J.exec("EXSetUnitArrayString", { ... })
end

--- 设置单位的碰撞类型
--- 启用/禁用 单位u 对 t 的碰撞
---@param enable boolean
---@param u userdata
---@param t number integer 碰撞类型，参考blizzard:^COLLISION_TYPE
_J.EXSetUnitCollisionType = function(enable, u, t)
    return _J.exec("EXSetUnitCollisionType", { enable, u, t })
end

--- 设置单位面向角度
--- 立即转身
---@param u userdata
---@param angle number float(2)
_J.EXSetUnitFacing = function(u, angle)
    return _J.exec("EXSetUnitFacing", { u, angle })
end

_J.EXSetUnitInteger = function(...)
    return _J.exec("EXSetUnitInteger", { ... })
end

--- 设置单位的移动类型
---@param u userdata
---@param t number integer 移动类型，参考blizzard:^MOVE_TYPE
_J.EXSetUnitMoveType = function(u, t)
    return _J.exec("EXSetUnitMoveType", { u, t })
end

_J.EXSetUnitReal = function(...)
    return _J.exec("EXSetUnitReal", { ... })
end

_J.EXSetUnitString = function(...)
    return _J.exec("EXSetUnitString", { ... })
end

--- 伤害值
---@return number
_J.GetEventDamage = function()
    return _J.exec("GetEventDamage", nil)
end

---@param whichUnit userdata
---@param state userdata unitstate
---@return number
_J.GetUnitState = function(whichUnit, state)
    return _J.exec('GetUnitState', { whichUnit, state })
end

---@param dataType number integer
---@param whichPlayer userdata
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 number integer
---@param param5 number integer
---@param param6 number integer
---@return boolean
_J.RequestExtraBooleanData = function(dataType, whichPlayer, param1, param2, param3, param4, param5, param6)
    return _J.exec("RequestExtraBooleanData", { dataType, whichPlayer, param1, param2, param3, param4, param5, param6 })
end

---@param dataType number integer
---@param whichPlayer userdata
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 number integer
---@param param5 number integer
---@param param6 number integer
---@return number integer
_J.RequestExtraIntegerData = function(dataType, whichPlayer, param1, param2, param3, param4, param5, param6)
    return _J.exec("RequestExtraIntegerData", { dataType, whichPlayer, param1, param2, param3, param4, param5, param6 })
end

---@param dataType number integer
---@param whichPlayer userdata
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 number integer
---@param param5 number integer
---@param param6 number integer
---@return number
_J.RequestExtraRealData = function(dataType, whichPlayer, param1, param2, param3, param4, param5, param6)
    return _J.exec("RequestExtraRealData", { dataType, whichPlayer, param1, param2, param3, param4, param5, param6 })
end

---@param dataType number integer
---@param whichPlayer userdata
---@param param1 string
---@param param2 string
---@param param3 boolean
---@param param4 number integer
---@param param5 number integer
---@param param6 number integer
---@return string
_J.RequestExtraStringData = function(dataType, whichPlayer, param1, param2, param3, param4, param5, param6)
    return _J.exec("RequestExtraStringData", { dataType, whichPlayer, param1, param2, param3, param4, param5, param6 })
end

--- 设置单位属性
---@param whichUnit userdata
---@param state userdata unitstate
---@param value number
_J.SetUnitState = function(whichUnit, state, value)
    _J.exec('SetUnitState', { whichUnit, state, value })
end

--- 获取某个坐标的Z轴高度
---@type fun(x:number,y:number):number
_J.GetZ = function(x, y)
    if (type(x) == "number" and type(y) == "number") then
        x = math.floor(x)
        y = math.floor(y)
        local k = x .. '_' .. y
        if (_J._cache["GetZ"][k] == nil) then
            local loc = cj.Location(x, y)
            local z = cj.GetLocationZ(loc)
            cj.RemoveLocation(loc)
            _J._cache["GetZ"][k] = z
        end
        return _J._cache["GetZ"][k]
    end
    return 0
end

--- X比例 转 像素
---@type fun(x:number):number
_J.PX = function(x)
    return _J.DzGetClientWidth() * x / 0.8
end
--- Y比例 转 像素
---@type fun(y:number):number
_J.PY = function(y)
    return _J.DzGetClientHeight() * y / 0.6
end

--- X像素 转 比例
---@type fun(x:number):number
_J.RX = function(x)
    return x / _J.DzGetClientWidth() * 0.8
end
--- Y像素 转 比例
---@type fun(y:number):number
_J.RY = function(y)
    return y / _J.DzGetClientHeight() * 0.6
end

--- 鼠标客户端内X像素
---@type fun():number
_J.MousePX = function()
    return _J.DzGetMouseXRelative()
end
--- 鼠标客户端内Y像素
---@type fun():number
_J.MousePY = function()
    return _J.DzGetClientHeight() - _J.DzGetMouseYRelative()
end

--- 鼠标X像素 转 比例
---@type fun():number
_J.MouseRX = function()
    return _J.RX(_J.MousePX())
end
--- 鼠标Y像素 转 比例
---@type fun():number
_J.MouseRY = function()
    return _J.RY(_J.MousePY())
end

--- 判断XY是否在客户端内
---@type fun(rx:number,ry:number):boolean
_J.InWindow = function(rx, ry)
    return rx > 0 and rx < 0.8 and ry > 0 and ry < 0.6
end
--- 判断鼠标是否在客户端内
---@type fun():boolean
_J.InWindowMouse = function()
    return _J.InWindow(_J.MouseRX(), _J.MouseRY())
end
