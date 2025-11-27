    SMODS.Enhancement({
        key = 'fruit',
        atlas = 'bld_blindrank',
        pos = {x = 2, y = 3},
        config = {
            rescore = 0,
            extra = {
                value = 100,
                rescore = 1,
                hues = {"Red","Faded"}
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
        weight = 3,
        pools = {
            ["bld_obj_blindcard_generate"] = true,
            ["bld_obj_blindcard_warm"] = true,
            ["bld_obj_blindcard_dual"] = true,
            ["bld_obj_blindcard_red"] = true,
            ["bld_obj_blindcard_faded"] = true,
        },
        calculate = function(self, card, context)
                if context.cardarea == G.play and context.before and card.facing ~= 'back' then
                    local self_pos = nil
                    for i=1, #G.play.cards do
                        if G.play.cards[i] == card then
                            self_pos = i
                        end
                    end
                    if G.play.cards[self_pos-1] then
                        if G.play.cards[self_pos-1].facing ~= 'back' then 
                        G.play.cards[self_pos-1]:flip()
                        end
                        G.play.cards[self_pos-1]:set_debuff(true)
                    end
                    if G.play.cards[self_pos+1] then
                        if G.play.cards[self_pos+1].facing ~= 'back' then 
                        G.play.cards[self_pos+1]:flip()
                        end
                        G.play.cards[self_pos+1]:set_debuff(true)
                    end
                end
            if context.cardarea == G.play and context.main_scoring and context.scoring_hand then
                return {
                        func = function()
                                local retrigger_cards = {}
                                for i=1, #context.scoring_hand do
                                    if context.scoring_hand[i]:is_color("Red") and context.scoring_hand[i] ~= card then
                                    table.insert(retrigger_cards, context.scoring_hand[i])
                                    end
                                end
                                if #retrigger_cards then
                                for streak_index = 1, #retrigger_cards do
                                    local streak_card = retrigger_cards[streak_index]
                                    for _, play_card in ipairs(G.play.cards) do
                                        if play_card == streak_card and play_card.ability.extra.rescore ~= 1 then
                                        card:juice_up()
                                    card_eval_status_text(card, 'extra', nil, nil, nil, {
                                        message = localize('k_again_ex'),
                                        colour = G.C.DARK_EDITION})
                                            local passed_context = context
                                            SMODS.score_card(play_card, passed_context)
                                        end
                                    end
                                end
                                SMODS.calculate_context({rescore_cards = retrigger_cards})
                            end
                        end
                    }
                
            end
            if context.after and context.scoring_hand and card.facing ~= 'back' then
            for _, other_card in ipairs(context.scoring_hand) do
                other_card.ability.extra.rescore = 0
            end
        end
        if context.cardarea == G.play and context.after and card.facing ~= 'back' then
            local self_pos = nil
            for i=1, #G.play.cards do
                if G.play.cards[i] == card then
                    self_pos = i
                end
            end
            if G.play.cards[self_pos-1] then
                G.play.cards[self_pos-1]:set_debuff(false)
            end
            if G.play.cards[self_pos+1] then
                G.play.cards[self_pos+1]:set_debuff(false)
            end
        end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.repetitions
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
