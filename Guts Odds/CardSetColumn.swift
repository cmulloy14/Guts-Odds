//
//  CardSetColumn.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 4/7/18.
//  Copyright © 2018 Mulloy, Charles. All rights reserved.
//

import Foundation

class CardSetColumn {
    var cardSets: [CardSet]
    var cardForColumn: Int
    
    init(type: CardSetType, number: Int) {
        cardSets = []
        for card in 2...number-1 {
            cardSets.append(CardSet(type: type, card1: number, card2: card))
        }
        cardForColumn = number
    }
    
    func cardDescription(card : Int) -> String {
        switch card {
        case 11:
            return "J"
        case 12:
            return "Q"
        case 13:
            return "K"
        case 14:
            return "A"
        default:
            return card.description
        }
    }
}
