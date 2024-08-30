//
//  PaymentVC+UITextFieldDelegate.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
//MARK: - UITextFieldDelegate extension
extension PaymentVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let currentIndexPath = customMethodManager?.getIndexPathFor(view: textField, tableView: self.tblPayment) else { return true }
        let lastRowIndex = self.tblPayment.numberOfRows(inSection: 0) - 1
        if currentIndexPath.row != lastRowIndex {
            let nextIndexPath = IndexPath(row: currentIndexPath.row + 1, section: 0)
            while nextIndexPath.row <= lastRowIndex {
                if let nextCell = self.tblPayment.cellForRow(at: nextIndexPath) as? GSTIN_TableViewCellAndXib {
                    self.tblPayment.scrollToRow(at: nextIndexPath, at: .middle, animated: true)
                    nextCell.textField?.returnKeyType = .next
                    if nextIndexPath.row == lastRowIndex {
                        nextCell.textField?.returnKeyType = .done
                    }
                    nextCell.textField?.becomeFirstResponder()
                    break
                }
            }
            textField.resignFirstResponder()
        }
        else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        
        let str = textField.text as String?
        if let index = customMethodManager?.getIndexPathFor(view: textField, tableView: self.tblPayment) {
            if str?.count == 0 {
                
                self.dataListVM?.dataStoreStructAtIndex(index.row).dataStoreStruct.value = String()
            }
            else{
                self.dataListVM?.dataStoreStructAtIndex(index.row).dataStoreStruct.value = str ?? ConstantTexts.empty
            }
        }
    }
    
}
