
    SMODS.Joker({
        key = 'pickaxe',
        atlas = 'bld_trinkets',
        pos = {x = 2, y = 3},
        rarity = 'bld_doodad',
        cost = 7,
        blueprint_compat = true,
        eternal_compat = true,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
        calculate = function(self, card, context)
            if context.discard and context.other_card == context.full_hand[#context.full_hand] and context.hook == false then 
                if G.GAME.current_round.discards_left == 1 then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    return {
                        extra = {focus = card, message = localize('k_dug_ex'), func = function()
                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = (function()
                                        local card = create_card('bld_obj_mineral',G.consumeables, nil, nil, nil, nil, nil, 'pickaxe')
                                        card:add_to_deck()
                                        G.consumeables:emplace(card)
                                        G.GAME.consumeable_buffer = 0
                                    return true
                                end)}))
                        end},
                        colour = G.C.SECONDARY_SET.bld_obj_mineral,
                        card = card
                    }
                end
            end
        end
    })