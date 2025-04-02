function on_entity_built(event)
    entity = event.entity
    quality = entity.quality
    if not quality.valid then
        return
    end
    if not entity.is_updatable then
        -- not sure how this could happen, but it could.
        return
    end
    if quality.level > 0 then
        entity.disabled_by_script = true
    end
end

event_filter = {{filter="name", name="einstein-factory"}}
script.on_event(defines.events.on_built_entity, on_entity_built, event_filter)
script.on_event(defines.events.on_robot_built_entity, on_entity_built, event_filter)
script.on_event(defines.events.on_space_platform_built_entity, on_entity_built, event_filter)
script.on_event(defines.events.script_raised_built, on_entity_built, event_filter)
