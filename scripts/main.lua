require 'scripts.lib.init'

local console = require 'jass.console'
console.enable = true

_F.FogEnable(false)
_F.FogMaskEnable(false)

require 'scripts.ui.ui'
chooseHero()
