SMODS.Joker({
    key = 'porcelaindoll',
    atlas = 'bld_trinkets',
    pos = {x = 1, y = 3},
    rarity = 'bld_hobby',
    config = {
        extra = {
            sell_value = 5,
        }
    },
    cost = 6,
    blueprint_compat = false,
    eternal_compat = true,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
            card.ability.extra.sell_value
        }
    }
    end,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            return true
        else
        return false
        end
    end,
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.other_card and not context.repetition then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.sell_value
            card:set_cost()
            return {
                message = localize('k_val_up'),
                colour = G.C.MONEY
            }
        end
        if context.after and context.scoring_hand and not context.blueprint and not context.other_card then
            if #context.scoring_hand >= 5 then
                G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                        func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                            return true; end})) 
                    return true
                end
                })) 
                return {
                    message = localize('k_broke_ex')
                }
            end
        end
    end,
})