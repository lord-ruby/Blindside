SMODS.Enhancement({
    key = 'beta',
    atlas = 'bld_blindrank',
    pos = {x = 0, y = 7},
    config = {
        extra = {
            value = 1,
            chips = 100,
            hues = {"Blue"},
        }},
    replace_base_card = true,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    overrides_base_rank = true,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                chips = card.ability.extra.chips
            }
        end
        if context.end_of_round then
            card:start_dissolve()
        end
    end,
    in_pool = function(self, args)
        if G.GAME.selected_back.effect.center.config.extra then
            if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
            return true
        else
        return false
        end
    end,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.bonus
            }
        }
    end
})
----------------------------------------------
------------MOD CODE END----------------------
