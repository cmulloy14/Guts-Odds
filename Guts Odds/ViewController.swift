//
//  ViewController.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 1/13/17.
//  Copyright © 2017 Mulloy, Charles. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var card1PickerView: UIPickerView!
    @IBOutlet weak var card2PickerView: UIPickerView!
    @IBOutlet weak var numberOfPlayersPickerView: UIPickerView!
    @IBOutlet weak var cardsLabel: UILabel!
    
    let cards = [2,3,4,5,6,7,8,9,10,11,12,13,14]
    let numPlayers = [2,3,4,5,6,7,8,9,10]
    
    var myCard1 = 2
    var myCard2 = 2
    
    var numberOfPlayers = 2
    
    
    enum cardSetType {
        case highCard, pair
    }
    
    class AllHighCardSets {
        let cards = [3,4,5,6,7,8,9,10,11,12,13,14]
        
        var totalNum = 0
        var cardSetColumns : [CardSetColumn]
        
        init() {
            cardSetColumns = []
            for card in cards {
               cardSetColumns.append(CardSetColumn(type: .highCard, number: card))
            }
            for cardSetColumn in cardSetColumns {
                for cardSet in cardSetColumn.cardSets {
                    totalNum += cardSet.number
                }
            }
        }
        
        func reduceNumberFromSetsWithCard(card : Int) {
            totalNum = 0
            for cardSetColumn in cardSetColumns {
                for cardSet in cardSetColumn.cardSets {
                    cardSet.removeCardFromSet(card: card)
                }
            }
            for cardSetColumn in cardSetColumns {
                for cardSet in cardSetColumn.cardSets {
                    totalNum += cardSet.number
                }
            }
        }
        
        func numberOfCardsInLowerSetThan(set : CardSet) -> Int {
            var lowCardSets : [CardSet] = []
            var num = 0
            for cardSetColumn in cardSetColumns {
                for cardset in cardSetColumn.cardSets {
                    if set.card1 == cardset.card1 && set.card2 == cardset.card2 {
                        return num
                    }
                    print (cardset.card1)
                    print (cardset.card2)
                    num = num + cardset.number
                    print (num)
                    
                }
            }
            return -1
        }
    }
    class CardSetColumn {
        var cardSets : [CardSet]
        var cardForColumn : Int
        
        init(type : cardSetType, number : Int) {
            cardSets = []
            for card in 2...number-1 {
                    cardSets.append(CardSet(type: type, card1: number, card2: card))
            }
            
            for set in cardSets {
                //3print(cardDescription(card: set.card1) + " - " + cardDescription(card: set.card2))
            }
            cardForColumn = number
        }
        
        func cardDescription(card : Int) -> String{
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
    
    class CardSet {
        
        var type : cardSetType
        var card1 : Int
        var card2 : Int
        var number : Int
        
        init(type : cardSetType, card1 : Int, card2 : Int) {
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
        
        func removeCardFromSet (card : Int) {
            if(card1 == card || card2 == card) {
                number = 24
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card1PickerView.selectRow(1, inComponent: 0, animated: true)
        
        let allHighCardSets = AllHighCardSets()
        let cardSet = CardSet(type: .highCard, card1: 3, card2: 2)
        allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card1)
        allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card2)
        
        let num = allHighCardSets.numberOfCardsInLowerSetThan(set: cardSet)
        
        var chance : Double = Double(num) / Double(allHighCardSets.totalNum)
        chance = chance * 100
        
        
        chance = Double(round(1000*chance)/1000)
        
        cardsLabel.text = chance.description
        
        print("Num cards below: " + num.description)
        print ("Total num: " + allHighCardSets.totalNum.description)
        print ("Chancce: " + chance.description)
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == card1PickerView {
            return 1
        }
        else if pickerView == card2PickerView {
            return 1
        }
        else {
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == card1PickerView {
            return cards.count
        }
        else if pickerView == card2PickerView {
            return cards.count
        }
        else {
            return numPlayers.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == card1PickerView {
            return cardDescription(card: cards[row])
        }
        else if pickerView == card2PickerView {
            return cardDescription(card: cards[row])
        }
        else {
            return numPlayers[row].description
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == card1PickerView {
            
            if (myCard2 == cards[row]) {
                if (row != 0) {
                    pickerView.selectRow(row - 1, inComponent: 0, animated: true)
                }
                else {
                    pickerView.selectRow(row + 1, inComponent: 0, animated: true)
                }
                return
            }
            myCard1 = cards[row]
            
            calculateOddsForCardSet(cardSet: CardSet(type: .highCard, card1: myCard1, card2: myCard2))
        
        }
        else if pickerView == card2PickerView {
            
            if (myCard1 == cards[row]) {
                if (row != 0) {
                    pickerView.selectRow(row - 1, inComponent: 0, animated: true)
                }
                else {
                    pickerView.selectRow(row + 1, inComponent: 0, animated: true)
                }
                return
            }
            myCard2 = cards[row]
            
            calculateOddsForCardSet(cardSet: CardSet(type: .highCard, card1: myCard1, card2: myCard2))
            
            
        }
        else {
            print("num players picker moved")
            numberOfPlayers = numPlayers[row]
            calculateOddsForCardSet(cardSet: CardSet(type: .highCard, card1: myCard1, card2: myCard2))
        }
        
    }

    func calculateOddsForCardSet (cardSet : CardSet) {
        let allHighCardSets = AllHighCardSets()
       //let cardSet = CardSet(type: .highCard, card1: 3, card2: 2)
        allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card1)
        allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card2)
        
        let num = allHighCardSets.numberOfCardsInLowerSetThan(set: cardSet)
        
        let divisor : Double = Double(numberOfPlayers) - 2
        
        
        var chance : Double = Double(num) / Double(allHighCardSets.totalNum + (13*12))
        
        if(divisor >= 1) {
            for x in 1...Int(divisor) {
                chance = chance * chance
                print(x)
            }
        }
        //chance = chance / divisor
        chance = chance * 100
        
        
        
        
        chance = Double(round(1000*chance)/1000)
        
        cardsLabel.text = chance.description
        
        print("Num cards below: " + num.description)
        print ("Total num: " + allHighCardSets.totalNum.description)
        print ("Chancce: " + chance.description)
    }
    func cardDescription(card : Int) -> String{
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

