SMODS.Stake{
    key = 'anaglyph_deck',

    above_stake = 'bld_zodiac_deck',
    applied_stakes = {'bld_magic_deck'},
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = function()
        G.GAME.modifiers.enable_voodoo_pack = true
    end,

    calculate = function (self, context)
        if G.GAME.modifiers.enable_voodoo_pack and context.ante_end and context.main_eval then
            G.E_MANAGER:add_event(Event({
                func = function ()
                    add_tag(Tag('tag_bld_voodoo'))
                    play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end
            }))
        end
    end,
    --colour = ,

    pos = {x = 0, y = 1},
    --sticker_pos = {x = 0, y = 0},
    atlas = 'bld_stakes',
    --sticker_atlas = 
}