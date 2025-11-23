    SMODS.Enhancement({
        key = 'pile',
        atlas = 'bld_blindrank',
        pos = {x = 1, y = 3},
        config = {
            extra = {
                value = 15,
                nonblue = 4,
                chips = 50,
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
        },
        calculate = function(self, card, context) 
            if context.cardarea == G.play and context.main_scoring then
                G.E_MANAGER:add_event(Event({ func = function()
                    local any_selected = nil
                    local _cards = {}
                    for k, v in ipairs(G.hand.cards) do
                        if not v:is_color("Blue") and v.config.center ~= G.P_CENTERS.m_bld_wedge then
                        _cards[#_cards+1] = v
                    end
                    end
                    local repetitions = 0
                    for i = 1, card.ability.extra.nonblue do
                        if G.hand.cards[i] then
                            local selected_card, card_key = pseudorandom_element(_cards, pseudoseed('pile'))
                            if not selected_card:is_color("Blue") and selected_card.config.center ~= G.P_CENTERS.m_bld_wedge then
                                G.hand:add_to_highlighted(selected_card, true)
                                table.remove(_cards, card_key)
                                any_selected = true
                                play_sound('card1', 1)
                            else
                                i = i-1
                                repetitions = repetitions + 1
                            end
                        end
                    end
                    card:juice_up()
                    if any_selected then G.FUNCS.discard_cards_from_highlighted(nil, true) end
                return true end }))
                return {
                    chips = card.ability.extra.chips
                }
            end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.nonblue, card.ability.extra.chips
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
