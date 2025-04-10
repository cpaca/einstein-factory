einstein_factory_tech = data.raw["technology"]["einstein-factory"]

function get_localised_item_name(item)
    -- Note: "or {}" will be used so that if the localised item name isn't defined (means it's nil) then it'll default
    -- to {}, which in all cases means "search for another fallback"
    -- This uses the checks listed here: https://wiki.factorio.com/Tutorial:Localisation

    -- Check 1: Search for a given localised_item_name
    localised_item_name = item["localised_item_name"] or {}
    if table_size(localised_item_name) ~= 0 then
        -- log("Used localised item name 1")
        return localised_item_name
    end

    -- Checks 2 and 3 require a place_result
    place_result = item["place_result"] or {}
    if table_size(place_result) ~= 0 then
        localised_name = place_result["localised_name"] or {}
        if table_size(localised_name) ~= 0 then
            -- log("Used localised item name 2")
            return localised_name
        else
            -- log("Used localised item name 3")
            return {"entity-name." .. place_result["name"]}
        end
    end

    -- Checks 4 and 5 require a placed_as_equipment_result
    placed_as_equipment_result = item["placed_as_equipment_result"] or {}
    if table_size(placed_as_equipment_result) ~= 0 then
        localised_name = placed_as_equipment_result["localised_name"] or {}
        if table_size(localised_name) ~= 0 then
            -- log("Used localised item name 4")
            return localised_name
        else
            -- log("Used localised item name 5")
            return {"equipment-name." .. placed_as_equipment_result["name"]}
        end
    end

    -- Check 6 is the "final fallback" where it gives up:
    -- log("Used localised item name 6")
    return {"item-name." .. item["name"]}
end

function get_weights(weight_mg)
    out = {}
    -- get grams from milligrams
    weight_g  = weight_mg / 1000
    weight_mg = weight_mg % 1000
    out["weight_mg"] = math.floor(weight_mg)

    -- get kilograms from grams
    weight_kg = weight_g / 1000
    weight_g  = weight_g % 1000
    out["weight_g"] = math.floor(weight_g)

    -- Final weight: Just use it directly
    out["weight_kg"] = math.floor(weight_kg)

    return out
end

function add_replication_recipe(args) 
    -- Parameters:
    -- item or item_name: Either a data.raw["item"][item_name] object, or the name of an item that is already in data.raw.
    -- weight: If this is provided, this weight (in grams) will be used as the object's effective weight.
    -- creation: If this is truthy (ie: not nil or false), the recipe added will be creation, not duplication (ie: create from nothing)
    -- Return type:
    -- If this returns the empty string "", then adding a replication recipe for the item was successful.
    -- If anything else is returned, then the return value is a message about why adding a replication recipe failed.
    item = args["item"]
    if not item then
        -- effectively "if item is nil" - ie, no arg for item
        -- try item name?
        item = args["item_name"]
    end

    if type(item) == "string" then
        -- then item is an item name (maybe from item_name, maybe just item="item's name")
        item = data.raw["item"][item]
    end

    if type(item) ~= "table" then
        return "Could not find a valid item"
    end
    if item["type"] ~= "item" then
        return "add_replication_recipe is only valid on item prototypes (not fluids, entities, or recipes)"
    end
    item_name = item["name"]
    if type(item_name) ~= "string" then
        return "Could not get a valid item_name"
    end

    -- Here, item and item_name are likely valid

    -- This recipe is what will be given to data:extend
    recipe_name = item_name .. "-qgg-replication" -- needed for the tech, too
    is_replication = not args["creation"]
    if is_replication then
        num_results = 2
    else
        num_results = 1
    end
    recipe = {
        type = "recipe",
        name = recipe_name,
        category = "cryogenics", 
        enabled = false, -- TODO: default should be false (do this when the tech is added)
        energy_required = 1,
        -- ingredients is set later 
        results = {{type="item", name=item_name, amount=num_results}},
        hide_from_player_crafting = false,
        auto_recycle = false,
        allow_consumption = true,
        allow_speed = true,
        allow_productivity = false,
        allow_pollution = true,
        allow_quality = false,
    }

    -- next, we need the item's weight so we know how much qgg is needed.
    weight = args["weight"]
    if type(weight) ~= "number" or weight <= 0 then
        -- First fallback: The item's direct weight
        weight = item["weight"]
    end
    if type(weight) ~= "number" or weight <= 0 then
        -- Second fallback: The UtilityConstant default item weight
        weight = data.raw["utility-constants"]["default"]["default_item_weight"]
    end
    if type(weight) ~= "number" or weight <= 0 then
        -- Third fallback: A hardcoded value of a kilogram
        weight = 1000
    end
    if type(weight) ~= "number" or weight <= 0 then
        -- Fourth fallback: This literally shouldn't be possible given what the last fallback says
        return ("Couldn't calculate a weight for item " .. item_name)
    end
    
    -- here, weight is a valid number (is the item's weight, in grams)
    ingredients = {}
    if is_replication then
        table.insert(ingredients, {type="item", name=item_name, amount=1})
    end
    weights = get_weights(weight * 1000)
    weight_mg = weights["weight_mg"]
    weight_g =  weights["weight_g"]
    weight_kg = weights["weight_kg"]
    if weight_mg >= 1 then
        table.insert(ingredients, {type="item", name="quark-gluon-goop-1mg", amount=weight_mg})
    end
    if weight_g >= 1 then
        table.insert(ingredients, {type="item", name="quark-gluon-goop-1g", amount=weight_g})
    end
    if weight_kg >= 1 then
        table.insert(ingredients, {type="item", name="quark-gluon-goop-1kg", amount=weight_kg})
    end
    recipe["ingredients"] = ingredients

    -- validate the tech:
    if type(einstein_factory_tech) ~= "table" then
        return "Couldn't find the einstein factory tech (wait for the technology to be initialized first)"
    end
    if type(einstein_factory_tech["effects"]) ~= "table" then
        return "Einstein factory tech apparantly doesn't have any effects? (Is some other mod messing with it?)"
    end
    -- here, einstein_factory_tech["effects"] is a legal table (and the tech is valid)

    -- Calculate the recipe's localised_name
    localised_item_name = get_localised_item_name(item)
    log("Localised item name:")
    log(serpent.block(localised_item_name))
    recipe["localised_name"] = {"recipe-name.qgg-item-replication", localised_item_name}

    -- Here, we start manipulating things in data.lua
    -- Because of that, DO NOT return ANYTHING here. Except at the end, when everything is complete, where you can return ""
    -- Add the replication recipe:
    data:extend({recipe})

    -- Edit the tech
    table.insert(einstein_factory_tech["effects"], {type="unlock-recipe", recipe=recipe_name})

    -- Successfully added recipe!
    return ""
end

return add_replication_recipe