//
//  ViewController.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 1/13/17.
//  Copyright © 2017 Mulloy, Charles. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var card1PickerView: UIPickerView!
    @IBOutlet weak var card2PickerView: UIPickerView!
    @IBOutlet weak var numberOfPlayersPickerView: UIPickerView!
    @IBOutlet weak var cardsLabel: UILabel!
    
    let cards = [2,3,4,5,6,7,8,9,10,11,12,13,14]
    let numPlayers = [2,3,4,5,6,7,8,9,10]
    
    var cardStrings: [String] {
        return cards.map { cardDescription(card: $0) }
    }
    
    var selectedCardType: CardSetType {
        return myCard1 == myCard2 ? .pair : .highCard
    }
    
    //MARK: Default Values
    var myCard1 = 2
    var myCard2 = 2
    var numberOfPlayers = 2
    let cardHeight: CGFloat = 150.0
    let cardWidth: CGFloat = 100.0
    
    
    let numPickerDelegate = NumPlayerPickerViewDelegate()

    var cardSize: CGSize {
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        card1PickerView.selectRow(1, inComponent: 0, animated: true)
        
        var allHighCardSets = AllHighCardSets()
        let cardSet = CardSet(type: .highCard, card1: 3, card2: 2)
        allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card1)
        allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card2)
        
        let num = allHighCardSets.numberOfCardsInLowerSetThan(set: cardSet)
        
        var chance : Double = Double(num) / Double(allHighCardSets.totalNum)
        chance = chance * 100
        
        
        chance = Double(round(1000*chance)/1000)
        
        numberOfPlayersPickerView.delegate = numPickerDelegate
        numberOfPlayersPickerView.dataSource = numPickerDelegate
        numPickerDelegate.vcDelegate = self
        
        cardsLabel.text = chance.description
    
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == card1PickerView || pickerView == card2PickerView ? cards.count : numPlayers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 30, height: cardHeight))
        let myImageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: cardSize))

        myImageView.image = UIImage(named: "\(Card.allCards[row].stringValue)H" )
    
        myView.addSubview(myImageView)
        
        return myView
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return cardHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return cardWidth
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        defer {
            pickersChanged()
        }
        if pickerView == card1PickerView {
            myCard1 = cards[row]
        }
        else if pickerView == card2PickerView {
            myCard2 = cards[row]
        }
    }
    
    func calculateOddsForCardSet(cardSet : CardSet) {
        var allHighCardSets = AllHighCardSets()
       
        if selectedCardType == .pair {
            let allLowerCardsNum = allHighCardSets.totalNum
            
            var addedPairValue = 0
            
            for card in cards {
                if card == myCard1 {
                    
                }
            }
        }
        
        allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card1)
        allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card2)
        
        let num = allHighCardSets.numberOfCardsInLowerSetThan(set: cardSet)
        let divisor: Double = Double(numPickerDelegate.currentSelection) - 1
        
        let chance: Double = Double(num) / Double(allHighCardSets.totalNum + (13*6))
        
        var finalChance: Double = 1
        
        finalChance = pow(chance, divisor)
        finalChance = finalChance * 100
        finalChance = Double(round(1000*finalChance)/1000)
        
        cardsLabel.text = finalChance.description
    }
    
    func cardDescription(card: Int) -> String{
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

extension ViewController: pickerVCDelegate {
    func pickersChanged() {
        calculateOddsForCardSet(cardSet: CardSet(type: selectedCardType, card1: myCard1, card2: myCard2))
    }
}





