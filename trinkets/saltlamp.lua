
    SMODS.Joker({
        key = 'saltlamp',
        atlas = 'bld_trinkets',
        pos = {x = 1, y = 4},
        rarity = 'bld_curio',
        cost = 6,
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
            if context.before and next(context.poker_hands['bld_blind_flush']) then
                for i = 1, 2 do
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    local planet = create_card('bld_obj_mineral',G.consumeables, nil, nil, nil, nil, nil, 'vast')
                    planet:add_to_deck()
                    G.consumeables:emplace(planet)
                    G.GAME.consumeable_buffer = 0
                    end
                end
                return {
                    message = localize('k_mineral_ex'),
                    colour = G.C.SECONDARY_SET.bld_obj_mineral,
                    card = card
                }
            end
        end
    })