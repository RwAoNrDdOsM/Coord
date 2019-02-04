local mod = get_mod("Coord")

-- Everything here is optional. You can remove unused parts.
return {
	name = "Coord",                               -- Readable mod name
	description = mod:localize("mod_description"),  -- Mod description
	is_togglable = false,                            -- If the mod can be enabled/disabled
	is_mutator = false,                             -- If the mod is mutator
	mutator_settings = {},                          -- Extra settings, if it's mutator
	options = {
        widgets = {
            {
                setting_id    = "background",
                type          = "checkbox",
                default_value = false,
            },
            {
                setting_id      = "x",
                type            = "numeric",
                default_value   = 100,
                range           = {0, 1920},
                decimals_number = 0                            -- optional
            },
            {
                setting_id      = "y",
                type            = "numeric",
                default_value   = 100,
                range           = {0, 1080},
                decimals_number = 0                            -- optional
            },
            {
                setting_id      = "font_size",
                type            = "numeric",
                default_value   = 22,
                range           = {0, 32},
                decimals_number = 0                            -- optional
            },
        }
    }
}