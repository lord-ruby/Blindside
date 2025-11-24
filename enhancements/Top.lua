    SMODS.Enhancement({
        key = 'top',
        atlas = 'bld_blindrank',
        pos = {x = 4, y = 8},
        config = {
            extra = {
                value = 100,
                chips_gain = 4,
                chip_return = 0,
                chips = 0,
                hues = {"Blue", "Purple"}
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
            ["bld_obj_blindcard_dual"] = true,
            ["bld_obj_blindcard_blue"] = true,
            ["bld_obj_blindcard_purple"] = true,
        }, -- Thank you Ortalab :P  
        calculate = function(self, card, context)
            if context.before and context.cardarea == G.play and card.facing ~= 'back'  then
            local chip_return = 0
            local step = 0
            for i, held_card in pairs(G.hand.cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        func = function()
                            held_card:juice_up()
                            held_card:flip()
                            held_card:flip()
                            play_sound('chips1', 0.8 + (step * 0.05))
                            card:juice_up()
                            G.ROOM.jiggle = G.ROOM.jiggle + 0.7    
                            return true
                        end
                    }))
                step = step + 5
                chip_return = chip_return + card.ability.extra.chips_gain
            end
                card.ability.extra.chip_return = chip_return
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chip_return",
                    operation = '+',
                    message_colour = G.C.BLUE
                })
            end
            if context.cardarea == G.play and context.main_scoring then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.chips_gain,card.ability.extra.chips
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
