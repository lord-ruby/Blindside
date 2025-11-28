    SMODS.Enhancement({
        key = 'hoard',
        atlas = 'bld_blindrank',
        pos = {x = 8, y = 2},
        config = {
            extra = {
                value = 13,
                mult = 5,
                xmult = 1.5,
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
        pools = {
            ["bld_obj_blindcard_generate"] = true,
            ["bld_obj_blindcard_warm"] = true,
            ["bld_obj_blindcard_single"] = true,
            ["bld_obj_blindcard_red"] = true,
        },
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.main_scoring then
                if #G.jokers.cards + G.GAME.joker_buffer <= 3 then
                    return {
                        mult = card.ability.extra.mult,
                        xmult = card.ability.extra.xmult
                    }
                else
                    return {
                        mult = card.ability.extra.mult
                    }
                end
            end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.mult, card.ability.extra.xmult
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
