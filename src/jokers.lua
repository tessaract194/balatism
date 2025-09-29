SMODS.Joker {
    key = "sevennn_tracks",
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
    atlas = "Balatism", pos = { x = 0, y = 0 },
    config = { extra = { odds_mult = 17, odds_money = 70, mult = 0, money = 7, mult_gain = 1}},
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 7, card.ability.extra.odds_mult, "balatism_sevennn_tracksMult")
        local numerator2, denominator2 = SMODS.get_probability_vars(card, 17, card.ability.extra.odds_money, "balatism_sevennn_tracksMoney")
        return { vars = { numerator, numerator2, denominator, denominator2, card.ability.extra.mult, card.ability.extra.mult_gain, card.ability.extra.money}}
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if context.other_card:get_id() == 7 and SMODS.pseudorandom_probability(card, "balatism_sevennn_tracksMult", 7, card.ability.extra.odds_mult) then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
                return {
                    extra = { message = localize("k_upgrade_ex"), colour = G.C.MULT},
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        if SMODS.pseudorandom_probability(card, "balatism_sevennn_tracksMoney", 17, card.ability.extra.odds_money) then
            return card.ability.extra.money
        end
    end
}

SMODS.Joker{
    key = "justy",
    blueprint_compat = false,
    rarity = 2,
    cost = 7,
    atlas = "Balatism", pos = { x = 0, y = 0 },
    config = { extra = { odds = 6, xmult = 0, money = 8}},
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "balatism_justy")
        return { vars = { card.ability.extra.xmult, card.ability.extra.money, numerator, denominator }}
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, "balatism_justy", 1, card.ability.extra.odds) then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.money
    end
}

SMODS.Joker {
    key = "wanna_be_a_rock",
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
    atlas = "Balatism", pos = { x = 0, y = 0 },
    config = { extra = { odds = 2 , xmult = 0.1 }},
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "balatism_wanna_be_a_rock")
        return { vars = { card.ability.extra.xmult, numerator, denominator } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, "balatism_wanna_be_a_rock", 1, card.ability.extra.odds) then
                context.other_card.ability.perma_x_mult = (context.other_card.ability.perma_x_mult or 1) + card.ability.extra.xmult
                return {
                    extra = { message = localize("k_upgrade_ex"), colour = G.C.MULT},
                    card = card
                }
            end
        end
    end
}
