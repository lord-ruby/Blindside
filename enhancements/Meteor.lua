    SMODS.Enhancement({
        key = 'meteor',
        atlas = 'bld_blindrank',
        pos = {x = 5, y = 4},
        config = {
            extra = {
                value = 16,
                chips_mod = 300,
                hues = {"Blue"}
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
            ["bld_obj_blindcard_single"] = true,
            ["bld_obj_blindcard_blue"] = true,
        },
        calculate = function(self, card, context) 
            if context.cardarea == G.play and context.main_scoring then
            if context.scoring_name == 'bld_blind_high' then
                return {
                    chips = card.ability.extra.chips_mod
                }
            else 
                if card.facing ~= 'back' then 
                card:flip()
                end
                return {
                    message = localize('k_nope_ex'),
                    colour = G.C.BLUE
                }
            end
        end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.chips_mod
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
