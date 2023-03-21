//
//  RadioButtonController.swift
//  Popeyes Delivery App
//
//  Created by Gerson de Ocampo on 7/6/21.
//

import UIKit

class RadioButtonController: NSObject {
    var buttonArray: [UIButton]! {
        didSet {
            for x in buttonArray {
                x.setImage(UIImage(named: "unselected"), for: .normal)
                x.setImage(UIImage(named: "selected"), for: .selected)
            }
        }
    }
    
    var selectedButton: UIButton?
    var defaultButton: UIButton = UIButton() {
        didSet {
            buttonArrayUpdated(buttonSelected: self.defaultButton)
        }
    }
    
    func buttonArrayUpdated(buttonSelected: UIButton) {
        for x in buttonArray {
            if x == buttonSelected {
                selectedButton = x
                x.isSelected = true
            }
            else {
                x.isSelected = false
            }
        }
    }
}
