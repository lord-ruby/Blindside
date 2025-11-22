    SMODS.Suit{
        key = "Red",
        card_key = "Red",
        atlas = 'bld_blindrank',
        lc_ui_atlas = 'bld_color',
        lc_colour = HEX('EA6158'),
        hc_colour = HEX('EA6158'),
        pos = {y= 0},
        ui_pos = {x = 0, y = 0},
        in_pool = function(self, args)
            return false
        end
    }
    SMODS.Suit{
        key = "Green",
        card_key = "Green",
        atlas = 'bld_blindrank',
        lc_ui_atlas = 'bld_color',
        lc_colour = HEX('56A786'),
        hc_colour = HEX('56A786'),
        pos = {y= 0},
        ui_pos = {x = 2, y = 0},
        in_pool = function(self, args)
            return false
        end
    }
    SMODS.Suit{
        key = "Blue",
        card_key = "Blue",
        atlas = 'bld_blindrank',
        lc_ui_atlas = 'bld_color',
        lc_colour = HEX('39B1FC'),
        hc_colour = HEX('39B1FC'),
        pos = {y= 0},
        ui_pos = {x = 3, y = 0},
        in_pool = function(self, args)
            return false
        end
    }
    SMODS.Suit{
        key = "Yellow",
        card_key = "Yellow",
        atlas = 'bld_blindrank',
        lc_ui_atlas = 'bld_color',
        lc_colour = HEX('FDA200'),
        hc_colour = HEX('FDA200'),
        pos = {y= 0},
        ui_pos = {x = 1, y = 0},
        in_pool = function(self, args)
            return false
        end
    }
    SMODS.Suit{
        key = "Purple",
        card_key = "Purple",
        atlas = 'bld_blindrank',
        lc_ui_atlas = 'bld_color',
        lc_colour = HEX('8A71E1'),
        hc_colour = HEX('8A71E1'),
        pos = {y= 0},
        ui_pos = {x = 0, y = 1},
        in_pool = function(self, args)
            return false
        end
    }
    SMODS.Suit{
        key = "Faded",
        card_key = "Faded",
        atlas = 'bld_blindrank',
        lc_ui_atlas = 'bld_color',
        lc_colour = HEX('4F6367'),
        hc_colour = HEX('4F6367'),
        pos = {y= 0},
        ui_pos = {x = 1, y = 1},
        in_pool = function(self, args)
            return false
        end
    }
    
    function get_blind_groups(num, hand, or_more)
        local vals = {}
        local fadeds = {}
        local highest = {}
        local fadedblind = false
        local fadedsOnly = true
        if next(SMODS.find_card("j_bld_insignia")) then
            fadedblind = true
        end
        if fadedblind then
            for i=#hand, 1, -1 do
                if hand[i]:is_color("Faded") and fadedblind then
                    table.insert(fadeds, hand[i])
                end
            end
        end
        for i=#hand, 1, -1 do
            if not (hand[i]:is_color("Faded") and fadedblind) then
                fadedsOnly = false
                local curr = {}
                table.insert(curr, hand[i])
                for j=1, #hand do
                    local i_enh = hand[i].config.center.key
                    local j_enh = hand[j].config.center.key
                    if i_enh == j_enh and i ~= j and not (not hand[j]:is_color("Faded") and fadedblind) then
                        table.insert(curr, hand[j])
                    end
                end
                if #highest < #curr then
                    highest = curr
                end
                if or_more and (#curr >= num) or (#curr == num) then
                    vals[curr[1].config.center.key] = curr
                end
            end
        end
        for i=1, #fadeds do
            table.insert(highest, fadeds[i])
        end
        if (or_more and (#fadeds >= num) or (#fadeds == num)) and fadedsOnly then
            vals[20] = fadeds
        end
        if (or_more and (#highest >= num) or (#highest == num)) and not fadedsOnly then
            vals[highest[1].config.center.key] = highest
        end
        local ret = {}
        for k, v in pairs(vals) do
            table.insert(ret, vals[k])
        end
        return ret
    end

    function get_X_blind_same(num, hand, or_more)
        local colors = {"Red", "Green", "Blue", "Purple", "Yellow", "Faded", "Bleh"}
        local vals = {}
        local highest = {}
        local wilds = {}
        local fadedblind = false
        local multicolor = {}
        local fadedsOnly = true
        local allcolors = {}
        if next(SMODS.find_card("j_bld_insignia")) then
            fadedblind = true
            colors[6] = nil
        end
        if fadedblind then
            allcolors["Faded"] = {}
        end
        for i=#hand, 1, -1 do
            if (#hand[i].config.center.config.extra.hues > 1 or ((hand[i]:is_color("Red") or hand[i]:is_color("Blue")) and next(SMODS.find_card("j_bld_sunset")))) or ((hand[i]:is_color("Faded") and fadedblind) or hand[i].seal == "bld_wild") then
                hand[i].used = false
                table.insert(multicolor, hand[i])
            end
        end
        for i=#hand, 1, -1 do
            if hand[i]:is_color("Faded") and fadedblind or hand[i].seal == "bld_wild" then
                table.insert(wilds, hand[i])
            end
        end
        for i = #colors, 1, -1 do
            allcolors[colors[i]] = allcolors[colors[i]] or {}
            for j=1, #hand do
                if hand[j]:is_color(colors[i]) and not (hand[j].seal == "bld_wild" or (hand[j]:is_color("Faded") and fadedblind) or #hand[j].config.center.config.extra.hues > 1 or ((hand[j]:is_color("Red") or hand[j]:is_color("Blue")) and next(SMODS.find_card("j_bld_sunset")))) then
                    fadedsOnly = false
                    table.insert(allcolors[colors[i]], hand[j])
                end
            end
        end
        local multicolors = {}
        for v = #multicolor, 1, -1 do
            local bestColor = "Bleh"
            local secondBestColor = "Bleh"
            local thirdBestColor = "Bleh"
            local fourthBestColor = "Bleh"
            local fifthBestColor = "Bleh"
            local sixthBestColor = "Bleh"
            for i = #colors, 1, -1 do
                if multicolor[v]:is_color(colors[i]) then
                    table.insert(multicolors, colors[i])
                end
            end
            for k = #multicolors, 1, -1 do
                if (1 + #allcolors[multicolors[k]] >= 1 + #allcolors[bestColor]) then
                    if sixthBestColor ~= fifthBestColor then 
                        sixthBestColor = fifthBestColor
                    end
                    if fifthBestColor ~= fourthBestColor then 
                        fifthBestColor = fourthBestColor
                    end
                    if fourthBestColor ~= thirdBestColor then 
                        fourthBestColor = thirdBestColor
                    end
                    if thirdBestColor ~= secondBestColor then 
                        thirdBestColor = secondBestColor
                    end
                    if secondBestColor ~= bestColor then 
                        secondBestColor = bestColor
                    end
                    bestColor = multicolors[k]
                else
                    
                end
            end
            if multicolor[v]:is_color(bestColor) and not multicolor[v].used then
                table.insert(allcolors[bestColor], multicolor[v])
                multicolor[v].used = true
            elseif multicolor[v]:is_color(secondBestColor) and not multicolor[v].used then
                table.insert(allcolors[secondBestColor], multicolor[v])
                multicolor[v].used = true
            elseif multicolor[v]:is_color(thirdBestColor) and not multicolor[v].used then
                table.insert(allcolors[thirdBestColor], multicolor[v])
                multicolor[v].used = true
            elseif multicolor[v]:is_color(fourthBestColor) and not multicolor[v].used then
                table.insert(allcolors[fourthBestColor], multicolor[v])
                multicolor[v].used = true
            elseif multicolor[v]:is_color(fifthBestColor) and not multicolor[v].used then
                table.insert(allcolors[fifthBestColor], multicolor[v])
                multicolor[v].used = true
            elseif multicolor[v]:is_color(sixthBestColor) and not multicolor[v].used then
                table.insert(allcolors[sixthBestColor], multicolor[v])
                multicolor[v].used = true
            end
        end
        for i = #colors, 1, -1 do
            if or_more and (#allcolors[colors[i]] >= num) or (#allcolors[colors[i]] == num) then
                vals[colors[i]] = allcolors[colors[i]]
            end
        end
        if (or_more and (#wilds >= num) or (#wilds == num)) and fadedsOnly then
            vals["Faded"] = wilds
        end
        if (or_more and (#highest >= num) or (#highest == num)) and not fadedsOnly then
            vals[highest[1].config.center.config.extra.hues[1]] = highest
        end
        local ret = {}
        for k, v in pairs(vals) do
            table.insert(ret, vals[k])
        end
        return ret
    end
    
    local get_cool_highest = get_highest
    function get_highest(hand)
            if G.GAME.selected_back.effect.center.config.extra then
                if G.GAME.selected_back.effect.center.config.extra.blindside then return {} end
            else
                return get_cool_highest(hand)
            end
    end

    SMODS.PokerHandPart{
        key = 'blind_flush',
        func = function(hand)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return {} end
                local ret = {}
                local four_fingers = SMODS.four_fingers('flush')
                local suits = {'Red', 'Green', 'Blue', 'Yellow', 'Purple', 'Faded'}
                if #hand < four_fingers then return ret else
                    for j = 1, #suits do
                    local t = {}
                    local suit = suits[j]
                    local flush_count = 0
                    for i=1, #hand do
                        if hand[i]:is_color(suit, nil, true) then flush_count = flush_count + 1;  t[#t+1] = hand[i] end 
                    end
                    if flush_count >= four_fingers then
                        table.insert(ret, t)
                        return ret
                    end
                    end
                    return {}
                end
            end
        end
    }
    SMODS.PokerHandPart {
        key = 'blind_highest',
        func = function(hand)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return {} end
                local highest = nil
                    highest = hand[1]
                if #hand > 0 then return {highest} else return {} end
            end
        end
    }

    SMODS.PokerHandPart {
        key = 'blind_all_pairs',
        func = function(hand)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return {} end
                local _2 = get_X_blind_same(2, hand, true)
                if not next(_2) then return {} end
                return {SMODS.merge_lists(_2)}
            else
                return {}
            end
        end
    }

    for i = 2, 5 do
        SMODS.PokerHandPart {
            key = 'blind_'..i,
            func = function(hand)
                if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return {} end
                return get_X_blind_same(i, hand, true) 
                else
                    return {}
                end
            end
        }
    end

    for i = 2, 5 do
        SMODS.PokerHandPart {
            key = 'blind_paired_'..i,
            func = function(hand)
                if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return {} end
                return get_blind_groups(i, hand, true) 
                else
                    return {}
                end
            end
        }
    end
    function Card:is_color(suit, bypass_debuff, flush_calc)
        local allFaded = false
        if G.consumeables then
                if next(SMODS.find_card("c_bld_montain")) and SMODS.find_card("c_bld_montain")[1].ability.extra.active then
                    allFaded = true
                end
        end
        if not allFaded then
        if flush_calc then
            if self.seal and self.seal == "bld_wild" then
                return true
            end
            for i=1, #self.config.center.config.extra.hues do
                if self.config.center.config.extra.hues[i] == suit  or "bld_" .. self.config.center.config.extra.hues[i] == suit or (self.config.center.config.extra.hues[i] == "Faded" and next(SMODS.find_card("j_bld_insignia")))then
                    return true
                end
            end
            for i=1, #self.config.center.config.extra.hues do
                if (next(find_joker('j_bld_sunset')) and 
                (((self.config.center.config.extra.hues[i] == "Red" or "bld_" .. self.config.center.config.extra.hues[i] == "bld_Red") or (self.config.center.config.extra.hues[i] == "Yellow" or "bld_" .. self.config.center.config.extra.hues[i] == "bld_Yellow")) and
                 (suit == "Red" or suit == "Yellow" or suit == "bld_Red" or suit == "bld_Yellow"))) then
                    return true
                end
                if (next(find_joker('j_bld_sunset')) and 
                (((self.config.center.config.extra.hues[i] == "Blue" or "bld_" .. self.config.center.config.extra.hues[i] == "bld_Blue") or (self.config.center.config.extra.hues[i] == "Purple" or "bld_" .. self.config.center.config.extra.hues[i] == "bld_Purple")) and
                 (suit == "Blue" or suit == "Purple" or suit == "bld_Blue" or suit == "bld_Purple"))) then
                    return true
                end
            end
            return false
        else
            if self.seal and self.seal == "bld_wild" and not self.debuff then
                return true
            end
            for i=1, #self.config.center.config.extra.hues do
                if self.config.center.config.extra.hues[i] == suit or "bld_" .. self.config.center.config.extra.hues[i] == suit or (self.config.center.config.extra.hues[i] == "Faded" and next(SMODS.find_card("j_bld_insignia"))) then
                    return true
                end
            end
            for i=1, #self.config.center.config.extra.hues do
                if (next(find_joker('j_bld_sunset')) and 
                (((self.config.center.config.extra.hues[i] == "Red" or "bld_" .. self.config.center.config.extra.hues[i] == "bld_Red") or (self.config.center.config.extra.hues[i] == "Yellow" or "bld_" .. self.config.center.config.extra.hues[i] == "bld_Yellow")) and
                 (suit == "Red" or suit == "Yellow" or suit == "bld_Red" or suit == "bld_Yellow"))) then
                    return true
                end
                if (next(find_joker('j_bld_sunset')) and 
                (((self.config.center.config.extra.hues[i] == "Blue" or "bld_" .. self.config.center.config.extra.hues[i] == "bld_Blue") or (self.config.center.config.extra.hues[i] == "Purple" or "bld_" .. self.config.center.config.extra.hues[i] == "bld_Purple")) and
                 (suit == "Blue" or suit == "Purple" or suit == "bld_Blue" or suit == "bld_Purple"))) then
                    return true
                end
            end
            return false
        end
    else
        if "Faded" == suit  or "bld_Faded" == suit or (next(SMODS.find_card("j_bld_insignia")))then
            return true
        end
    end
    end
    function Card:get_color()
            return self.config.center.config.extra.hues[1]
        end

    SMODS.PokerHandPart{ -- Spectrum base (Referenced from SixSuits) (and then from Bunco)
    key = 'allin',
    func = function(hand)
            if G.GAME.selected_back.effect.center.config.extra then
                if not G.GAME.selected_back.effect.center.config.extra.blindside then return {} end
                local colorsuits = {}
        local colors = {'Red', 'Green', 'Blue', 'Yellow', 'Purple', 'Faded'}
        for _, v in ipairs(colors) do
        colorsuits[v] = true
        end
        
        -- < 5 hand cant be a spectrum
        if #hand < 5 then return {} end

        local nonwilds = {}
        for i = 1, #hand do
            local cardcolors = {}
            for _, v in ipairs(colors) do
                -- determine table of suits for each card (for future faster calculations)
                if hand[i]:is_color(v, nil, true) then
                    table.insert(cardcolors, v)
                end
            end
            -- if somehow no suits: spectrum is impossible
            if #cardcolors == 0 then
                return {}
            -- if only 1 suit: can be handled immediately
            elseif #cardcolors == 1 then
                -- if suit is already present, not a spectrum, otherwise remove suit from "not yet used suits"
                if colorsuits[cardcolors[1]] == false then return {} end
                colorsuits[cardcolors[1]] = false
            -- add all cards with 2-4 suits to a table to be looked at
            elseif #cardcolors < 8 then
                table.insert(nonwilds, cardcolors)
            end
        end

        -- recursive function for iterating over combinations
        local isSpectrum 
        isSpectrum = function(i, remaining)
            -- traversed all the cards, found spectrum
            if i == #nonwilds + 1 then
                return true
            end

            -- copy remaining suits
            local newremaining = {}
            for k, v in pairs(remaining) do
                newremaining[k] = v
            end

            -- for every suit of the current card: 
            for _, suit in ipairs(nonwilds[i]) do
                -- do nothing if suit has already been used
                if remaining[suit] == true then
                    -- use up suit on this card and check next card
                    newremaining[suit] = false
                    if isSpectrum(i + 1, newremaining) then
                        return true
                    end
                    -- reset suit before continuing
                    newremaining[suit] = true
                end
            end
            return false
        end

        -- begin iteration from first (not already considered) card
        if isSpectrum(1, colorsuits) then
            return {hand}
        else
            return {}
        end
    else
        return {}
    end
    end
}
SMODS.PokerHand{ -- high
    key = 'blind_high',
    visible = false,
    chips = 5,
    mult = 1,
    l_chips = 20,
    l_mult = 3,
    example = {
        { 'C_3',    true, enhancement = "m_bld_ox" },
        { 'C_3',    false, enhancement = "m_bld_house" },
        { 'C_3',    false, enhancement = "m_bld_fruit" },
        { 'C_3',    false, enhancement = "m_bld_psychic" },
        { 'C_3',    false, enhancement = "m_bld_manacle" },

    },
    evaluate = function(parts)
        return parts.bld_blind_highest
    end
}

SMODS.PokerHand{ -- 2oak
    key = 'blind_2oak',
    visible = false,
    chips = 20,
    mult = 2,
    l_chips = 15,
    l_mult = 3,
    example = {
        { 'C_3',    false, enhancement = "m_bld_fish" },
        { 'C_3',    true, enhancement = "m_bld_sharp" },
        { 'C_3',    true, enhancement = "m_bld_mark" },
        { 'C_3',    false, enhancement = "m_bld_wheel" },
        { 'C_3',    false, enhancement = "m_bld_club" },

    },
    evaluate = function(parts)
        return parts.bld_blind_2
    end
}

SMODS.PokerHand{ -- 2pair
    key = 'blind_2pair',
    visible = false,
    chips = 25,
    mult = 2,
    l_chips = 15,
    l_mult = 2,
    example = {
        { 'C_3',    true, enhancement = "m_bld_wall" },
        { 'C_3',    true, enhancement = "m_bld_mouth" },
        { 'C_3',    false, enhancement = "m_bld_house" },
        { 'C_3',    true, enhancement = "m_bld_hook" },
        { 'C_3',    true, enhancement = "m_bld_tooth" },
    },
    evaluate = function(parts)
        if #parts.bld_blind_2 < 2 then return {} end
        return parts.bld_blind_all_pairs
    end
}

SMODS.PokerHand{ -- 3oak
    key = 'blind_3oak',
    visible = false,
    chips = 30,
    mult = 3,
    l_chips = 10,
    l_mult = 3,
    example = {
        { 'C_3',    false, enhancement = "m_bld_adder" },
        { 'S_2',    true, enhancement = "m_bld_goad" },
        { 'S_2',    true, enhancement = "m_bld_skull" },
        { 'S_2',    true, enhancement = "m_bld_blend" },
        { 'C_3',    false, enhancement = "m_bld_flip" },
    },
    evaluate = function(parts)
        return parts.bld_blind_3
    end
}

SMODS.PokerHand{ -- flush
    key = 'blind_flush',
    visible = false,
    chips = 60,
    mult = 6,
    l_chips = 20,
    l_mult = 1,
    example = {
        { 'C_3',    true, enhancement = "m_bld_adder" },
        { 'S_2',    true, enhancement = "m_bld_eye" },
        { 'S_2',    true, enhancement = "m_bld_deck" },
        { 'S_2',    true, enhancement = "m_bld_eye" },
        { 'C_3',    true, enhancement = "m_bld_adder" },
    },
    evaluate = function(parts)
        return parts.bld_blind_flush
    end
}

SMODS.PokerHand{ -- full house
    key = 'blind_fullhouse',
    visible = false,
    chips = 40,
    mult = 4,
    l_chips = 25,
    l_mult = 1,
    example = {
        { 'C_3',    true, enhancement = "m_bld_arm" },
        { 'S_2',    true, enhancement = "m_bld_mouth" },
        { 'S_2',    true, enhancement = "m_bld_wall" },
        { 'S_2',    true, enhancement = "m_bld_wedge" },
        { 'C_3',    true, enhancement = "m_bld_flip" },
    },
    evaluate = function(parts)
            if #parts.bld_blind_3 < 1 or #parts.bld_blind_2 < 2 then return {} end
            return parts.bld_blind_all_pairs
    end
}

SMODS.PokerHand{ -- Spectrum (Referenced from SixSuits) (ty Bunco)
    key = 'raise',
    visible = false,
    chips = 70,
    mult = 6,
    l_chips = 30,
    l_mult = 1,
    example = {
        { 'S_2',    true, enhancement = "m_bld_adder" },
        { 'D_7',    true, enhancement = "m_bld_psychic" },
        { 'C_3',    true, enhancement = "m_bld_arm" },
        { 'S_2',    true, enhancement = "m_bld_wheel" },
        { 'H_K',    true, enhancement = "m_bld_hook" },
    },
    evaluate = function(parts)
        return parts.bld_allin
    end
}

SMODS.PokerHand{ -- four of a kind
    key = 'blind_4oak',
    visible = false,
    chips = 50,
    mult = 5,
    l_chips = 10,
    l_mult = 2,
    example = {
        { 'C_3',    true, enhancement = "m_bld_plant" },
        { 'S_2',    true, enhancement = "m_bld_wheel" },
        { 'S_2',    true, enhancement = "m_bld_serpent" },
        { 'S_2',    true, enhancement = "m_bld_cell" },
        { 'C_3',    false, enhancement = "m_bld_club" },
    },
    evaluate = function(parts)
        return parts.bld_blind_4
    end
}

SMODS.PokerHand{ -- stack
    key = 'blind_stack',
    visible = false,
    chips = 100,
    mult = 8,
    l_chips = 20,
    l_mult = 1,
    example = {
        { 'C_3',    true, enhancement = "m_bld_pot" },
        { 'S_2',    true, enhancement = "m_bld_psychic" },
        { 'S_2',    true, enhancement = "m_bld_flint" },
        { 'S_2',    true, enhancement = "m_bld_ox" },
        { 'C_3',    true, enhancement = "m_bld_club" },
    },
    evaluate = function(parts)
        if #parts.bld_blind_paired_2 or not next(parts.bld_blind_flush) then return {} end
            return parts.bld_blind_flush
    end
}

SMODS.PokerHand{ -- five of a kind
    key = 'allin',
    visible = false,
    chips = 120,
    mult = 12,
    l_chips = 10,
    l_mult = 1,
    example = {
        { 'C_3',    true, enhancement = "m_bld_psychic" },
        { 'C_3',    true, enhancement = "m_bld_psychic" },
        { 'C_3',    true, enhancement = "m_bld_psychic" },
        { 'C_3',    true, enhancement = "m_bld_psychic" },
        { 'C_3',    true, enhancement = "m_bld_psychic" },
    },
    evaluate = function(parts)
        return parts.bld_blind_paired_5
    end
}
----------------------------------------------
------------MOD CODE END----------------------
