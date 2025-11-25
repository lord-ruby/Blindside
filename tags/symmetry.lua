SMODS.Tag {
    key = "symmetry",
    config = {
        chance = 1,
        trigger = 2,
    },
    hide_ability = false,
    atlas = 'bld_tag',
    pos = {x = 3, y = 0},
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
    loc_vars = function(self, info_queue, tag)
        return {
            vars = {
                1,
                2,
            }
        }
    end,
    apply = function(self, tag, context)
        if context.type == 'shop_start' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
                tag:yep('+', G.C.GREEN, function() 
                    return true end)
                tag.triggered = true
        end
        if context.type == 'scoring_card' and not (next(SMODS.find_card("j_bld_taglock")) and not (G.GAME.blind.boss or G.GAME.last_joker)) then
            if SMODS.pseudorandom_probability(tag, pseudoseed("flip"), 1, 2, 'flip') and context.card.flipped ~= true and context.context.main_scoring and context.context.cardarea == G.play then
                tag:juice_up()
                tag_area_status_text(tag, localize('k_again_ex'), G.C.FILTER, false, 0)
                SMODS.score_card(context.card, context.context)
            end
        end
    end,
    set_ability = function(self, tag) 
        tag.ability.chance = tag.config.chance
        tag.ability.trigger = tag.config.trigger
    end
}