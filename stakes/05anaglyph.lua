SMODS.Stake{
    key = 'anaglyph_deck',

    applied_stakes = {'bld_magic_deck'},
    prefix_config = {above_stake = {mod = false}, applied_stakes = {mod = false}, unlocked_stake = {mod = false}},
    
    modifiers = function()
        G.GAME.modifiers.enable_bld_double_up = true
    end,

    --colour = ,

    pos = {x = 0, y = 1},
    --sticker_pos = {x = 0, y = 0},
    atlas = 'bld_stakes',
    --sticker_atlas = 
}