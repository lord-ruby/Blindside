    SMODS.Enhancement({
        key = 'bite',
        atlas = 'bld_blindrank',
        pos = {x = 6, y = 5},
        config = {
            xmult = 1.5,
            extra = {
                value = 11,
                hues = {"Purple"}
            }},
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
        pools = {
            ["bld_obj_blindcard_single"] = true,
            ["bld_obj_blindcard_purple"] = true,
        },
        calculate = function(self, card, context)
            if context.cardarea == G.play and context.before and card.facing ~= 'back' then
                local self_pos = -1
                for i=1, #context.scoring_hand do
                    if context.scoring_hand[i] == card then
                        self_pos = i
                        break
                    end
                end

                if G.play.cards[self_pos-1] then
                    if G.play.cards[self_pos-1].facing ~= 'back' then 
                        G.play.cards[self_pos-1]:flip()
                    end
                    G.play.cards[self_pos-1]:set_debuff(true)
                end
            end
            if context.cardarea == G.play and context.main_scoring then
                return {
                    xmult = card.ability.xmult
                }
            end

            if card.ability.extra.debuffed_blind and context.cardarea == G.play and context.after then
                local self_pos = nil
                for i=1, #G.play.cards do
                    if G.play.cards[i] == card then
                        self_pos = i
                    end
                end
                if G.play.cards[self_pos-1] then
                    G.play.cards[self_pos-1]:set_debuff(false)
                end
            end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.xmult
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
