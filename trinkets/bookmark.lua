
    SMODS.Joker({
        key = 'bookmark',
        atlas = 'bld_trinkets',
        pos = {x = 3, y = 4},
        rarity = 'bld_curio',
        config = {
            extra = {
                xmult = 3
            }
        },
        cost = 15,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.xmult
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
            if context.joker_main and #G.deck.cards == 0 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    })