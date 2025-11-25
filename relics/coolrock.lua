SMODS.Tag {
    key = "coolrock_relic",
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
        if context.type == 'use_consumeable' and context.consumeable.ability.set == 'bld_obj_mineral'  then
            if SMODS.pseudorandom_probability(card, pseudoseed("flip"),1,2, 'flip') then
                SMODS.calculate_context({using_consumeable = true, consumeable = context.consumeable, area = context.from_area})
                tag:juice_up()
                tag_area_status_text(tag, localize('k_again_ex'), G.C.FILTER, false, 0)
                context.consumeable:use_consumeable(context.area)
            end
        end
    end
}