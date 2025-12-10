
    SMODS.Joker({
        key = 'award',
        atlas = 'bld_trinkets',
        pos = {x = 2, y = 1},
        rarity = 'bld_curio',
        config = {
            extra = {
                money = 3,
            }
        },
        cost = 10,
        blueprint_compat = false,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.money
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
            if context.individual and context.end_of_round and context.cardarea == G.hand then
                local other_card = context.other_card
                if other_card:is_color("Yellow") and not other_card.debuff then
                    G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                    G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                    return {
                        dollars = card.ability.extra.money,
                        card = card
                    }
                end
            end
        end
    })