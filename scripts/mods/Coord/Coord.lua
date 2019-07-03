local mod = get_mod("Coord")
--local simple_ui = get_mod("SimpleUI")

--fassert(simple_ui, "Coordinates must be lower than SimpleUI in your launcher's load order.")

mod:dofile("scripts/mods/Coord/Class/Coord")
mod:dofile("scripts/mods/Coord/Class/Teleport")
mod:dofile("scripts/mods/Coord/Teleport")

--[[mod.update = function(self, dt)
	Coord:update_coordinates()
	Coord:update_text()
	Coord:update_window()
end]]

local Coord = Coord:new()
local Teleport = Teleport:new()

mod:hook_safe(IngameUI, "update", function (self, dt, t, disable_ingame_ui, end_of_level_ui)
  	if not disable_ingame_ui and not end_of_level_ui then
    	Coord:update_coordinates()
		Coord:update_text()
		Coord:update_window()
	end
end)

--[[mod:hook_safe(IngameHud, "update", function (self, dt, t, menu_active, context)
	local is_own_player_dead = self:is_own_player_dead()
	local gift_popup_active = self.gift_popup_ui:active()
	local active_cutscene = self:is_cutscene_active()
	local player_list_active = self.ingame_player_list_ui.active
	local disable_all_hud = gift_popup_active or active_cutscene or player_list_active
	local show_hud = not is_own_player_dead and not disable_all_hud

	if show_hud then
		Coord:update_coordinates()
		Coord:update_text()
		Coord:update_window()
	end
end)]]