--[[
    Mobs Dwarves - Adds dwarves.
    Copyright (C) 2018  Hamlet

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]


--
-- General variables
--

local mob_difficulty = tonumber(minetest.settings:get("mob_difficulty"))
if (mob_difficulty == nil) then
	 mob_difficulty = 1
end


--
-- Chat messages
--

local MESSAGE_1 = "Saluton "
local MESSAGE_2 = ", mia nomo estas "


--
-- Functions
--

local function dps(self, seconds)
	local hit_points = nil
	local time_speed = nil
	local in_game_day_length = nil
	local in_game_minutes = nil
	local damage_per_second = nil

	hit_points = self.health
	time_speed = tonumber(minetest.settings:get("time_speed"))

	if (time_speed == nil) then
		time_speed = 72
	elseif (time_speed == 0) then
		time_speed = 1
	end

	in_game_day_length = 86400 / time_speed
	in_game_minutes = (in_game_day_length * seconds) / 86400
	damage_per_second = hit_points / in_game_minutes

	return damage_per_second
end


local function random_class(self)
	local class = math.random(1, 20)

	if (class >= 1) and (class < 10) then
		-- self.nametag = "Dwarf Miner"
		self.hp_min = 20 * mob_difficulty
		self.hp_max = 35 * mob_difficulty

		local shovel_or_pick = math.random(0, 1)

		if (shovel_or_pick == 0) then
			local shovel_type = math.random(1, 4)

			if (shovel_type == 1) then
				self.damage = 3 * mob_difficulty
				self.drops = {
					{
						name = "default:shovel_steel",
						chance = 4,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "a1"

			elseif (shovel_type == 2) then
				self.damage = 3 * mob_difficulty
				self.drops = {
					{
						name = "default:shovel_bronze",
						chance = 5,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "a2"

			elseif (shovel_type == 3) then
				self.damage = 4 * mob_difficulty
				self.drops = {
					{
						name = "default:shovel_mese",
						chance = 6,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "a3"

			else
				self.damage = 4 * mob_difficulty
				self.drops = {
					{
						name = "default:shovel_diamond",
						chance = 7,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "a4"
			end

		else
			local pick_type = math.random(1, 4)

			if (pick_type == 1) then
				self.damage = 4 * mob_difficulty
				self.drops = {
					{
						name = "default:pick_steel",
						chance = 4,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "a5"

			elseif (pick_type == 2) then
				self.damage = 4 * mob_difficulty
				self.drops = {
					{
						name = "default:pick_bronze",
						chance = 5,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "a6"


			elseif (pick_type == 3) then
				self.damage = 5 * mob_difficulty
				self.drops = {
					{
						name = "default:pick_mese",
						chance = 6,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "a7"


			else
				self.damage = 5 * mob_difficulty
				self.drops = {
					{
						name = "default:pick_diamond",
						chance = 7,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "a8"
			end
		end

		self.water_damage = dps(self, 120)
		self.light_damage = dps(self, 300)
		self.runaway_from = {
			"mobs:balrog",
			"mobs_monster:dungeon_master",
			"mobs_monster:fireball",
			"mobs_monster:mese_monster",
			"mobs_monster:mese_arrow"
		}

		if minetest.get_modpath("real_minerals") then
			self.replace_what = {"default:stone_with_coal",
				"default:stone_with_iron",
				"default:stone_with_copper", "default:stone_with_tin",
				"default:stone_with_mese", "default:stone_with_gold",
				"default:stone_with_diamond",
				"real_minerals:anthracite_in_default_stone",
				"real_minerals:bauxite_in_default_stone",
				"real_minerals:bismuthinite_in_default_stone",
				"real_minerals:bituminous_coal_in_default_stone",
				"real_minerals:cassiterite_in_default_stone",
				"real_minerals:cinnabar_in_default_stone",
				"real_minerals:cryolite_in_default_stone",
				"real_minerals:galena_in_default_stone",
				"real_minerals:garnierite_in_default_stone",
				"real_minerals:graphite_in_default_stone",
				"real_minerals:gypsum_in_default_stone",
				"real_minerals:hematite_in_default_stone",
				"real_minerals:jet_in_default_stone",
				"real_minerals:kaolinite_in_default_stone",
				"real_minerals:kimberlite_in_default_stone",
				"real_minerals:lazurite_in_default_stone",
				"real_minerals:lignite_in_default_stone",
				"real_minerals:limonite_in_default_stone",
				"real_minerals:magnetite_in_default_stone",
				"real_minerals:malachite_in_default_stone",
				"real_minerals:native_copper_in_default_stone",
				"real_minerals:native_copper_in_desert_stone",
				"real_minerals:native_gold_in_default_stone",
				"real_minerals:native_gold_in_desert_stone",
				"real_minerals:native_platinum_in_default_stone",
				"real_minerals:native_silver_in_default_stone",
				"real_minerals:olivine_in_default_stone",
				"real_minerals:petrified_wood_in_default_stone",
				"real_minerals:pitchblende_in_default_stone",
				"real_minerals:saltpeter_in_default_stone",
				"real_minerals:satin_spar_in_default_stone",
				"real_minerals:selenite_in_default_stone",
				"real_minerals:serpentine_in_default_stone",
				"real_minerals:sphalerite_in_default_stone",
				"real_minerals:sylvite_in_default_stone",
				"real_minerals:tenorite_in_default_stone",
				"real_minerals:tetrahedrite_in_default_stone",
			}
		else
			self.replace_what = {"default:stone_with_coal",
				"default:stone_with_iron",
				"default:stone_with_copper", "default:stone_with_tin",
				"default:stone_with_mese", "default:stone_with_gold",
				"default:stone_with_diamond"
			}
		end

		self.replace_with = "default:cobble"
		self.replace_rate = 4
		self.replace_offset = -1

		self.object:set_properties({
			-- nametag = self.nametag,
			hp_min = self.hp_min,
			hp_max = self.hp_max,
			damage = self.damage,
			drops = self.drops,
			class_and_tool = self.class_and_tool,
			water_damage = self.water_damage,
			light_damage = self.light_damage,
			runaway_from = self.runaway_from,
			replace_what = self.replace_what,
			replace_with = self.replace_with,
			replace_rate = self.replace_rate,
			replace_offset = self.replace_offset
		})

	elseif (class > 9) and (class < 15) then
		-- self.nametag = "Dwarf Soldier"
		self.hp_min = 35 * mob_difficulty
		self.hp_max = 50 * mob_difficulty
		self.armor = 85
		self.walk_chance = 33
		self.view_range = 10

		local axe_or_sword = math.random(0, 1)

		if (axe_or_sword == 0) then
			local axe_type = math.random(1, 4)

			if (axe_type == 1) then
				self.damage = 4 * mob_difficulty
				self.drops = {
					{
						name = "default:axe_steel",
						chance = 4,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "b1"

			elseif (axe_type == 2) then
				self.damage = 4 * mob_difficulty
				self.drops = {
					{
						name = "default:axe_bronze",
						chance = 5,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "b2"

			elseif (axe_type == 3) then
				self.damage = 6 * mob_difficulty
				self.drops = {
					{
						name = "default:axe_mese",
						chance = 6,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "b3"

			else
				self.damage = 7 * mob_difficulty
				self.drops = {
					{
						name = "default:axe_diamond",
						chance = 7,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "b4"

			end

		else
			local sword_type = math.random(1, 4)

			if (sword_type == 1) then
				self.damage = 6 * mob_difficulty
				self.drops = {
					{
						name = "default:sword_steel",
						chance = 4,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "b5"

			elseif (sword_type == 2) then
				self.damage = 6 * mob_difficulty
				self.drops = {
					{
						name = "default:sword_bronze",
						chance = 5,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "b6"

			elseif (sword_type == 3) then
				self.damage = 7 * mob_difficulty
				self.drops = {
					{
						name = "default:sword_mese",
						chance = 6,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "b7"

			else
				self.damage = 8 * mob_difficulty
				self.drops = {
					{
						name = "default:sword_diamond",
						chance = 7,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "b8"
			end
		end

		self.fear_height = 3
		self.water_damage = dps(self, 180)
		self.light_damage = dps(self, 300)
		self.attack_monsters = true
		self.runaway_from = {
			"mobs:balrog"
		}
		self.sounds = {
			war_cry = "mobs_dwarves_die_yell",
			death = "mobs_dwarves_death",
			attack = "mobs_dwarves_slash_attack"
		}

		self.object:set_properties({
			-- nametag = self.nametag,
			hp_min = self.hp_min,
			hp_max = self.hp_max,
			armor = self.armor,
			walk_chance = self.walk_chance,
			view_range = self.view_range,
			damage = self.damage,
			drops = self.drops,
			class_and_tool = self.class_and_tool,
			fear_height = self.fear_height,
			water_damage = self.water_damage,
			light_damage = self.light_damage,
			attack_monsters = self.attack_monsters,
			runaway_from = self.runaway_from,
			sounds = self.sounds
		})

	elseif (class > 14) and (class < 20) then
		-- self.nametag = "Dwarf Marksman"
		self.hp_min = 20 * mob_difficulty
		self.hp_max = 35 * mob_difficulty
		self.walk_chance = 33
		self.view_range = 15
		self.damage = 2
		self.fear_height = 3
		self.class_and_tool = "c"
		self.water_damage = dps(self, 180)
		self.light_damage = dps(self, 300)
		self.attack_monsters = true
		self.attack_type = "dogshoot"
		self.arrow = "mobs_dwarves:crossbow_bolt"
		self.shoot_offset = 1.9
		self.shoot_interval = 3
		self.runaway_from = {
			"mobs:balrog"
		}
		self.sounds = {
			war_cry = "mobs_dwarves_die_yell",
			death = "mobs_dwarves_death",
			attack = "mobs_dwarves_punch",
			random = "mobs_dwarves_crossbow_reload",
			shoot_attack = "mobs_dwarves_crossbow_click"
		}

		self.object:set_properties({
			-- nametag = self.nametag,
			hp_min = self.hp_min,
			hp_max = self.hp_max,
			walk_chance = self.walk_chance,
			view_range = self.view_range,
			damage = self.damage,
			class_and_tool = self.class_and_tool,
			fear_height = self.fear_height,
			water_damage = self.water_damage,
			light_damage = self.light_damage,
			attack_monsters = self.attack_monsters,
			attack_type = self.attack_type,
			arrow = self.arrow,
			shoot_offset = self.shoot_offset,
			shoot_interval = self.shoot_interval,
			runaway_from = self.runaway_from,
			sounds = self.sounds
		})

	else
		-- self.nametag = "Dwarf Paladine"
		self.hp_min = 35 * mob_difficulty
		self.hp_max = 70 * mob_difficulty
		self.armor = 70
		self.walk_chance = 66
		self.view_range = 10

		local axe_or_sword = math.random(0, 1)

		if (axe_or_sword == 0) then
			local axe_type = math.random(1, 4)

			if (axe_type == 1) then
				self.damage = 4 + 2
				self.drops = {
					{
						name = "default:axe_steel",
						chance = 4,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "d1"

			elseif (axe_type == 2) then
				self.damage = 4 + 2
				self.drops = {
					{
						name = "default:axe_bronze",
						chance = 5,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "d2"

			elseif (axe_type == 3) then
				self.damage = 6 + 2
				self.drops = {
					{
						name = "default:axe_mese",
						chance = 6,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "d3"

			else
				self.damage = 7 + 2
				self.drops = {
					{
						name = "default:axe_diamond",
						chance = 7,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "d4"
			end

		else
			local sword_type = math.random(1, 4)

			if (sword_type == 1) then
				self.damage = 6 + 2
				self.drops = {
					{
						name = "default:sword_steel",
						chance = 4,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "d5"

			elseif (sword_type == 2) then
				self.damage = 6 + 2
				self.drops = {
					{
						name = "default:sword_bronze",
						chance = 5,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "d6"

			elseif (sword_type == 3) then
				self.damage = 7 + 2
				self.drops = {
					{
						name = "default:sword_mese",
						chance = 6,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "d7"

			else
				self.damage = 8 + 2
				self.drops = {
					{
						name = "default:sword_diamond",
						chance = 7,
						min = 1,
						max = 1
					}
				}
				self.class_and_tool = "d8"
			end
		end

		self.fear_height = 5
		self.water_damage = dps(self, 240)
		self.light_damage = dps(self, 300)
		self.attack_monsters = true
		self.sounds = {
			war_cry = "mobs_dwarves_die_yell",
			death = "mobs_dwarves_death",
			attack = "mobs_dwarves_slash_attack"
		}

		self.object:set_properties({
			-- nametag = self.nametag,
			hp_min = self.hp_min,
			hp_max = self.hp_max,
			armor = self.armor,
			walk_chance = self.walk_chance,
			view_range = self.view_range,
			damage = self.damage,
			drops = self.drops,
			class_and_tool = self.class_and_tool,
			fear_height = self.fear_height,
			water_damage = self.water_damage,
			light_damage = self.light_damage,
			attack_monsters = self.attack_monsters,
			sounds = self.sounds
		})

	end
end


local function random_appearence(class)

	local class_and_tool = class
	local appearence = {}
	local chosen_skin = nil
	local chosen_armour = "mobs_dwarves_trans.png"
	local chosen_weapon = nil

	local skins = {
		"mobs_dwarves_dwarf.png",
		"mobs_dwarves_dwarf_1.png",
		"mobs_dwarves_dwarf_2.png",
		"mobs_dwarves_dwarf_3.png"
	}

	local ARMOUR = "mobs_dwarves_chestplate_steel.png" .. "^" ..
		"mobs_dwarves_leggings_steel.png" .. "^" ..
		"mobs_dwarves_boots_steel.png"

	local ARMOUR_HELMET = "mobs_dwarves_chestplate_steel.png" .. "^" ..
		"mobs_dwarves_leggings_steel.png" .. "^" ..
		"mobs_dwarves_boots_steel.png" .. "^" ..
		"mobs_dwarves_helmet_steel.png"

	local ARMOUR_SHIELD = "mobs_dwarves_chestplate_steel.png" .. "^" ..
		"mobs_dwarves_leggings_steel.png" .. "^" ..
		"mobs_dwarves_boots_steel.png" .. "^" ..
		"mobs_dwarves_shield_steel.png"

	local ARMOUR_HELMET_SHIELD = "mobs_dwarves_chestplate_steel.png" .. "^" ..
		"mobs_dwarves_leggings_steel.png" .. "^" ..
		"mobs_dwarves_boots_steel.png" .. "^" ..
		"mobs_dwarves_helmet_steel.png" .. "^" ..
		"mobs_dwarves_shield_steel.png"

	local armours = {
		ARMOUR,
		ARMOUR_HELMET,
		ARMOUR_SHIELD,
		ARMOUR_HELMET_SHIELD
	}

	local GOLDEN_ARMOUR = "mobs_dwarves_chestplate_gold.png" .. "^" ..
		"mobs_dwarves_leggings_gold.png" .. "^" ..
		"mobs_dwarves_boots_gold.png"

	local GOLDEN_ARMOUR_HELMET = "mobs_dwarves_chestplate_gold.png" .. "^" ..
		"mobs_dwarves_leggings_gold.png" .. "^" ..
		"mobs_dwarves_boots_gold.png" .. "^" ..
		"mobs_dwarves_helmet_gold.png"

	local GOLDEN_ARMOUR_SHIELD = "mobs_dwarves_chestplate_gold.png" .. "^" ..
		"mobs_dwarves_leggings_gold.png" .. "^" ..
		"mobs_dwarves_boots_gold.png" .. "^" ..
		"mobs_dwarves_shield_gold.png"

	local GOLDEN_ARMOUR_HELMET_SHIELD = "mobs_dwarves_chestplate_gold.png" ..
		"^" .. "mobs_dwarves_leggings_gold.png" .. "^" ..
		"mobs_dwarves_boots_gold.png" .. "^" ..
		"mobs_dwarves_helmet_gold.png" .. "^" ..
		"mobs_dwarves_shield_gold.png"

	local golden_armours = {
		GOLDEN_ARMOUR,
		GOLDEN_ARMOUR_HELMET,
		GOLDEN_ARMOUR_SHIELD,
		GOLDEN_ARMOUR_HELMET_SHIELD
	}

	chosen_skin = skins[math.random(1, 4)]

	if (class_and_tool == "a1") then
		chosen_weapon = "default_tool_steelshovel.png"

	elseif (class_and_tool == "a2") then
		chosen_weapon = "default_tool_bronzeshovel.png"

	elseif (class_and_tool == "a3") then
		chosen_weapon = "default_tool_meseshovel.png"

	elseif (class_and_tool == "a4") then
		chosen_weapon = "default_tool_diamondshovel.png"

	elseif (class_and_tool == "a5") then
		chosen_weapon = "default_tool_steelpick.png"

	elseif (class_and_tool == "a6") then
		chosen_weapon = "default_tool_bronzepick.png"

	elseif (class_and_tool == "a7") then
		chosen_weapon = "default_tool_mesepick.png"

	elseif (class_and_tool == "a8") then
		chosen_weapon = "default_tool_diamondpick.png"

	elseif (class_and_tool == "b1") then
		chosen_weapon = "default_tool_steelaxe.png"
		chosen_armour = armours[math.random(1, 4)]

	elseif (class_and_tool == "b2") then
		chosen_weapon = "default_tool_bronzeaxe.png"
		chosen_armour = armours[math.random(1, 4)]

	elseif (class_and_tool == "b3") then
		chosen_weapon = "default_tool_meseaxe.png"
		chosen_armour = armours[math.random(1, 4)]

	elseif (class_and_tool == "b4") then
		chosen_weapon = "default_tool_diamondaxe.png"
		chosen_armour = armours[math.random(1, 4)]

	elseif (class_and_tool == "b5") then
		chosen_weapon = "default_tool_steelsword.png"
		chosen_armour = armours[math.random(1, 4)]

	elseif (class_and_tool == "b6") then
		chosen_weapon = "default_tool_bronzesword.png"
		chosen_armour = armours[math.random(1, 4)]

	elseif (class_and_tool == "b7") then
		chosen_weapon = "default_tool_mesesword.png"
		chosen_armour = armours[math.random(1, 4)]

	elseif (class_and_tool == "b8") then
		chosen_weapon = "default_tool_diamondsword.png"
		chosen_armour = armours[math.random(1, 4)]

	elseif (class_and_tool == "c") then
		chosen_weapon = "mobs_dwarves_crossbow_loaded.png^[transformR45"

	elseif (class_and_tool == "d1") then
		chosen_weapon = "default_tool_steelaxe.png"
		chosen_armour = golden_armours[math.random(1, 4)]

	elseif (class_and_tool == "d2") then
		chosen_weapon = "default_tool_bronzeaxe.png"
		chosen_armour = golden_armours[math.random(1, 4)]

	elseif (class_and_tool == "d3") then
		chosen_weapon = "default_tool_meseaxe.png"
		chosen_armour = golden_armours[math.random(1, 4)]

	elseif (class_and_tool == "d4") then
		chosen_weapon = "default_tool_diamondaxe.png"
		chosen_armour = golden_armours[math.random(1, 4)]

	elseif (class_and_tool == "d5") then
		chosen_weapon = "default_tool_steelsword.png"
		chosen_armour = golden_armours[math.random(1, 4)]

	elseif (class_and_tool == "d6") then
		chosen_weapon = "default_tool_bronzesword.png"
		chosen_armour = golden_armours[math.random(1, 4)]

	elseif (class_and_tool == "d7") then
		chosen_weapon = "default_tool_mesesword.png"
		chosen_armour = golden_armours[math.random(1, 4)]

	elseif (class_and_tool == "d8") then
		chosen_weapon = "default_tool_diamondsword.png"
		chosen_armour = golden_armours[math.random(1, 4)]

	end
	
	table.insert(appearence, 1, chosen_skin)
	table.insert(appearence, 2, chosen_armour)
	table.insert(appearence, 3, chosen_weapon)
	table.insert(appearence, 4, "mobs_dwarves_trans.png")

	return appearence
end


local function heal_over_time(self, dtime)
	-- For backward compatibility
	if (self.heal_counter == nil)
	or (self.initial_hp == nil)
	or (self.injuried == nil)
	then
		self.heal_counter = 4.0
		-- used for health recovery

		self.initial_hp = math.random(self.hp_min, self.hp_max)
		-- used as reference when recovering health

		-- used to determine whether if in need of healing
		if (self.health == self.initial_hp) then
			self.injuried = false

		else
			self.injuried = true

		end

		self.object:set_properties({
			heal_counter = self.heal_counter,
			initial_hp = self.initial_hp,
			injuried = self.injuried
		})
	end

	if (self.injuried == true) then
		if (self.state ~= "attack") and (self.state ~= "runaway") then
			-- recover 1HP every 4 seconds
			if (self.health < self.initial_hp) then
				if (self.heal_counter > 0) then
					self.heal_counter = self.heal_counter - dtime

					self.object:set_properties({
						heal_counter = self.heal_counter
					})

				else
					self.heal_counter = 4.0
					self.health = self.health + 1
					self.object:set_hp(self.health)

					self.object:set_properties({
						heal_counter = self.heal_counter
					})

				end

			elseif (self.health == self.initial_hp) then
				self.injuried = false

				self.object:set_properties({injuried = self.injuried})
			end
		end
	end
end


local function experience(self)
	if (self.attack == nil) and (self.engaged ~= true) then
		return

	elseif (self.attack ~= nil) and (self.engaged ~= true) then
		self.engaged = true

		self.object:set_properties({engaged = self.engaged})

	elseif (self.attack == nil) and (self.engaged == true) then
		self.engaged = false

		self.object:set_properties({engaged = self.engaged})

		if (self.damage < (8 * mob_difficulty)) then
			self.damage = self.damage + 1
			self.object:set_properties({damage = self.damage})
		end

		if (self.armor > 10) then
			self.armor = self.armor - 1
			self.object:set_properties({armor = self.armor})
		end
	end
end


local function random_string(length)

	local letter = 0
	local number = 0
	local initial_letter = true
	local string = ""
	local exchanger = ""
	local forced_choice = ""
	local vowels = {"a", "e", "i", "o", "u"}
	local semivowels = {"y", "w"}

	local simple_consonants = {
		"m", "n", "b", "p", "d", "t", "g", "k", "l", "r", "s", "z", "h"
	}

	local compound_consonants = {
		"ñ", "v", "f", "ð", "þ", "ɣ", "ħ", "ɫ", "ʃ", "ʒ"
	}

	local compound_consonants_uppercase = {
		"Ñ", "V", "F", "Ð", "Þ", "Ɣ", "Ħ", "Ɫ", "Ʃ", "Ʒ"
	}

	local double_consonants = {
		"mm", "mb", "mp", "mr", "ms", "mz", "mf",
		"mʃ",
		"nn", "nd", "nt", "ng", "nk", "nr", "ns", "nz",
		"nð", "nþ", "nɣ", "nħ", "nʃ", "nʒ",
		"bb", "bl", "br", "bz",
		"bʒ",
		"pp", "pl", "pr", "ps",
		"pʃ",
		"dd", "dl", "dr", "dz",
		"dʒ",
		"tt", "tl", "tr", "ts",
		"tʃ",
		"gg", "gl", "gr", "gz",
		"gʒ",
		"kk", "kl", "kr", "ks",
		"kʃ",
		"ll", "lm", "ln", "lb", "lp", "ld", "lt", "lg", "lk", "ls", "lz",
		"lñ", "lv", "lf", "lð", "lþ", "lɣ", "lħ", "lʃ", "lʒ",
		"rr", "rm", "rn", "rb", "rp", "rd", "rt", "rg", "rk", "rs", "rz",
		"rñ", "rv", "rf", "rð", "rþ", "rɣ", "rħ", "rʃ", "rʒ",
		"ss", "sp", "st", "sk",
		"sf",
		"zz", "zm", "zn", "zb", "zd", "zg", "zl", "zr",
		"zñ", "zv",
		"vl", "vr",
		"fl", "fr",
		"ðl", "ðr",
		"þl", "þr",
		"ɣl", "ɣr",
		"ħl", "ħr",
		"ʃp", "ʃt", "ʃk",
		"ʃf",
		"ʒm", "ʒn", "ʒb", "ʒd", "ʒg", "ʒl", "ʒr",
		"ʒv"
	}

	local double_consonants_uppercase = {
		"Bl", "Br", "Bz",
		"Bʒ",
		"Pl", "Pr", "Ps",
		"Pʃ",
		"Dl", "Dr", "Dz",
		"Dʒ",
		"Tl", "Tr", "Ts",
		"Tʃ",
		"Gl", "Gr", "Gz",
		"Gʒ",
		"Kl", "Kr", "Ks",
		"Kʃ",
		"Sp", "St", "Sk",
		"Sf",
		"Zm", "Zn", "Zb", "Zd", "Zg", "Zl", "Zr",
		"Zñ", "Zv",
		"Vl", "Vr",
		"Fl", "Fr",
		"Ðl", "Ðr",
		"Þl", "Þr",
		"Ɣl", "Ɣr",
		"Ħl", "Ħr",
		"Ʃp", "Ʃt", "Ʃk",
		"Ʃf",
		"Ʒm", "Ʒn", "Ʒb", "Ʒd", "Ʒg", "Ʒl", "Ʒr",
		"Ʒv"
	}

	local previous_letter = ""

	for initial_value = 1, length do

		letter = letter + 1

		local chosen_group = math.random(1, 5)

		if (exchanger == "vowel") then
			chosen_group = math.random(3, 5)

		elseif (exchanger == "semivowel") then
			chosen_group = 1

		elseif (exchanger == "simple consonant") then
			if (letter < length) then
				chosen_group = math.random(1, 2)
			else
				chosen_group = 1
			end

		elseif (exchanger == "compound consonant") then
			chosen_group = 1

		elseif (exchanger == "double consonant") then
			chosen_group = 1

		end


		if (chosen_group == 1) then

			if (initial_letter == true) then
				initial_letter = false
				number = math.random(1, 5)
				previous_letter = string.upper(vowels[number])
				string = string .. previous_letter

			else
				number = math.random(0, 1) -- single or double vowel

				if (number == 0) then
					number = math.random(1, 5)
					previous_letter = vowels[number]
					string = string .. previous_letter

				else
					number = math.random(1, 5)
					previous_letter = vowels[number]
					string = string .. previous_letter

					number = math.random(1, 5)
					previous_letter = vowels[number]
					string = string .. previous_letter

				end
			end

			exchanger = "vowel"


		elseif (chosen_group == 2) then

			number = math.random(1, 2)

			if (letter ~= 2) then
				if (initial_letter == true) then
					initial_letter = false
					previous_letter = string.upper(semivowels[number])
					string = string .. previous_letter
				else
					previous_letter = semivowels[number]
					string = string .. previous_letter

				end

				exchanger = "semivowel"

			elseif (letter == 2) then
				if (previous_letter == "L") or (previous_letter == "R")
				or (previous_letter == "Ɫ") or (previous_letter == "Y")
				or (previous_letter == "W") or (previous_letter == "H") then
					if (number == 1) then
						previous_letter = "i"
						string = string .. previous_letter

					elseif (number == 2) then
						previous_letter = "u"
						string = string .. previous_letter

					end
				end

				exchanger = "vowel"
			end


		elseif (chosen_group == 3) then

			number = math.random(1, 13)

			if (initial_letter == true) then
				initial_letter = false
				previous_letter = string.upper(simple_consonants[number])
				string = string .. previous_letter

			else
				previous_letter = simple_consonants[number]
				string = string .. previous_letter

			end

			exchanger = "simple consonant"


		elseif (chosen_group == 4) then

			number = math.random(1, 10)

			if (initial_letter == true) then
				initial_letter = false
				previous_letter = compound_consonants_uppercase[number]
				string = string .. previous_letter

			else
				previous_letter = compound_consonants[number]
				string = string .. previous_letter
			end

			exchanger = "compound consonant"


		elseif (chosen_group == 5) then

			if (initial_letter == true) then
				initial_letter = false
				number = math.random(1, 61)
				previous_letter = double_consonants_uppercase[number]
				string = string .. previous_letter

			else
				number = math.random(1, 131)
				previous_letter = double_consonants[number]
				string = string .. previous_letter
			end

			exchanger = "double consonant"

		end
	end

	initial_letter = true

	return string
end


--
-- Dwarf entity
--

mobs:register_mob("mobs_dwarves:dwarf", {
	nametag = "",
	type = "npc",
	hp_min = 20,
	hp_max = 20,
	armor = 100,
	passive = false,
	walk_velocity = 2.5,
	run_velocity = 3.5,
	walk_chance = 50,
	jump = false,
	view_range = 10,
	damage = 1,
	fear_height = 2,
	fall_damage = true,
	lava_damage = 9999,
	suffocation = true,
	floats = 0,
	attack_monsters = true,
	group_attack = true,
	attack_type = "dogfight",
	makes_footstep_sound = true,
	sounds = {
		war_cry = "mobs_dwarves_die_yell",
		death = "mobs_dwarves_death",
		attack = "mobs_dwarves_punch"
	},
	visual = "mesh",
	visual_size = {x = 1.1, y = 0.85},
	collisionbox = {-0.3, -.85, -0.3, 0.3, 0.68, 0.3},
	textures = "",
	mesh = "mobs_dwarves_character.b3d",
	animation = {
		stand_start = 0,
		stand_end = 80,
		stand_speed = 30,
		walk_start = 168,
		walk_end = 188,
		walk_speed = 30,
		run_start = 168,
		run_end = 188,
		run_speed = 35,
		punch_start = 189,
		punch_end = 199,
		punch_speed = 30
	},

	on_spawn = function(self)
		random_class(self)
		self.textures = random_appearence(self.class_and_tool)
		self.base_texture = self.textures

		self.heal_counter = 4.0
		self.injuried = false

		self.initial_hp = math.random(self.hp_min, self.hp_max)

		self.object:set_hp(self.initial_hp)

		self.given_name = random_string(math.random(2, 5))

		self.object:set_properties({
			heal_counter = self.heal_counter,
			initial_hp = self.initial_hp,
			injuried = self.injuried,
			textures = self.textures,
			base_texture = self.base_texture,
			given_name = self.given_name
		})
		return true
	end,

	on_rightclick = function(self, clicker)
		if (self.health > 0)
		and (self.state ~= "attack")
		and (self.state ~= "runaway")
		then
			local player_name = clicker:get_player_name()

			local msg = MESSAGE_1 .. player_name .. MESSAGE_2
				.. self.given_name .. "."
			minetest.chat_send_player(player_name, msg)
		end
	end,

	on_replace = function(self, pos, oldnode, newnode)
		local position = {x = pos.x, y = (pos.y +1), z = pos.z}
		minetest.set_node(position, {name="default:torch", param2 = 1})
	end,

	do_punch = function(self)
		if (self.health < self.initial_hp) and (self.injuried == false) then
			self.injuried = true

			self.object:set_properties({injuried = self.injuried})
		end
	end,

	do_custom = function(self, dtime)
		heal_over_time(self, dtime)
		experience(self)
	end
})


--
-- Projectiles
--

-- Crossbow Bolt

mobs:register_arrow("mobs_dwarves:crossbow_bolt", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"mobs_dwarves_crossbow_bolt.png"},
	velocity = 10,
	drop = false,

	hit_player = function(self, player)
		local pos = self.object:get_pos()
		local damage = 6 * mob_difficulty
		minetest.sound_play("mobs_dwarves_shoot", {pos = pos})
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = damage},
		}, nil)
	end,

	hit_mob = function(self, player)
		local pos = self.object:get_pos()
		local damage = 6 * mob_difficulty
		minetest.sound_play("mobs_dwarves_shoot", {pos = pos})
		player:punch(self.object, 1.0, {
			full_punch_interval = 1.0,
			damage_groups = {fleshy = damage},
		}, nil)
	end,

	hit_node = function(self, pos, node)
		self.object:remove()
	end
})


--
-- Spawner
--

mobs:spawn({
	name = "mobs_dwarves:dwarf",
	nodes = {
		"default:stone", "castle_masonry:pavement_brick",
		"dfcaverns:dirt_with_cave_moss", "dfcaverns:cobble_with_floor_fungus"
	},
	neighbors = "air",
	max_light = 13,
	min_light = 0,
	chance = 5000,
	active_object_count = 2,
	min_height = -31000,
	max_height = -300
})

-- Spawn Egg

mobs:register_egg("mobs_dwarves:dwarf", "Spawn Dwarf", "mobs_dwarves_icon.png")


--
-- Alias
--

mobs:alias_mob("mobs:dwarf", "mobs_dwarves:dwarf")


--
-- Minetest engine debug logging
--

if (minetest.settings:get("debug_log_level") == nil)
or (minetest.settings:get("debug_log_level") == "action")
or	(minetest.settings:get("debug_log_level") == "info")
or (minetest.settings:get("debug_log_level") == "verbose") then
	minetest.log("action", "[Mod] Mobs Dwarves [v0.1.1] loaded.")
end
