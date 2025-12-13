    SMODS.Enhancement({
        key = 'flint',
        atlas = 'bld_blindrank',
        pos = {x = 6, y = 2},
        config = {
            h_mult = 5,
            p_dollars = 2,
            extra = {
                value = 13,
                hues = {"Yellow"},
                mult_gain = 5,
                dollar_gain = 2,
            }},
        pools = {
            ["bld_obj_blindcard_generate"] = true,
            ["bld_obj_blindcard_warm"] = true,
            ["bld_obj_blindcard_single"] = true,
            ["bld_obj_blindcard_yellow"] = true,
        },
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
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.h_mult, card.ability.p_dollars
                }
            }
        end,
        upgrade = function(card) 
            if not card.ability.extra.upgraded then
            card.ability.p_dollars = card.ability.p_dollars + card.ability.extra.dollar_gain
            card.ability.h_mult = card.ability.h_mult + card.ability.extra.mult_gain
            card.ability.extra.upgraded = true
            end
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
