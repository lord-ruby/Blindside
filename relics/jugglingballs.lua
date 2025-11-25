SMODS.Tag {
    key = "jugglingballs_relic",
    config = {
        relic = true
    },
    hide_ability = false,
    atlas = 'bld_relic',
    pos = {x = 4, y = 0},
    in_pool = function(self, args)
        return false
    end,
    apply = function(self, tag, context)
        if context.type == 'eval' and G.GAME.last_blind and G.GAME.last_blind.boss  then
            add_tag(Tag('tag_juggle'))
        end
    end
}