
    SMODS.Joker({
        key = 'doubloon',
        atlas = 'bld_trinkets',
        pos = {x = 4, y = 1},
        rarity = 'bld_curio',
        config = {
            extra = {
                retriggers = 1,
            }
        },
        cost = 10,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.retriggers,
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
            if context.repetition and context.cardarea == G.play and context.other_card and context.other_card:is_color("Green") and context.other_card.facing ~= "back" then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.retriggers,
                    card = card
                }
            end
        end
    })