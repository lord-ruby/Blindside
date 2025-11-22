
    SMODS.Joker({
        key = 'pendant',
        atlas = 'bld_trinkets',
        pos = {x = 1, y = 2},
        rarity = 'bld_curio',
        config = {
            extra = {
                astralbonus = 1,
            }
        },
        cost = 8,
        blueprint_compat = false,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS['bld_astral']
            return {
                vars = {
                card.ability.extra.astralbonus + 1,
            }
        }
        end,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                    if G.playing_cards then
                        for i = 1, #G.playing_cards do
                            if G.playing_cards[i].seal == 'bld_astral' then
                                return true
                            end
                        end
                    end
            else
            return false
            end
        end
    })