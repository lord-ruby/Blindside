
    SMODS.Joker({
        key = 'mask',
        atlas = 'bld_trinkets',
        pos = {x = 3, y = 3},
        rarity = 'bld_curio',
        cost = 10,
        blueprint_compat = true,
        eternal_compat = true,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
        calculate = function(self, card, context)
            if context.game_over and not context.blueprint and context.end_of_round then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card:start_dissolve()
                        if G.GAME.dollars ~= 0 then
                            ease_dollars(-G.GAME.dollars, true)
                        end
                        return true
                    end
                })) 
                G.GAME.saved_text = localize('ph_mask_saved')
                return {
                    message = localize('k_saved_ex'),
                    saved = 'ph_mask_saved',
                    colour = G.C.RED
                }
            end
        end
    })