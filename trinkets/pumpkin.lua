
    SMODS.Joker({
        key = 'pumpkin',
        atlas = 'bld_trinkets',
        pos = {x = 7, y = 1},
        rarity = 'bld_curio',
        cost = 8,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_SEALS["bld_spooky"]
            info_queue[#info_queue+1] = {key = 'bld_burn', set = 'Other'}
        end,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                    if G.playing_cards then
                        for i = 1, #G.playing_cards do
                            if G.playing_cards[i].seal == 'bld_spooky' then
                                return true
                            end
                        end
                    end
            else
            return false
            end
        end,
        calculate = function(self, card, context)
            if context.burn_card and context.cardarea == G.play and context.burn_card.seal == 'bld_spooky' and context.burn_card.facing ~= 'back' then
                return {
                    remove = true
                }
            end
        end
    })