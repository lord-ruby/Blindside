
    SMODS.Joker({
        key = 'pawn',
        atlas = 'bld_trinkets',
        pos = {x = 8, y = 0},
        rarity = 'bld_hobby',
        config = {
            extra = {
                mult = 0,
                mult_mod = 3,
                xmult = 2,
                hand_list = {"bld_blind_high",'bld_blind_2oak','bld_blind_2pair','bld_blind_3oak','bld_blind_fullhouse','bld_blind_4oak','bld_raise','bld_blind_flush','bld_blind_stack',"bld_blind_allin"},
                hand_count = 1,
                x_value = {x = 8, y = 0},
                queen = false
            }
        },
        cost = 6,
        blueprint_compat = true,
        eternal_compat = true,
        loc_vars = function (self, info_queue, card)
            return {
                key = (card.ability.extra.queen and "j_bld_queen") or card.config.center.key,
                vars = {
                card.ability.extra.mult,
                card.ability.extra.mult_mod,
                localize(card.ability.extra.hand_list[card.ability.extra.hand_count], 'poker_hands'),
                card.ability.extra.xmult,
            }
        }
        end,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end,
        reload = function(self, card, card_table, other_card)
            if card_table.ability.extra and card_table.ability.extra.queen then
                card.children.center:set_sprite_pos({x = 9, y = 0})
            end
        end,
        calculate = function(self, card, context)
            if context.before and context.scoring_name == card.ability.extra.hand_list[card.ability.extra.hand_count] and not context.blueprint and card.ability.extra.hand_count < 9 and not card.ability.extra.queen then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_mod",
                    operation = '+',
                    message_colour = G.C.MULT
                })
                card.ability.extra.hand_count = card.ability.extra.hand_count+1
            end
            if context.joker_main and not card.ability.extra.queen then
                return {
                    mult = card.ability.extra.mult
                }
            end
            if context.before and card.ability.extra.hand_count == 9 and not context.blueprint and not card.ability.extra.queen then 
                G.E_MANAGER:add_event(Event({
                    func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.4)
                    card.ability.extra.queen = true
                    card.ability.extra.x_value = {x = 9, y = 0}
                    card.children.center:set_sprite_pos(card.ability.extra.x_value)
                    return true
                    end
                }))
                    return {
                        message = localize("k_promote_ex"),
                        colour = G.C.MULT,
                        card = card
                    }
            end
            if context.joker_main and card.ability.extra.queen then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    })