//
//  CardSet.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 4/7/18.
//  Copyright © 2018 Mulloy, Charles. All rights reserved.
//

import Foundation


struct CardSet {
    
    var type : CardSetType
    var card1 : Int
    var card2 : Int
    
    //number reperesents the number of cards in the card set
    //any high card set will have
    var number : Int
    
    init(type : CardSetType, card1 : Int, card2 : Int) {
        self.type = type
        if(type == .highCard) {
            number = 32
        }
        else {
            number = 12
        }
        self.card1 = card1
        self.card2 = card2
    }
    
    mutating func removeCardFromSet (card : Int) {
        if(card1 == card || card2 == card) {
            number = 24
        }
    }
    
}
