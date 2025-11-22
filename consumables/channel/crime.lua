SMODS.Consumable {
    key = 'crime',
    set = 'bld_obj_filmcard',
    atlas = 'bld_consumable',
    pos = {x=5, y=1},
    config = {
        extra = 1
    },
    use = function(self, card, area)
        G.E_MANAGER:add_event(Event({
            func = function()
                local new_cards = {}
                local cards = {}
                for i = 1, card.ability.extra do
                    local enhancement = pseudorandom_element(G.P_CENTER_POOLS.bld_obj_blindcard_dual, 'crime')
                    cards[i] = SMODS.add_card { set = "Base", enhancement = enhancement.key }
                end
                SMODS.calculate_context({ playing_card_added = true, cards = cards })
                return true
            end
        })) 
        delay(0.3)
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra
            }
        }
    end,
    can_use = function(self, card)
        return G.hand
    end,
}