//
//  CardSet.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 4/7/18.
//  Copyright © 2018 Mulloy, Charles. All rights reserved.
//

import Foundation

struct CardSet {
    
    var type: CardSetType
    var card1: Int
    var card2: Int
    
    // number reperesents the number of cards in the card set
    // any high card set will have 32, until a card is 'removed' from the card set
    var number: Int
    
    var cards: [Int] {
        return [card1, card2]
    }
    
    init(type: CardSetType, card1: Int, card2 : Int) {
        self.type = type
        self.card1 = card1
        self.card2 = card2
        number = type == .highCard ? 32 : 12
    }
    
    mutating func removeCardFromSet(card: Int) {
        if (card1 == card || card2 == card) {
            number = 24
        }
    }
    
}

extension CardSet: Equatable {
    static func ==(lhs: CardSet, rhs: CardSet) -> Bool {
        return lhs.cards.contains(rhs.card1) && lhs.cards.contains(rhs.card2)
    }
}
