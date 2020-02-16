minetest.register_node("spleef:spleef_normal", {
    description = "Spleef Cube",
    drawtype = "glasslike_framed",
    tiles = {"spleef_normal.png"},
    paramtype = "light",
    is_ground_content = false,
    sunlight_propagates = true,
    sounds = default.node_sound_glass_defaults(),
    groups = {cracky=5},
    mesecons = {
      conductor = {
		    state = mesecon.state.off,
		    onstate = "spleef:spleef_gone",
		    rules = mesecon.rules.alldirs
	     }
     }


})


minetest.register_node("spleef:spleef_fire", {
    description = "Spleef Fire Cube",
    drawtype = "glasslike_framed",
    tiles = {"spleef_fire.png"},
    paramtype = "light",
    is_ground_content = false,
    sunlight_propagates = true,
    sounds = default.node_sound_glass_defaults(),
    groups = {not_in_creative_inventory=1},
    drop = "spleef:spleef_normal",
    mesecons = {
      conductor = {
		    state = mesecon.state.off,
		    onstate = "spleef:spleef_gone",
		    rules = mesecon.rules.alldirs
	     }
     }


})




minetest.register_on_punchnode(
	function(pos, node, puncher)
		if node.name == "spleef:spleef_normal" or node.name == "spleef:spleef_fire" then
      local r = math.random(1,20)
      if r < 15 then
         minetest.add_node(pos, {name = "spleef:spleef_flashing"})
      end
      if r > 15 then
        minetest.add_node(pos, {name = "spleef:spleef_fire"})
      end

		end
	end
)




minetest.register_node("spleef:spleef_flashing", {
  description = "Flashing Spleef Cube",
  drawtype = "glasslike_framed",
  light_source = 5,

  paramtype =  "light",
  tiles = {{
		name = "spleef_flashing.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = .5,
		}
	}},
  groups = {not_in_creative_inventory=1},
  drop = "spleef:spleef_normal",

})


minetest.register_node("spleef:spleef_gone", {
    description = "Dematerialized Spleef Cube",
    drawtype = "airlike",
    paramtype = "light",
    sunlight_propagates = true,

    walkable     = false,
    pointable    = false,
    diggable     = false,
    buildable_to = false,


    air_equivalent = true,
    drop = "spleef:spleef_normal",
    groups = {not_in_creative_inventory=1},
    mesecons = {
      conductor = {
        state = mesecon.state.on,
        offstate = "spleef:spleef_normal",
        rules = mesecon.rules.alldirs
       }
     }


})


minetest.register_abm({
  nodenames = {"spleef:spleef_flashing"},
  interval = 2,
  chance = 2,
  action = function(pos)
    minetest.add_node(pos, {name = "spleef:spleef_gone"})
  end,
})


minetest.register_abm({
  nodenames = {"spleef:spleef_gone"},
  interval = 10,
  chance = 20,
  action = function(pos)
    minetest.add_node(pos, {name = "spleef:spleef_normal"})
  end,
})

minetest.register_abm({
  nodenames = {"spleef:spleef_fire"},
  interval = 2,
  chance = 2,
  action = function(pos)
    pos.y = pos.y + 1
    minetest.add_node(pos, {name = "fire:basic_flame"})

  end,
})


minetest.register_craft({
    type = "shapeless",
    output = "spleef:spleef_normal",
    recipe = {
        "default:obsidian_glass",
        "default:mese_crystal_fragment",
        "default:coal_lump",
    },
})
