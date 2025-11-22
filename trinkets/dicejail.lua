
    SMODS.Joker({
        key = 'dicejail',
        atlas = 'bld_trinkets',
        pos = {x = 4, y = 4},
        rarity = 'bld_hobby',
        config = {
            extra = {
                money = 2,
            }
        },
        cost = 9,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.money,
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
            if context.pseudorandom_result and not context.result then
            return {
                dollars = card.ability.extra.money,
                juice_card = context.blueprint_card or card
            }
            end
        end
    })