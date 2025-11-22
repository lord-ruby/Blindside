
    SMODS.Joker({
        key = 'cellphone',
        atlas = 'bld_trinkets',
        pos = {x = 8, y = 2},
        rarity = 'bld_doodad',
        config = {
            extra = {
                money = 1,
                colors = {"Red", "Green", "Blue", "Purple", "Yellow"},
                colorstring = {G.C.RED, G.C.GREEN, G.C.BLUE, G.C.PURPLE, G.C.MONEY},
                colorID = 1
            }
        },
        cost = 7,
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
            if context.discard then 
                if context.other_card:is_color(card.ability.extra.colors[card.ability.extra.colorID]) and context.other_card.facing ~= "back" then
                    return {
                        dollars = card.ability.extra.money
                    }
                end
            end
            if context.end_of_round and not context.blueprint then
                card.ability.extra.colorID = pseudorandom('discount', 1, 6)
            end
        end
    })