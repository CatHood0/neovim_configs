local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local banners = require('core.banners.neovim_banners')

dashboard.section.header.val = banners.improved_banner
alpha.setup(dashboard.opts)
