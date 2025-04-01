out = {}
-- Note: I am opting to use the original filenames (even if this is an einstein factory, not a quantum stab)
-- because that way, if Hurricane updates their graphics, I don't need to fix the filenames.

-- Icon
out["icon"] = "__einstein-factory__/graphics/einstein-factory/quantum-stabilizer-icon.png"
out["icon_size"] = 64

-- Graphics set
out["graphics_set"] = {
    animation = {
        -- This is an Animation4Way, but that is either a struct of Animations or - in this case - just an Animation.
        stripes = { -- Array of stripes
            { -- Stripe: Frames 1-64
                filename = "__einstein-factory__/graphics/einstein-factory/quantum-stabilizer-hr-animation-1.png",
                width_in_frames = 8,
                height_in_frames = 8
            },
            { -- Stripe: Frames 65-100 
                filename = "__einstein-factory__/graphics/einstein-factory/quantum-stabilizer-hr-animation-1.png",
                width_in_frames = 8,
                height_in_frames = 5
            }
        },
        frame_count = 100,
        width = 410,
        height = 410,
        scale = 0.5
    },
    working_visualisations = {
        -- Array of working visualizations
        -- Is there only 1?
        {
            animation = {
                stripes = {
                    {
                        filename = "__einstein-factory__/graphics/einstein-factory/quantum-stabilizer-hr-emission-1.png",
                        width_in_frames = 8,
                        height_in_frames = 8
                    },
                    {
                        filename = "__einstein-factory__/graphics/einstein-factory/quantum-stabilizer-hr-emission-2.png",
                        width_in_frames = 8,
                        height_in_frames = 5
                    }
                },
                frame_count = 100,
                width = 410,
                height = 410,
                scale = 0.5,
                blend_mode = "additive"
            }
        }
    }
}

return out