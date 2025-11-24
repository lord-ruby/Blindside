    SMODS.Enhancement({
        key = 'head',
        atlas = 'bld_blindrank',
        pos = {x = 3, y = 2},
        config = {
            extra = {
                xmult = 1.5,
                fullmult = 0,
                value = 100,
                hues = {"Purple", "Faded"}
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
            ["bld_obj_blindcard_cool"] = true,
            ["bld_obj_blindcard_dual"] = true,
            ["bld_obj_blindcard_purple"] = true,
            ["bld_obj_blindcard_faded"] = true,
        },
        calculate = function(self, card, context)
                if context.cardarea == G.play and context.before and card.facing ~= 'back' then
                    for i=1, #G.play.cards do
                        if G.play.cards[i]:is_color("Purple", true, false) and G.play.cards[i] ~= card then
                            if G.play.cards[i].facing ~= 'back' then 
                            G.play.cards[i]:flip()
                            end
                            G.play.cards[i]:set_debuff(true)
                            card:juice_up()
                            card.ability.extra.fullmult = card.ability.extra.fullmult + card.ability.extra.xmult
                        end
                    end
                end
                if context.cardarea == G.play and context.main_scoring and card.ability.extra.fullmult > 1 then
                    return {
                        xmult = card.ability.extra.fullmult
                    }
                end
                if context.cardarea == G.play and context.after and card.facing ~= 'back' then
                    for i=1, #G.play.cards do
                        if G.play.cards[i]:is_color("Purple", true, false) and G.play.cards[i] ~= card then
                            G.play.cards[i]:set_debuff(false)
                        end
                    end
                    card.ability.extra.fullmult = 0
                end
        end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.extra.xmult
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
