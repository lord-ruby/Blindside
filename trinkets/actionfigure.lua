
    SMODS.Joker({
        key = 'actionfigure',
        atlas = 'bld_trinkets',
        pos = {x = 9, y = 3},
        rarity = 'bld_keepsake',
        config = {
            extra = {
                mult = 4,
            }
        },
        cost = 7,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.mult
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
            if context.individual and context.cardarea == G.hand and not context.end_of_round  then
                local other_card = context.other_card
                if other_card:is_color("Red") and not other_card.debuff then
                    return {
                        h_mult = card.ability.extra.mult,
                        card = card
                    }
                end
            end
        end
    })