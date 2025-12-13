    SMODS.Enhancement({
        key = 'wall',
        atlas = 'bld_blindrank',
        pos = {x = 1, y = 1},
        config = {
            extra = {
                value = 12,
                x_mult = 0.5,
                x_mult_bonus = 0.25,
                hues = {"Purple"}
            }},
        replace_base_card = true,
        no_rank = true,
        no_suit = true,
        overrides_base_rank = true,
        always_scores = true,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
        pools = {
            ["bld_obj_blindcard_generate"] = true,
            ["bld_obj_blindcard_cool"] = true,
            ["bld_obj_blindcard_single"] = true,
            ["bld_obj_blindcard_purple"] = true,
        },
        weight = 3,
        loc_vars = function(self, info_queue, card)
            return {
                key = card.ability.extra.upgraded and 'm_bld_wall_upgraded' or 'm_bld_wall',
                vars = {
                    card.ability.extra.x_mult, card.ability.extra.x_mult_bonus
                }
            }
        end,
        calculate = function(self, card, context)
                if context.cardarea == G.play and context.after and card.facing ~= 'back' then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "x_mult_bonus",
                    operation = '+',
                    message_colour = G.C.PURPLE
                })
                end
                if (context.cardarea == G.play or (card.ability.extra.upgraded and context.cardarea == G.hand)) and context.main_scoring then
                    return {
                        xmult = card.ability.extra.x_mult
                    }
                end
        end,
        upgrade = function(card)
            if not card.ability.extra.upgraded then
            card.ability.extra.upgraded = true
            end
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
