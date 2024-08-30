//
//  SendQueryViewController+UITextFieldDelegate.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Textview delegates
extension SendQueryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == AppColor.darkGrayColor {
            textView.font = AppFont.Regular.size(AppFontName.OpenSans, size: 11)
            textView.text = nil
            textView.textColor = AppColor.textColor
            self.descriptionTxtView = textView.text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            self.descriptionTxtView = String()
            textView.font = AppFont.Italic.size(AppFontName.OpenSans, size: 12)
            textView.text = ConstantTexts.WriteCommentPH
            textView.textColor = AppColor.darkGrayColor
        }
    }
    
}
