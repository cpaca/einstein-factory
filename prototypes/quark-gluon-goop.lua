-- Item
data:extend({
    {
        type = "item",
        name = "quark-gluon-goop-1mg",
        icon = "__einstein-factory__/graphics/quark-gluon-goop/icon.png",
        subgroup = "intermediate-product",
        stack_size = 1000000, -- 1 million, aka 1KG
        weight = 1 -- would be 0.001 if I could
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
        category = "einstein-factory", -- TODO: Add this crafting category
        enabled = false,
        ingredients = {}, -- No ingredients. Create matter out of nothing.
        results = {{type="item", name="quark-gluon-goop-1mg", amount=1}},
        allow_consumption = false,
        allow_speed = false,
        allow_productivity = false,
        allow_pollution = false,
        allow_quality = false
    }
})
-- Technology: Not here, will be part of the Einstein Factory tech