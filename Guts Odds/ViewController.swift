//
//  ViewController.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 1/13/17.
//  Copyright © 2017 Mulloy, Charles. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var card1PickerView: UIPickerView!
    @IBOutlet weak var card2PickerView: UIPickerView!
    @IBOutlet weak var numberOfPlayersPickerView: UIPickerView!
    @IBOutlet weak var cardsLabel: UILabel!
    
    let cards = [2,3,4,5,6,7,8,9,10,11,12,13,14]
    let numPlayers = [2,3,4,5,6,7,8,9,10]


    var selectedCardType: CardSetType {
        return myCard1 == myCard2 ? .pair : .highCard
    }
    
    //MARK: Default Values
    var myCard1 = 3
    var myCard2 = 2
    var numberOfPlayers = 2
    let cardHeight: CGFloat = 150.0
    let cardWidth: CGFloat = 100.0
    
    
    let numPickerDelegate = NumPlayerPickerViewDelegate()

    var cardSize: CGSize {
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
    var calculatedChance: Double {
        var allHighCardSets = AllHighCardSets()
        

        if selectedCardType == .pair {
            var addedPairValue = 0
            
            for card in cards {
                if card != myCard1 {
                    addedPairValue += 12
                }
                else {
                    break
                }
            }
            
            let finalCardValue: Double = Double(allHighCardSets.totalNum + addedPairValue)
            let chance: Double = finalCardValue / 2652
            let numPlayers = Double(numPickerDelegate.currentSelection) - 1
            var finalChance = pow(chance, numPlayers)
            
            finalChance = finalChance * 100
            finalChance = Double(round(1000*finalChance)/1000)
            
            return finalChance
            
        }
        else {
            let cardSet = CardSet(type: selectedCardType, card1: myCard1, card2: myCard2)
            
            allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card1)
            allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card2)
            
            let num = allHighCardSets.numberOfCardsInLowerSetThan(set: cardSet)
            let divisor: Double = Double(numPickerDelegate.currentSelection) - 1
            
            let chance: Double = Double(num) / Double(allHighCardSets.totalNum + (13*12))
            
            var finalChance: Double = 1
            
            finalChance = pow(chance, divisor)
            finalChance = finalChance * 100
            finalChance = Double(round(1000*finalChance)/1000)
            
            return finalChance
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card1PickerView.selectRow(1, inComponent: 0, animated: true)
        
        numberOfPlayersPickerView.delegate = numPickerDelegate
        numberOfPlayersPickerView.dataSource = numPickerDelegate
        
        numPickerDelegate.vcDelegate = self
        cardsLabel.text = calculatedChance.description
    }
    
  
    
    func calculateOddsForCardSet(cardSet: CardSet) {
        cardsLabel.text = calculatedChance.description
        return
    }
    
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == card1PickerView || pickerView == card2PickerView ? cards.count : numPlayers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 45, height: cardHeight))
        let myImageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: cardSize))
        
        myImageView.image = UIImage(named: "\(Card.allCards[row].stringValue)H" )
        
        myView.addSubview(myImageView)
        
        return myView
    }
}

extension ViewController: UIPickerViewDelegate {
    
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
        
        myCard1 = pickerView == card1PickerView ? cards[row] : myCard1
        myCard2 = pickerView == card2PickerView ? cards[row] : myCard2
        
    }
    
}

extension ViewController: NumPlayerPickerSelectionDelegate {
    func pickersChanged() {
        calculateOddsForCardSet(cardSet: CardSet(type: selectedCardType, card1: myCard1, card2: myCard2))
    }
}





