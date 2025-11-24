    SMODS.Enhancement({
        key = 'bones',
        atlas = 'bld_blindrank',
        pos = {x = 6, y = 3},
        config = {
            extra = {
                value = 100,
                chance = 3,
                hues = {"Green", "Faded"}
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
            ["bld_obj_blindcard_cool"] = true,
            ["bld_obj_blindcard_warm"] = true,
            ["bld_obj_blindcard_dual"] = true,
            ["bld_obj_blindcard_green"] = true,
            ["bld_obj_blindcard_faded"] = true,
        },
        calculate = function(self, card, context)
                if context.cardarea == G.play and context.before then
		            G.GAME.probabilities.normal = G.GAME.probabilities.normal + card.ability.extra.chance
                end
                if context.cardarea == G.play and context.after then
		            G.GAME.probabilities.normal = G.GAME.probabilities.normal - card.ability.extra.chance
                end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.chance
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
