//
//  CardSetColumn.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 4/7/18.
//  Copyright © 2018 Mulloy, Charles. All rights reserved.
//

import Foundation

struct CardSetColumn {
    var cardSets: [CardSet]
    var cardForColumn: Int
    
    init(type: CardSetType, number: Int) {
        cardSets = (2...number-1).map { CardSet(type: type, card1: number, card2: $0) }
        cardForColumn = number
    }
}
