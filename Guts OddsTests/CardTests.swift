//
//  CardTests.swift
//  Guts OddsTests
//
//  Created by Mulloy, Charles on 7/15/18.
//  Copyright © 2018 Mulloy, Charles. All rights reserved.
//

import XCTest
@testable import Guts_Odds

class CardTests: XCTestCase {
    
    var cards: [Card]?
    
    override func setUp() {
        super.setUp()
        cards = Card.allCards
    }
    
    override func tearDown() {
        cards = nil
        super.tearDown()
    }
    
    func testCards() {
        XCTAssertTrue(cards?.count == 13, "There should be 13 types of cards in a normal deck")
        XCTAssertTrue(Card.jack.stringValue == "J", "Jack Card should have a stringValue of 'J'")
        XCTAssertTrue(Card.queen.stringValue == "Q", "Jack Card should have a stringValue of 'Q'")
        XCTAssertTrue(Card.king.stringValue == "K", "Jack Card should have a stringValue of 'K'")
        XCTAssertTrue(Card.ace.stringValue == "A", "Jack Card should have a stringValue of 'A'")
    }
    
    
    
}
