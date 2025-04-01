-- TODO: Actual graphics
einstein_factory_icon = data["assembling-machine"]["cryogenic-plant"]["icon"]
einstein_factory_graphics = data["assembling-machine"]["cryogenic-plant"]["graphics_set"]

-- Item
data:extend({
    type = "item",
    name = "einstein-factory",
    icon = einstein_factory_icon,
    icon_size = 64,
    subgroup = "production-machine",
    order = "c[einstein-factory]",
    place_result = "einstein-factory",
    stack_size = 10,
    weight = 1000000, -- 1 full rocket. i might pick something else later. it's 90GW though so.
})
-- Recipe
data:extend({
    type = "recipe",
    name = "einstein-factory",
    enabled = false,
    energy_required = 60,
    ingredients = {
        {type = "item", name = "tungsten-plate", amount = 250},
        {type = "item", name = "tungsten-carbide", amount = 100},
        {type = "item", name = "carbon-fiber", amount = 150},
        {type = "item", name = "superconductor", amount = 250},
        {type = "item", name = "quantum-processor", amount = 500},
        {type = "item", name = "promethium-asteroid", amount = 100},
        {type = "fluid", name = "fluoroketone-cold", amount = 1000},
    },
    results = {{type = "item", name = "einstein-factory", amount = 1}}
})

-- Structure
data:extend({
    type = "assembling-machine",
    name = "einstein-factory",
    icon = einstein_factory_icon, -- TODO: get the quantum stabilizer icon
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player"},
    fast_replaceable_group = "einstein-factory",
    max_health = 500,
    -- TODO: Circuit stuff?
    collision_box = {{-2.8, -2.8}, {2.8, 2.8}},
    selection_box = {{-3.0, -3.0}, {3.0, 3.0}},
    heating_energy = "1MW",
    effect_receiver = {uses_module_effects = false, uses_beacon_effects = false, uses_surface_effects = false},
    module_slots = 0,
    allowed_effects = {},
    crafting_categories = {"einstein-factory"},
    crafting_speed = 1,
    energy_source = {
        type = "electric",
        usage_priority = "secondary-input",
        emissions_per_minut = {} -- I mean emissions don't really make sense, what would be emitting? CO2?
    },
    graphics_set = einstein_factory_graphics,
    fluid_boxes = {}, -- # no fluid input or output expected for this one.
    -- fluid_boxes_off_when_no_fluid_recipe = false,
    
})
-- TODO: Technology
-- TODO: Add the recipes for each "manufactured" item.
-- The prerequisite tech. This tech's price is the same as the root's.
-- I kinda wanna make it x5 but... that's 10k of each science pack for promethium, so nevermind.
prereq_tech_name = "promethium-science-pack"
prereq_tech = data["technology"][prereq_tech_name]
tech_price = {
    count = prereq_tech["unit"]["count"] * 1, -- right now i want *1, might want *2 in the future though
    ingredients = prereq_tech["ingredients"],
    time = prereq_tech["time"]
}

data:extend({
    type = "technology",
    name = "einstein-factory",
    icon = "__einstein-factory__/graphics/quark-gluon-goop/icon.png", -- TODO: Use the quantum stabilizer's icon. Probably the big version.
    icon_size = 64,
    effects = {
        {type = "unlock-recipe", recipe = "einstein-factory"},
        {type = "unlock-recipe", recipe = "quark-gluon-goop-1mg"},
    },
    prerequisites = {prereq_tech_name},
    unit = tech_price
})
-- TODO: Recipe category
data:extend({
    type = "recipe-category",
    name = "einstein-factory"
})
