
    SMODS.Joker({
        key = 'statuette',
        atlas = 'bld_trinkets',
        pos = {x = 6, y = 4},
        rarity = 'bld_curio',
        config = {
            extra = {
                chips = 50,
            }
        },
        cost = 8,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.chips,
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
            if context.individual and context.cardarea == G.play and context.other_card:is_color("Faded") and context.other_card.facing ~= "back" then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    })