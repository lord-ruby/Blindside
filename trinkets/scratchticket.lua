
    SMODS.Joker({
        key = 'scratchticket',
        atlas = 'bld_trinkets',
        pos = {x = 0, y = 3},
        rarity = 'bld_keepsake',
        config = {
            extra = {
                chance = 1,
                trigger = 10,
                money = 10,
                chanceadd = 0,
                colorsplayed = {}
            }
        },
        cost = 7,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            local chance, trigger = SMODS.get_probability_vars(card, card.ability.extra.chance, card.ability.extra.trigger, 'flag')
            return {
                vars = {
                card.ability.extra.money,
                chance,
                trigger,
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
            if context.individual and context.cardarea == G.play and context.other_card.facing ~= "back" and not context.blueprint then
                local hascolor = false
                for i=1, #card.ability.extra.colorsplayed do
                    if context.other_card:is_color(card.ability.extra.colorsplayed[i]) then
                        hascolor = true
                        card.ability.extra.chanceadd = card.ability.extra.chanceadd + 1 
                        break
                    end
                end
                if not hascolor then
                    for k=1, #context.other_card.config.center.config.extra.hues do
                        table.insert(card.ability.extra.colorsplayed,context.other_card.config.center.config.extra.hues[k] )
                    end
                end
            end
            if context.joker_main and SMODS.pseudorandom_probability(card, pseudoseed("flip"), card.ability.extra.chance+card.ability.extra.chanceadd, card.ability.extra.trigger, 'flip') then
                return {
                    dollars = card.ability.extra.money
                }
            end
            if context.after and not context.blueprint then
                card.ability.extra.colorsplayed = {}
                card.ability.extra.chanceadd = 0
            end
        end
    })