
    SMODS.Joker({
        key = 'flag',
        atlas = 'bld_trinkets',
        pos = {x = 3, y = 0},
        rarity = 'bld_keepsake',
        config = {
            extra = {
                Xmult = 1.25,
            }
        },
        cost = 10,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.Xmult,
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
            if context.individual and context.cardarea == G.play and context.other_card:is_color("Red") and context.other_card.facing ~= "back" then
                return {
                    xmult = card.ability.extra.Xmult
                }
            end
        end
    })