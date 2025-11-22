    SMODS.Joker({
        key = 'sunset',
        atlas = 'bld_trinkets',
        pos = {x = 3, y = 1},
        rarity = 'bld_keepsake',
        cost = 9,
        blueprint_compat = false,
        eternal_compat = true,
        in_pool = function(self, args)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return false end
                return true
            else
            return false
            end
        end
    })