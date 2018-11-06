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
    
    let cards = (2...14).map { $0 }
    let numPlayers = (2...10).map { $0 }


    var selectedCardType: CardSetType {
        return myCard1 == myCard2 ? .pair : .highCard
    }
    
    // MARK: Starting Values
    var myCard1 = 3
    var myCard2 = 2
    var numberOfPlayers = 5
    
    private enum UIConstants {
        static let cardHeight: CGFloat = 150
        static let cardWidth: CGFloat = 100
        static let cardMargin: CGFloat = 45
    }
    
    let numPickerDelegate = NumPlayerPickerViewDelegate()

    var cardSize: CGSize {
        return CGSize(width: UIConstants.cardWidth, height: UIConstants.cardHeight)
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
            return pow(chance, numPlayers) * 100
        }
        else {
            let cardSet = CardSet(type: selectedCardType, card1: myCard1, card2: myCard2)
            
            allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card1)
            allHighCardSets.reduceNumberFromSetsWithCard(card: cardSet.card2)
            
            let num = allHighCardSets.numberOfCardsInLowerSetThan(set: cardSet)
            let divisor: Double = Double(numPickerDelegate.currentSelection) - 1
            
            let chance: Double = Double(num) / Double(allHighCardSets.totalNum + (13*12))
            return pow(chance, divisor) * 100
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberOfPlayersPickerView.delegate = numPickerDelegate
        numberOfPlayersPickerView.dataSource = numPickerDelegate
        
        numPickerDelegate.vcDelegate = self
        
        calculateOddsForCardSet(CardSet(type: selectedCardType, card1: myCard1, card2: myCard2))
        
        setupUI()
    }
    
    private func setupUI() {
        numberOfPlayersPickerView.selectRow(3, inComponent: 0, animated: false)
        card1PickerView.selectRow(1, inComponent: 0, animated: false)
    }
  
    
    func calculateOddsForCardSet(_ cardSet: CardSet) {
        cardsLabel.text =  "\(String(format: "%.2f", calculatedChance))%"
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
        
        let view = UIView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: pickerView.bounds.width - UIConstants.cardMargin, height: UIConstants.cardHeight)))
        let imageView = UIImageView(frame: CGRect(origin: CGPoint.zero, size: cardSize))
        
        imageView.image = UIImage(named: "\(Card.allCards[row].stringValue)H" )
        view.addSubview(imageView)
        
        return view
    }
}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return UIConstants.cardHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return UIConstants.cardWidth
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
        calculateOddsForCardSet(CardSet(type: selectedCardType, card1: myCard1, card2: myCard2))
    }
}





