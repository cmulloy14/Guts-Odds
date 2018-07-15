//
//  Card.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 5/30/18.
//  Copyright © 2018 Mulloy, Charles. All rights reserved.
//

import Foundation

enum CardSetType {
    case highCard, pair
}

enum Card: Int {
    case two = 2, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    
    static var allCards: [Card] {
        return [ .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king, .ace]
    }
    
    var stringValue: String {
        switch self {
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        case .ace:
            return "A"
        default:
            return self.rawValue.description
        }
    }
}
