    SMODS.Enhancement({
        key = 'club',
        atlas = 'bld_blindrank',
        pos = {x = 6, y = 0},
        config = {
            mult = 10,
            x_mult = 2,
            extra = {
                value = 100,
                hues = {"Yellow", "Faded"}
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
            ["bld_obj_blindcard_generate"] = true,
            ["bld_obj_blindcard_warm"] = true,
            ["bld_obj_blindcard_dual"] = true,
            ["bld_obj_blindcard_yellow"] = true,
            ["bld_obj_blindcard_faded"] = true,
        },
        calculate = function(self, card, context)
                if context.cardarea == G.play and context.before and card.facing ~= 'back' then
                    for i=1, #G.play.cards do
                        if G.play.cards[i]:is_color("Red", true, false) and G.play.cards[i] ~= card then
                            if G.play.cards[i].facing ~= 'back' then 
                            G.play.cards[i]:flip()
                            end
                            G.play.cards[i]:set_debuff(true)
                        end
                    end
                end
                if context.cardarea == G.play and context.after and card.facing ~= 'back' then
                    for i=1, #G.play.cards do
                        if G.play.cards[i]:is_color("Red", true, false) and G.play.cards[i] ~= card then
                            G.play.cards[i]:set_debuff(false)
                        end
                    end
                end
        end,
        weight = 3,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    card.ability.mult, card.ability.x_mult
                }
            }
        end
    })
----------------------------------------------
------------MOD CODE END----------------------
