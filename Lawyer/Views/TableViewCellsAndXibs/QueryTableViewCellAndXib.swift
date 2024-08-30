//
//  QueryTableViewCellAndXib.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class QueryTableViewCellAndXib: SBaseTableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblImage: UIImageView!
   // @IBOutlet weak var btnSelectRef: UIButton!
    
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
     public func configureNew(with info: QueryDataModelNewViewModel){
        
        
         
         
         if info.Status == "Open"{
             self.lblImage.setImageTintColor(AppColor.errorColor)
             self.lblImage.image = #imageLiteral(resourceName: "icons8-future_filled")
             self.lblStatus.text = ConstantTexts.OpenLT
             self.lblStatus.textColor = AppColor.errorColor
            
            
            
            /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyleCenter = NSMutableParagraphStyle()
            paragraphStyleCenter.alignment = .left
            // *** set LineSpacing property in points ***
            paragraphStyleCenter.lineSpacing = 1 // Whatever line spacing you want in points
            
            let myMutableString = NSMutableAttributedString()
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.QuestionLT)\(info.Query)\n\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
            
            
            
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.AnswerLT)\(ConstantTexts.QueryReso_LT)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
            
            
            // *** Apply attribute to string ***
            myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
            // *** Set Attributed String to your label ***
       
            self.lblDetails.attributedText = myMutableString
           
            
             
         }else{
             self.lblImage.setImageTintColor(AppColor.passGreenColor)
             self.lblImage.image = #imageLiteral(resourceName: "icons8-verified_account")
             self.lblStatus.text = ConstantTexts.ResolvedLT
             self.lblStatus.textColor = AppColor.passGreenColor
            
            /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
            // *** Create instance of `NSMutableParagraphStyle`
            let paragraphStyleCenter = NSMutableParagraphStyle()
            paragraphStyleCenter.alignment = .left
            // *** set LineSpacing property in points ***
            paragraphStyleCenter.lineSpacing = 1 // Whatever line spacing you want in points
            
            let myMutableString = NSMutableAttributedString()
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.QuestionLT)\(info.Query)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
            
            
            
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.empty)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
            
            
            // *** Apply attribute to string ***
            myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
            // *** Set Attributed String to your label ***
       
            self.lblDetails.attributedText = myMutableString
           
            
             
         }
 
     }
   
    
    

    //TODO: Configure with new info
    private func setup(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        self.viewBG.backgroundColor = AppColor.whiteColor
        self.lblStatus.numberOfLines = 0
        self.lblStatus.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
        self.lblStatus.textAlignment = .center

        self.lblDetails.numberOfLines = 0
       
    }
    
    
}
