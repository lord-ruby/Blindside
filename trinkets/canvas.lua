
    SMODS.Joker({
        key = 'canvas',
        atlas = 'bld_trinkets',
        pos = {x = 2, y = 0},
        rarity = 'bld_hobby',
        config = {
            extra = {
                mult_mod = 8
            }
        },
        cost = 8,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_SEALS["bld_wild"]
            return {
                vars = {
                card.ability.extra.mult_mod
            }
        }
        end,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                    if G.playing_cards then
                        for i = 1, #G.playing_cards do
                            if G.playing_cards[i].seal == 'bld_wild' then
                                return true
                            end
                        end
                    end
            else
            return false
            end
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play and context.other_card.seal == "bld_wild" and context.other_card.facing ~= "back" then
                return {
                    mult = card.ability.extra.mult_mod
                }
            end
        end
    })