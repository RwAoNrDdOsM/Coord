local mod = get_mod("Coord")

mod.on_game_state_changed = function(status, state)
	-- Debug
	--mod:echo("on_game_state_changed = " .. tostring(status) .. " " .. tostring(state))
	
	if status == "enter" and state == "StateIngame" then
		local game_mode_manager = Managers.state.game_mode

        if game_mode_manager then
            local level_transition_handler = game_mode_manager.level_transition_handler
            local level_key = level_transition_handler.level_key
            Teleport:set_level(level_key)
        end
        
	end
end

mod:command("tp", mod:localize("tp_command_description"), function(x, y, z, a, b, c, d) 
    if x and y and z then   
        local position = Vector3(x, y, z)
        
        if a and b and c and d then
            local rotation = QuaternionBox(0, 0, 0, 0)
            QuaternionBox.store(rotation, a, b, c, d)
            local player = Managers.player:local_player()
            local unit = player.player_unit

            Teleport:tp_unit(unit, position, rotation)
        else
            local player = Managers.player:local_player()
            local unit = player.player_unit

            Teleport:tp_unit(unit, position)
        end
    else
        mod:echo("Please specify x, y and z.")
    end
end)

mod:command("set_tpid", mod:localize("set_tpid_command_description"), function(id, x, y, z, a, b, c, d)
    if id and x and y and z then   
        local position = {
            x,
            y,
            z,
        }
        
        if a and b and c and d then
            local rotation = {
                a,
                b,
                c,
                d,
            }
            local exist_id = Teleport:exist_id(id)

            if not exist_id and exist_id ~= "DB not found" then
                Teleport:create_id(id)
                Teleport:populate_id(id, position, rotation)
                Teleport:update_db()
            elseif exist_id == "DB not found" then
                mod:echo("DB isn't setup, please restart level.")
            else
                mod:echo("ID: " .. tostring(id) .. " already exists.")
            end
        else
            local exist_id = Teleport:exist_id(id)

            if not exist_id and exist_id ~= "DB not found" then
                Teleport:create_id(id)
                Teleport:populate_id(id, position)
                Teleport:update_db()
            elseif exist_id == "DB not found" then
                mod:echo("DB isn't setup, please restart level.")
            else
                mod:echo("ID: " .. tostring(id) .. " already exists.")
            end
        end
    elseif id and x == "rot" then
        local player = Managers.player:local_player()
        local unit = player.player_unit
        local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
        local player_rotation = first_person_extension:current_rotation()
        local rotx, roty, rotz, rotw = Quaternion.to_elements(player_rotation)
        local rotation = {
            rotx,
            roty,
            rotz,
            rotw,
        }
        local player_position = Unit.world_position(unit, 0)
        local position = {
            player_position[1],
            player_position[2],
            player_position[3],
        }
        local exist_id = Teleport:exist_id(id)

        if not exist_id and exist_id ~= "DB not found" then
            Teleport:create_id(id)
            Teleport:populate_id(id, position, rotation)
            Teleport:update_db()
        elseif exist_id == "DB not found" then
        mod:echo("DB isn't setup, please restart level.")
        else
            mod:echo("ID: " .. tostring(id) .. " already exists.")
        end
    elseif id then
        local player = Managers.player:local_player()
        local unit = player.player_unit
        local first_person_extension = ScriptUnit.extension(unit, "first_person_system")
        local player_position = Unit.world_position(unit, 0)
        local position = {
            player_position[1],
            player_position[2],
            player_position[3],
        }
        local exist_id = Teleport:exist_id(id)

        if not exist_id and exist_id ~= "DB not found" then
            Teleport:create_id(id)
            Teleport:populate_id(id, position)
            Teleport:update_db()
        elseif exist_id == "DB not found" then
            mod:echo("DB isn't setup, please restart level.")
        else
            mod:echo("ID: " .. tostring(id) .. " already exists.")
        end
    else
        mod:echo("Please specify an ID.")
    end
end)

mod:command("destroy_tpid", mod:localize("destroy_id_command_description"), function(id)
    if id then
        local exist_id = Teleport:exist_id(id)

        if exist_id and exist_id ~= "DB not found" then
            Teleport:destroy_id(id)
            Teleport:update_db()
            
        elseif exist_id == "DB not found" then
            mod:echo("DB isn't setup, please restart level.")
        else
            mod:echo("ID: " .. tostring(id) .. " doesn't exist.")
        end
    else
        mod:echo("Please specify an ID.")
    end
end)

mod:command("tpid", mod:localize("tpid_command_description"), function(id)
    if id then
        local exist_id = Teleport:exist_id(id)

        if exist_id and exist_id ~= "DB not found" then
            local player = Managers.player:local_player()
            local unit = player.player_unit

            Teleport:tpid_unit(id, unit)    
        elseif exist_id == "DB not found" then
            mod:echo("DB isn't setup, please restart level.")
        else
            mod:echo("ID: " .. tostring(id) .. " doesn't exist.")
        end   
    else
        mod:echo("Please specify an ID.")
    end
end)

local db = mod:get("db")
if db then 
    Teleport:restore(db)
end