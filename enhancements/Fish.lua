    SMODS.Enhancement({
        key = 'fish',
        atlas = 'bld_blindrank',
        pos = {x = 7, y = 0},
        config = {
            extra = {
                value = 10,
                chips_gain = 0.3,
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
        pools = {
            ["bld_obj_blindcard_generate"] = true,
            ["bld_obj_blindcard_cool"] = true,
            ["bld_obj_blindcard_single"] = true,
            ["bld_obj_blindcard_blue"] = true,
        }, -- Thank you Ortalab :P
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.main_scoring then
            local chip_return = 1
            local step = 0
            for i, held_card in pairs(G.hand.cards) do
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            held_card:juice_up()
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
            return {
                xchips = chip_return
            }            
            end
            if context.cardarea == G.play and context.after then
                card.ability.chips = 0
            end
            if context.burn_card and context.cardarea == G.play and context.burn_card == card and context.burn_card.facing ~= 'back' then
                return { remove = true }
            end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.chips_gain
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
