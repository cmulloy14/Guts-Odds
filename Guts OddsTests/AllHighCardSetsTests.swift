//
//  AllHighCardSetsTests.swift
//  Guts OddsTests
//
//  Created by Mulloy, Charles on 7/15/18.
//  Copyright © 2018 Mulloy, Charles. All rights reserved.
//

import XCTest
@testable import Guts_Odds

class AllHighCardSetsTests: XCTestCase {
    
    var allHighCardSets: AllHighCardSets?
    
    override func setUp() {
        super.setUp()
        allHighCardSets = AllHighCardSets()
    }
    
    override func tearDown() {
        allHighCardSets = nil
        super.tearDown()
    }
    
    func testAllHighCardSets() {
        XCTAssertTrue(allHighCardSets?.totalNum == 2496, "The total number of cards in the 'High Card' sets should be 2496")
        XCTAssertTrue(allHighCardSets?.cardSetColumns.count == 12, "The number of Card Set Columns should be 12, one for each card, except for 2")
    }
    
    func testRemovingCards() {
        
        
    }
    
}
