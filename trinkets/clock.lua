
    SMODS.Joker({
        key = 'clock',
        atlas = 'bld_trinkets',
        pos = {x = 0, y = 1},
        rarity = 'bld_doodad',
        config = {
            extra = {
                chips = 120,
                count = 0,
            }
        },
        cost = 7,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                vars = {
                card.ability.extra.chips,
                3 - card.ability.extra.count
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
            if context.joker_main and card.ability.extra.count == 2 then
                card.ability.extra.count = 0
                return {
                    chips = card.ability.extra.chips
                }
            end
            if context.before and not context.blueprint and card.ability.extra.count < 2 then
                card.ability.extra.count = card.ability.extra.count+1
                card:juice_up()
                return {}
            end
        end
    })