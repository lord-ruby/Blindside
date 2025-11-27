    SMODS.Enhancement({
        key = 'deep',
        atlas = 'bld_blindrank',
        pos = {x = 1, y = 9},
        config = {
            extra = {
                xchips = 1.5,
                value = 1000,
                hues = {"Blue", "Faded"}
            }},
        replace_base_card = true,
        no_rank = true,
        no_suit = true,
        overrides_base_rank = true,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
                return false
            end
        end,
        --weight = 1,
        pools = {
            ["bld_obj_blindcard_generate"] = true,
            ["bld_obj_blindcard_cool"] = true,
            ["bld_obj_blindcard_dual"] = true,
            ["bld_obj_blindcard_blue"] = true,
            ["bld_obj_blindcard_faded"] = true,
        },
        calculate = function(self, card, context)
            if context.cardarea == G.hand and context.individual then
                if context.other_card:is_color("Blue") then
                    return {
                        xchips = card.ability.extra.xchips,
                        card = context.other_card
                    }
                end
            end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.xchips,
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
