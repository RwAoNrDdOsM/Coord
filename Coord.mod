return {
	run = function()
		fassert(rawget(_G, "new_mod"), "Coord must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("Coord", {
			mod_script       = "scripts/mods/Coord/Coord",
			mod_data         = "scripts/mods/Coord/Coord_data",
			mod_localization = "scripts/mods/Coord/Coord_localization"
		})
	end,
	packages = {
		"resource_packages/Coord/Coord"
	}
}
