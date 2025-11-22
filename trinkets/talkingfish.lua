
    SMODS.Joker({
        key = 'talkingfish',
        atlas = 'bld_trinkets',
        pos = {x = 2, y = 5},
        rarity = 'bld_doodad',
        cost = 7,
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
            if context.joker_main then
                local nonblue = false
                for k, v in ipairs(context.scoring_hand) do
                    if not v:is_color('Blue', nil, true) then
                        nonblue = true
                        break
                    end
                end
                if not nonblue then
                    return {
                        extra = {focus = card, message = localize('k_hey_ex'), func = function()
                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = (function()
                                    ease_discard(1)
                                    return true
                                end)}))
                        end},
                        colour = G.C.RED,
                        card = card
                    }
                end
            end
        end
    })