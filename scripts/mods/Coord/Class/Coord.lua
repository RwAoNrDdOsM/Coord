local mod = get_mod("Coord")

Coord = class(Coord)

Coord.init = function(self)
	self.player_rotation = {}
	self.player_position = Vector3(0, 0, 0)
	self.window = {
		size = {500, 59},
		depth = 900,
		padding = {100, 100},
		font_material = "materials/fonts/gw_arial_32",
		font_size = 22,
		font = "gw_arial_32",
		transparency = 200,
		background_color = {50, 50, 50},
		text_color = {255, 255, 255},
		
		action_text = {
			[1] = "Rotation",
			[2] = "Position",
		}
	}
end

Coord.update_coordinates = function(self)
	local player = Managers.player:local_player()
	if player then
		local unit = player.player_unit
		local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
		if first_person_extension then
			local player_rotation = first_person_extension:current_rotation()
			local player_position = POSITION_LOOKUP[unit]
			self.player_rotation = player_rotation
			self.player_position = player_position
		end
	end
end

Coord._draw_background = function(self)
	local screen_w, screen_h = UIResolution()
	local window_x = self.window.padding[1]
	local window_y = screen_h - self.window.padding[2]
	
	Gui.rect(
		self.gui,
		Vector3(window_x, window_y - self.window.size[2], self.window.depth),
		Vector2(self.window.size[1], self.window.size[2]),
		Color(
			self.window.transparency,
			self.window.background_color[1],
			self.window.background_color[2],
			self.window.background_color[3]
		)
	)
end

Coord._draw_text = function(self, text, x, y, text_color)
	local screen_w, screen_h = UIResolution()
	local window_x = self.window.padding[1]
	local window_y = screen_h - self.window.padding[2]
		
	text_color = text_color or self.window.text_color
	
	if self.gui == nil then
		local world = Managers.world:world("top_ingame_view")
		self.gui = World.create_screen_gui(
			world, 
			"immediate",
			"material", "materials/fonts/gw_fonts",
			"material", "materials/ui/ui_1080p_hud_atlas_textures",
			"material", "materials/ui/ui_1080p_common"
		)
	end

	Gui.text(
		self.gui,
		text,
		self.window.font_material,
		self.window.font_size,
		self.window.font,
		Vector3(window_x + x, window_y - y, self.window.depth + 1),
		Color(
			self.window.transparency,
			text_color[1],
			text_color[2],
			text_color[3]
		)
	)
end

Coord.update_text = function(self)
	self:_draw_text(tostring(self.player_rotation), 5, 5 + self.window.font_size*0.7)
    self:_draw_text(tostring(self.player_position), 5, 5 + (self.window.font_size*2))
   
    local background = mod:get("background")
    if background == true then
        self:_draw_background()
    end
end

Coord.update_window = function(self)
	local new_value_x = mod:get("x")
	if new_value_x ~= self.window.padding[1] then
		self.window.padding[1] = new_value_x
	end
	local new_value_y = mod:get("y")
	if new_value_y ~= self.window.padding[2] then
		self.window.padding[2] = new_value_y
	end
	local new_value_font_size = mod:get("font_size")
	if new_value_font_size ~= self.window.font_size then
		self.window.font_size = new_value_font_size
		self.window.size[2] = 15 + new_value_font_size*2
		self.window.size[1] = new_value_font_size*27.8
	end
end