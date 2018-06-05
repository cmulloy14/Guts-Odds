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
    
    var totalNum = 0
    var cardSetColumns =  [CardSetColumn]()
    
    init() {
        for card in cards {
            cardSetColumns.append(CardSetColumn(type: .highCard, number: card))
        }
        
        for cardSetColumn in cardSetColumns {
            for cardSet in cardSetColumn.cardSets {
                totalNum += cardSet.number
            }
        }
    }
    
    mutating func reduceNumberFromSetsWithCard(card: Int) {
        totalNum = 0
        for cardSetColumn in cardSetColumns {
            for var cardSet in cardSetColumn.cardSets {
                cardSet.removeCardFromSet(card: card)
            }
        }
        for cardSetColumn in cardSetColumns {
            for cardSet in cardSetColumn.cardSets {
                totalNum += cardSet.number
            }
        }
    }
    
    func numberOfCardsInLowerSetThan(set: CardSet) -> Int {
        var num = 0
        for cardSetColumn in cardSetColumns {
            for cardset in cardSetColumn.cardSets {
                
                if (set.card1 == cardset.card1 && set.card2 == cardset.card2) || (set.card1 == cardset.card2 && set.card2 == cardset.card1) {
                    
                    return num
                }
                num = num + cardset.number
            }
        }
        return -1
    }
}
