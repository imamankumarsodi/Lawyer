//
//  LawyerNewTableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class LawyerNewTableViewCell: SBaseTableViewCell {
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewBG: UIView!
    
    @IBOutlet weak var imageLawyer: UIImageView!
    @IBOutlet weak var labelNameLayer: UILabel!
    @IBOutlet weak var labelCityLawyer: UILabel!
    @IBOutlet weak var labelLangLawyer: UILabel!
    
    @IBOutlet weak var viewSeprator1: UIView!
    
    @IBOutlet weak var labelExperience: UILabel!
    @IBOutlet weak var labelCall: UILabel!
    @IBOutlet weak var labelMeet: UILabel!
    
    
    @IBOutlet weak var buttonMeetRef: UIButton!
    @IBOutlet weak var buttonCallRef: UIButton!
    
    @IBOutlet weak var btnLawyerSelectedRef: UIButton!
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    //MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    public func configure(with info: Lawyer_View_Model) {
        
        self.customMethodManager?.setImage(imageView: self.imageLawyer, url: info.ProfilePhoto)
        
        self.labelNameLayer.text = info.FullName
        self.labelCityLawyer.text = info.CityName
        self.labelLangLawyer.text = info.Language_String
        
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
        
        
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: ConstantTexts.ExperienceLT, font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.textColor) ?? NSMutableAttributedString())
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(info.Experience_Name)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.labelExperience.attributedText = myMutableString
        
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: ConstantTexts.CallLT, font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        if info.ConsulationType_Call_Fee == ConstantTexts.DefaultFeeValueLT{
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(info.ConsulationType_Call_Fee)", font:AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
            
            self.buttonCallRef.isHidden = true
            
            
        }else{
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.CurLT)  \(info.ConsulationType_Call_Fee)", font:AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
            
            self.buttonCallRef.isHidden = false
            
            self.buttonCallRef.setTitleColor(AppColor.darkGrayColor, for: .normal)
            self.buttonCallRef.backgroundColor = AppColor.whiteColor
            self.buttonCallRef.setTitle(ConstantTexts.CallBT, for: .normal)
            self.buttonCallRef.titleLabel?.font = AppFont.Bold.size(AppFontName.OpenSans, size: 12)
            self.customMethodManager?.provideCornerRadiusTo(self.buttonCallRef, 3, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            self.customMethodManager?.provideCornerBorderTo(self.buttonCallRef, 1, AppColor.placeholderColor)
            
            
        }
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.labelCall.attributedText = myMutableString
        
        
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: ConstantTexts.MeetLT, font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        if info.ConsulationType_Meet_Fee == ConstantTexts.DefaultFeeValueLT{
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(info.ConsulationType_Meet_Fee)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
            
            self.buttonMeetRef.isHidden = true
            
        }else{
           myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.CurLT)  \(info.ConsulationType_Meet_Fee)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
            
            self.buttonMeetRef.isHidden = false
            self.buttonMeetRef.setTitleColor(AppColor.whiteColor, for: .normal)
            self.buttonMeetRef.backgroundColor = AppColor.app_gradient_color1
            self.buttonMeetRef.setTitle(ConstantTexts.MeetBT, for: .normal)
            self.buttonMeetRef.titleLabel?.font = AppFont.Bold.size(AppFontName.OpenSans, size: 12)
            self.customMethodManager?.provideCornerRadiusTo(self.buttonMeetRef, 3, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        }
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.labelMeet.attributedText = myMutableString
        
        
        
        
    }
    
    //TODO: Setup cell implementation
    private func setUpCell(){
        
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        
        self.backgroundColor = AppColor.tableBGColor
        self.viewBG.backgroundColor = AppColor.whiteColor
        /* self.customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, 2, 2, 2, 2, 0, AppColor.tableBGColor) */
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 0, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, 2, 2, 2, 2, 0, AppColor.clearColor)
        
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.imageLawyer, 2.5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.customMethodManager?.provideCornerBorderTo(self.imageLawyer, 1, AppColor.tableBGColor)
        
        
        self.viewSeprator1.backgroundColor = AppColor.tableBGColor
        self.viewSeprator1.isHidden = false

        //TODO: Values
        self.labelNameLayer.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.labelNameLayer.textColor = AppColor.app_gradient_color1
        self.labelNameLayer.numberOfLines = 0
        
        self.labelCityLawyer.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.labelCityLawyer.textColor = AppColor.darkGrayColor
        self.labelCityLawyer.numberOfLines = 0
        
        self.labelLangLawyer.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.labelLangLawyer.textColor = AppColor.darkGrayColor
        self.labelLangLawyer.numberOfLines = 0
        
        
        
    }
    
    
    
    
}
