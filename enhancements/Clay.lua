    SMODS.Enhancement({
        key = 'clay',
        atlas = 'bld_blindrank',
        pos = {x = 8, y = 5},
        config = {
            extra = {
                xmult = 0.2,
                discards = 1,
                value = 10,
                hues = {"Red"}
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
        weight = 3,
        pools = {
            ["bld_obj_blindcard_generate"] = true,
            ["bld_obj_blindcard_warm"] = true,
            ["bld_obj_blindcard_single"] = true,
            ["bld_obj_blindcard_red"] = true,
        },
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.main_scoring then
                if #G.exhaust.cards > 0 then
                    return {
                        xmult = 1 + card.ability.extra.xmult*#G.exhaust.cards
                    }
                end
            end
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
            return {
                vars = {
                    card.ability.extra.xmult,
                    1 + card.ability.extra.xmult*#G.exhaust.cards
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
