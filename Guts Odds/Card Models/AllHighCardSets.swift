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
    
    
    /**
     Determine the number of cards in the CardSet Column that are lower than the given CardSet.
     For Example, The Card Set Column for 6's contains CardSet's 6-5, 6-4, 6-3, and 6-2.
     So if we provide this function with the CardSet of 6-5, it will return the total number of cards in CardSets 6-4, 6-3, and 6-2.
    */
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
