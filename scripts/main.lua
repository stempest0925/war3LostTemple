-- DEBUGGING = true
JassRuntime = require "jass.runtime"

local console = require 'jass.console'
console.enable = true;
console.write('assdasd')




-- _F(unction)
require "scripts.ydlua.common"
-- _C(onst)
require "scripts.ydlua.const"
-- _J(Api)
require "scripts.ydlua.japi"

function echo(player, msg)
    console.write(msg)
end

require 'scripts.src.ui'

uiDemo3()
