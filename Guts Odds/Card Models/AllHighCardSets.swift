//
//  AllHighCardSets.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 4/7/18.
//  Copyright © 2018 Mulloy, Charles. All rights reserved.
//

import Foundation

struct AllHighCardSets {
    let cards = [3,4,5,6,7,8,9,10,11,12,13,14]
    
    var cardSetColumns: [CardSetColumn] {
        return cards.map {
            CardSetColumn(type: .highCard, number: $0)
        }
    }
    
    var totalNum: Int {
        return cardSetColumns.flatMap { $0.cardSets }.map { $0.number }.reduce(0, +)

    }
    
    mutating func reduceNumberFromSetsWithCard(card: Int) {
        cardSetColumns.forEach { for var cardSet in $0.cardSets {
                cardSet.removeCardFromSet(card: card)
            }
        }
    }
    
    /**
     Determine the number of cards in the  that are lower than the given CardSet.
     
     So if we provide this function with the CardSet of 6-5, it will return the total number of cards in CardSets 6-4, 6-3, and 6-2, added to the total number of cards in CardSet columns for 5s, 4s, and 3s. (5-4, 5-3, 5-2, 4-3, 4-2, 3-2)
    */

    
    func numberOfCardsInLowerSetThan(set: CardSet) -> Int {
        var num = 0
        for cardSetColumn in cardSetColumns {
            for cardset in cardSetColumn.cardSets {
                if set == cardset {
                    return num
                }
                num = num + cardset.number
            }
        }
        return -1
    }
}
