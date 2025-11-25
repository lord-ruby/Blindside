
    SMODS.Joker({
        key = 'cellphone',
        atlas = 'bld_trinkets',
        pos = {x = 8, y = 2},
        rarity = 'bld_doodad',
        config = {
            extra = {
                xmult = 2,
                burned = false,
            }
        },
        cost = 7,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.xmult
            },
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
            if context.burning_card then 
                card.ability.extra.burned = true
                local eval = function() return card.ability.extra.burned end
                juice_card_until(card, eval, true)
            end
            if context.joker_main and card.ability.extra.burned then
                card.ability.extra.burned = false
                return {
                    xmult = card.ability.extra.xmult
                }
            end
            if context.end_of_round and not context.blueprint then
                card.ability.extra.burned = false
            end
        end
    })