//
//  RateLawyer_UITableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 26/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class RateLawyer_UITableViewCell: SBaseTableViewCell {
    
    
    @IBOutlet weak var lblSuccess: UILabel!
    @IBOutlet weak var imgSuccess: UIImageView!
    @IBOutlet weak var btnRatingRef: UIButton!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        setup()
    }
    
    //TODO: setup with new info
    private func setup(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        
        
        self.imgSuccess.image = #imageLiteral(resourceName: "icons8-verified_account")
        self.lblSuccess.numberOfLines = 0
        
        /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleCenter = NSMutableParagraphStyle()
        paragraphStyleCenter.alignment = .center
        // *** set LineSpacing property in points ***
        paragraphStyleCenter.lineSpacing = 1 // Whatever line spacing you want in points
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CosultationCompletedLT)\n\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CosultationCompletedInsLT)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblSuccess.attributedText = myMutableString
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.btnRatingRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.btnRatingRef.setTitle(ConstantTexts.RateLawyer_BT, for: .normal)
        self.btnRatingRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        
        self.btnRatingRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnRatingRef.backgroundColor = AppColor.app_gradient_color1

     
        
    }
    
}
