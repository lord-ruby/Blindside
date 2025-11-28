    SMODS.Enhancement({
        key = 'spear',
        atlas = 'bld_blindrank',
        pos = {x = 9, y = 8},
        config = {
            extra = {
                value = 100,
                hues = {"Red", "Yellow"}
            }},
        pools = {
            ["bld_obj_blindcard_generate"] = true,
            ["bld_obj_blindcard_warm"] = true,
            ["bld_obj_blindcard_dual"] = true,
            ["bld_obj_blindcard_red"] = true,
            ["bld_obj_blindcard_yellow"] = true,
        },
        weight = 3,
        always_scores = true,
        replace_base_card = true,
        no_rank = true,
        no_suit = true,
        overrides_base_rank = true,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.main_scoring then
                if #context.scoring_hand >= 3 then
                    return {
                        focus = card,
                        message = localize('k_tagged_ex'),
                        func = function()
                            add_tag(Tag('tag_bld_strike'))
                        end,
                        card = card
                    }
                else
                    if card.facing ~= 'back' and context.cardarea == G.play then
                        card:flip()
                    end
                    return {
                        message = localize('k_nope_ex'),
                        colour = G.C.MONEY
                    }
                end
            end
            if context.burn_card == card and #context.scoring_hand >= 3 then
                return {
                    remove = true,
                }
            end
        end,
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue+1] = G.P_TAGS['tag_bld_strike']
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
