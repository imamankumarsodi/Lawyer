//
//  ReferAndEarnTableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class ReferAndEarnTableViewCell: SBaseTableViewCell {

    
    //MARK: IBOutlets
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewColor: UIView!
    @IBOutlet weak var lblDetail: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
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
    
    
    
    //MARK: - User Define Functions
    //TODO: Configure with info
    public func configureNew(with info: EarnDataViewModel){
        self.lblDetail.numberOfLines = 0
       /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 1 // Whatever line spacing you want in points
        
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(info.name)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(info.date)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
 
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblDetail.attributedText = myMutableString
        
        self.lblPrice.text = "\(ConstantTexts.CurLT) \(info.price)"

    }
    
    
    
    
    //TODO: setup with new info
    private func setup(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
       
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 0, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.viewColor.backgroundColor = AppColor.app_gradient_color1
       
        self.lblPrice.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.lblPrice.textColor = AppColor.darkGrayColor
        self.lblPrice.backgroundColor = AppColor.whiteColor
        self.lblPrice.numberOfLines = 0
        self.lblPrice.textAlignment = .right
     
        
    }
    
}
