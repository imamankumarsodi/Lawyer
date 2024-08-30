//
//  AppTourCollectionViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import paper_onboarding
class AppTourCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with info:OnboardingItemInfo){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        self.imageView.image = info.informationImage
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: info.title, font: info.titleFont, color: info.titleColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(info.description)", font: info.descriptionFont, color: info.descriptionColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        // *** Set Attributed String to your label ***
        self.lblDesc.numberOfLines = 0
        self.lblDesc.attributedText = myMutableString
    }

}
