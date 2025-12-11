SMODS.Consumable {
    key = 'pentagram',
    set = 'bld_obj_ritual',
    atlas = 'bld_consumable',
    config = {
        extra = {
            removed = 2,
            chosen = 5,
        }
    },
    can_use = function (self, card)
        return G.hand and #G.hand.cards > 0
    end,
    pos = {x=0, y=3},
    use = function(self, card, area)
        local chosen_cards = {}
        local choices = {}
        for key, value in pairs(G.hand.cards) do
            table.insert(choices, value)
        end
        while #chosen_cards < card.ability.extra.chosen and #choices > 0 do
            local choices2 = {}
            for key, value in pairs(choices) do
                table.insert(choices2, value)
            end

            local card = pseudorandom_element(choices, pseudoseed('sacrifice'))
            table.insert(chosen_cards, card)

            choices = {}
            for key, value in pairs(choices2) do
                if value ~= card then
                    table.insert(choices, value)
                end
            end
        end

        local destroyed_cards = {}
        choices = {}
        for key, value in pairs(chosen_cards) do
            table.insert(choices, value)
        end
        while #destroyed_cards < card.ability.extra.removed and #choices > 0 do
            local choices2 = {}
            for key, value in pairs(choices) do
                table.insert(choices2, value)
            end

            local card = pseudorandom_element(choices, pseudoseed('sacrifice'))
            table.insert(destroyed_cards, card)

            choices = {}
            for key, value in pairs(choices2) do
                if value ~= card then
                    table.insert(choices, value)
                end
            end
        end

        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true end }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function() 
                for i=#destroyed_cards, 1, -1 do
                    local card = destroyed_cards[i]
                    if card.ability.name == 'Glass Card' then 
                        card:shatter()
                    else
                        card:start_dissolve(nil, i == #destroyed_cards)
                    end
                end
                return true end }))
        delay(0.3)
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = destroyed_cards})
        end

        for key, value in pairs(chosen_cards) do
            if not tableContains(value, destroyed_cards) then
                upgrade_blind(value)
            end
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.removed,
                card.ability.extra.chosen
            }
        }
    end
}