//
//  CityListViewController+TextFieldDelegate.swift
//  Lawyer
//
//  Created by Aman Kumar on 26/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension CityListViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
            let textForSize = NSString(string: textField.text!).replacingCharacters(in: range, with: string)
 
            if textForSize.trimmingCharacters(in: .whitespaces).count > 3 {
                textField.text = textForSize
                self.getCitiesName_Service(cityName: textForSize.trimmingCharacters(in: .whitespaces))
            }
    
            return true
        }
    
    
  
}
