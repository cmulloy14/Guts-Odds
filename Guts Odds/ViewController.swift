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
    
    var myCard1 = 2
    var myCard2 = 2
    
    var numberOfPlayers = 2
    
    let numPickerDelegate = NumPlayerPickerViewDelegate()

    let cardHeight: CGFloat = 150.0
    let cardWidth: CGFloat = 100.0
    
    
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
        
        var myView = UIView(frame: CGRect(x: 0, y: 0, width: pickerView.bounds.width - 30, height: cardHeight))
        
        var myImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: cardWidth, height: cardHeight))

        myImageView.image = UIImage(named: "\(cardStrings[row])H" )
    
        myView.addSubview(myImageView)
        
        return myView
        
        //return UIImageView.init(image: UIImage(named: "card2"))
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
            
        }
    }
    
//    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
//        return NSAttributedString(string: pickerView == card1PickerView || pickerView == card2PickerView ? cardDescription(card: cards[row]) : numPlayers[row].description, attributes: [NSForegroundColorAttributeName:UIColor.white])
//    }

   
    func calculateOddsForCardSet (cardSet : CardSet) {
        let allHighCardSets = AllHighCardSets()
       //let cardSet = CardSet(type: .highCard, card1: 3, card2: 2)
        allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card1)
        allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card2)
        
        let num = allHighCardSets.numberOfCardsInLowerSetThan(set: cardSet)
        let divisor : Double = Double(numPickerDelegate.currentSelection) - 1
        let chance : Double = Double(num) / Double(allHighCardSets.totalNum + (13*12))
        
        var finalChance : Double = 1
        
        finalChance = pow(chance, divisor)
        finalChance = finalChance * 100
        finalChance = Double(round(1000*finalChance)/1000)
        
        cardsLabel.text = finalChance.description
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

extension ViewController: pickerVCDelegate {
    func pickersChanged() {
        calculateOddsForCardSet(cardSet: CardSet(type: .highCard, card1: myCard1, card2: myCard2))
    }
}





