local mod = get_mod("Coord")

Teleport = class(Teleport)

Teleport.init = function(self)
	self._db = {}
    self._level = "inn_level"
end

Teleport.tp_unit = function(self, unit, position, rotation)
    local network_manager = Managers.state.network
    local unit_id = network_manager:unit_game_object_id(unit)
    
    if rotation then
        local rotation = QuaternionBox.unbox(rotation)
        network_manager.network_transmit:send_rpc_server("rpc_teleport_unit_to", unit_id, position, rotation)
    else
        network_manager.network_transmit:send_rpc_server("rpc_teleport_unit_to", unit_id, position, Unit.local_rotation(unit, 0))
    end
end

Teleport.tpid_unit = function(self, id, unit)
    local level_data = self._db[tostring(self._level)]
    if level_data then
        local data = level_data[tostring(id)]
        local pos = data.pos
        local position = Vector3(pos[1], pos[2], pos[3])
        local network_manager = Managers.state.network
        local unit_id = network_manager:unit_game_object_id(unit)
        
        if data.rot then
            local rot = data.rot
            local rotation = QuaternionBox(0, 0, 0, 0)
            QuaternionBox.store(rotation, rot[1], rot[2], rot[3], rot[4])
            local rotation = QuaternionBox.unbox(rotation)
            network_manager.network_transmit:send_rpc_server("rpc_teleport_unit_to", unit_id, position, rotation)
        else
            network_manager.network_transmit:send_rpc_server("rpc_teleport_unit_to", unit_id, position, Unit.local_rotation(unit, 0))
        end
    else
        mod:echo("ID: " .. tostring(id) .. " doesn't exist.")
    end
end

Teleport.restore = function(self, db)
	self._db = db
end

Teleport.set_level = function(self, level)
    self._level = level
    self:create_level_db(level)
end

Teleport._level = function(self)
    return self._level
end

Teleport.create_level_db = function(self, level)
    if not self._db then
        self._db = {}
    end
    
    local level_data = self._db[tostring(self._level)]
    if level_data == nil then
        self._db[tostring(self._level)] = {}
    end
end

Teleport.create_id = function(self, id)
    local level_data = self._db[tostring(self._level)]
	if level_data then
        level_data[tostring(id)] = {}
    end
end

Teleport.exist_id = function(self, id)
    local level_data = self._db[tostring(self._level)]
    if level_data then
        local data = level_data[tostring(id)]
        
        if data then
            return true
        else
            return false
        end  
    end
    return "DB not found"
end

Teleport.populate_id = function(self, id, position, rotation)
    local level_data = self._db[tostring(self._level)]
	if level_data then
		local data = level_data[tostring(id)]
		
        if data then
            data.pos = {
                position[1],
                position[2],
                position[3],
            }
            mod:echo("Populated " .. tostring(Vector3(position[1], position[2], position[3])) .. " in ID: " .. tostring(id))
        end
        if data and rotation then
            data.rot = {
                rotation[1],
                rotation[2],
                rotation[3],
                rotation[4],
            }
            mod:echo("Populated Vector4( " .. tostring(rotation[1]) .. ", " .. tostring(rotation[2]) .. ", " .. tostring(rotation[3]) .. ", " .. tostring(rotation[4]) .. ") in ID: " .. tostring(id))
        end
	end
end

Teleport.destroy_id = function(self, id)
	local level_data = self._db[tostring(self._level)]
	if level_data then
        level_data[tostring(id)] = nil
        mod:echo("Destroyed ID: " .. tostring(id))
	end
end

Teleport.update_db = function(self)
    mod:set("db", self._db)
end

--[[Teleport.get_ids = function(self, level)
    local your_db_var = mod:get("db") or {}
    return your_db_var
end]]