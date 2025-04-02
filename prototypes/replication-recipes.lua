add_replication_recipe = require("lib.add_replication_recipe")

function assert_add_replication(item_name)
    message = add_replication_recipe({item_name=item_name})
    -- "could not find item" is allowed so that i can be lazy about checking if mods exist
    assert(message == "" or message == "Could not find a valid item", message)
end

assert_add_replication("holmium-ore")