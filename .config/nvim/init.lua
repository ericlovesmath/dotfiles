--[[
    Eric Lee's Neovim Configuration
    Email: ericlovesmath@gmail.com
    Github: https://github.com/ericlovesmath
--]]

require("config.options")
require("config.mappings")
require("config.lazy")
require("config.status")
require("config.runner")

-- lewis6991/impatient.nvim
-- Speeds up config by ~25%
require("impatient")