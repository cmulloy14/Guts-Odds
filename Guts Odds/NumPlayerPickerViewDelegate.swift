//
//  NumPlayerPickerViewDelegate.swift
//  Guts Odds
//
//  Created by Mulloy, Charles on 4/8/18.
//  Copyright © 2018 Mulloy, Charles. All rights reserved.
//

import UIKit

protocol pickerVCDelegate: class {
    func pickersChanged()
}

class NumPlayerPickerViewDelegate: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let numPlayers = [2,3,4,5,6,7,8,9,10]
    var currentSelection = 2
    weak var vcDelegate: pickerVCDelegate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numPlayers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
         return NSAttributedString(string: numPlayers[row].description, attributes: [NSForegroundColorAttributeName:UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentSelection = numPlayers[row]
        vcDelegate?.pickersChanged()
    }
}
