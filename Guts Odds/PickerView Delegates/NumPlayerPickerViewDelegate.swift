//
//  NumPlayerPickerViewDelegate.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 4/8/18.
//  Copyright © 2018 Mulloy, Charles. All rights reserved.
//

import UIKit

protocol NumPlayerPickerSelectionDelegate: class {
    func pickersChanged()
}

class NumPlayerPickerViewDelegate: NSObject  {
    let numPlayers = (2...10).map { $0 }
    var currentSelection = 2
    weak var vcDelegate: NumPlayerPickerSelectionDelegate?
}


extension NumPlayerPickerViewDelegate: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numPlayers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: numPlayers[row].description, attributes:
            [NSAttributedString.Key.foregroundColor:UIColor.white,
             NSAttributedString.Key.font: UIFont.systemFont(ofSize: 42.0)
             ]
        )
    }
}


extension NumPlayerPickerViewDelegate:  UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelection = numPlayers[row]
        vcDelegate?.pickersChanged()
    }
}
