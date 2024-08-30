//
//  OrderStatusNewTableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 15/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class OrderStatusNewTableViewCell:  SBaseTableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewLine: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblDetailsNew: UILabel!
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
    public func configureNew(with info: OrederStatusDataModel){
       
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleLeft = NSMutableParagraphStyle()
        paragraphStyleLeft.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyleLeft.lineSpacing = 1 // Whatever line spacing you want in points
        
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.ConsultationCostLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(info.PaymentAmount)\n\n", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.DateLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: info.PaymentDate, font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleLeft, range:NSMakeRange(0, myMutableString.length))
        self.lblDetails.numberOfLines = 0
        self.lblDetails.attributedText = myMutableString
        
        
    
        myMutableString = NSMutableAttributedString()
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.Gst_AppliedLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
      
      myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.Gst_ValueLT)\n\n", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.Payment_MethodLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
      
      myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(info.PaymentMethod)", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleLeft, range:NSMakeRange(0, myMutableString.length))
        self.lblDetailsNew.numberOfLines = 0
        self.lblDetailsNew.attributedText = myMutableString
    }
    
    
    
    
    //TODO: setup with new info
    private func setup(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
       
        self.viewBG.backgroundColor = AppColor.tableBGColor
        self.viewLine.backgroundColor = AppColor.app_gradient_color1
        self.customMethodManager?.provideCornerRadiusTo(self.viewBG, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
     
        
    }
    
   
}
