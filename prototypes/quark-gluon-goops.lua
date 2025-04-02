-- Items
-- Need items for 1mg, 1g, and 1kg
-- 1mg from the factory, and 1g to have a "hop" between 1g and 1kg
data:extend({
    {
        type = "item",
        name = "quark-gluon-goop-1mg",
        icon = "__einstein-factory__/graphics/quark-gluon-goop/icon.png",
        subgroup = "intermediate-product",
        stack_size = 1000000, -- 1 million, aka 1KG
        weight = 1 -- would be 0.001 if I could, this is 1g
    }
})
data:extend({
    {
        type = "item",
        name = "quark-gluon-goop-1g",
        icon = "__einstein-factory__/graphics/quark-gluon-goop/icon.png", -- TODO: Icon for 1g goop
        subgroup = "intermediate-product",
        stack_size = 100000, -- 1000 times the stack size of the 1kg
        weight = 1 -- 1g
    }
})
data:extend({
    {
        type = "item",
        name = "quark-gluon-goop-1kg",
        icon = "__einstein-factory__/graphics/quark-gluon-goop/icon.png", -- TODO: Icon for 1kg goop
        subgroup = "intermediate-product",
        stack_size = 100, -- Seemed like a good value to use.
        weight = 1000 -- 1kg
    }
})
-- Recipe
-- Note: This recipe at crafting speed 1 needs 90GW.
-- I'm debating making it 90 seconds instead, then giving einstein-factory a crafting speed of 90.
-- But that will just be kinda confusing.
data:extend({
    {
        type = "recipe",
        name = "quark-gluon-goop-1mg",
        energy_required = 1,
        category = "einstein-factory",
        enabled = false,
        ingredients = {}, -- No ingredients. Create matter out of nothing.
        results = {{type="item", name="quark-gluon-goop-1mg", amount=1}},
        maximum_productivity=0,
        hide_from_player_crafting = false,
        allow_consumption = false,
        allow_speed = false,
        allow_productivity = false,
        allow_pollution = false,
        allow_quality = false
    }
})
data:extend({
    {
        type = "recipe",
        name = "quark-gluon-goop-1g",
        energy_required = 1,
        category = "advanced-crafting",
        enabled = false,
        ingredients = {{type="item", name="quark-gluon-goop-1mg", amount=1000}}, 
        results = {{type="item", name="quark-gluon-goop-1g", amount=1}},
        maximum_productivity=0,
        hide_from_player_crafting = false,
        allow_consumption = true,
        allow_speed = true,
        allow_productivity = false,
        allow_pollution = true,
        allow_quality = false
    }
})
data:extend({
    {
        type = "recipe",
        name = "quark-gluon-goop-1kg",
        energy_required = 1,
        category = "advanced-crafting",
        enabled = false,
        ingredients = {{type="item", name="quark-gluon-goop-1g", amount=1000}}, 
        results = {{type="item", name="quark-gluon-goop-1kg", amount=1}},
        maximum_productivity=0,
        hide_from_player_crafting = false,
        allow_consumption = true,
        allow_speed = true,
        allow_productivity = false,
        allow_pollution = true,
        allow_quality = false
    }
})
-- Technology: Not here, will be part of the Einstein Factory tech