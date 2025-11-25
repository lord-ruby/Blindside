
    SMODS.Joker({
        key = 'fineart',
        atlas = 'bld_trinkets',
        pos = {x = 2, y = 4},
        rarity = 'bld_hobby',
        config = {
            extra = {
                money = 1,
                colors = {"Red", "Green", "Blue", "Purple", "Yellow"},
                colorstring = {G.C.RED, G.C.GREEN, G.C.BLUE, G.C.PURPLE, G.C.MONEY},
                colorID = 1
            }
        },
        cost = 8,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.money,
                card.ability.extra.colors[card.ability.extra.colorID],
                colours = {
                    card.ability.extra.colorstring[card.ability.extra.colorID]
            },
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
            if context.individual and context.cardarea == G.play then 
                if context.other_card:is_color(card.ability.extra.colors[card.ability.extra.colorID]) and context.other_card.facing ~= "back" then
                    card.ability.extra_value = card.ability.extra_value + card.ability.extra.money
                    card:set_cost()
                    return {
                        message = localize('k_val_up'),
                        colour = G.C.MONEY,
                        card = card,
                    }
                end
            end
            if context.end_of_round and not context.blueprint then
                card.ability.extra.colorID = pseudorandom('fineart', 1, 5)
            end
        end
    })