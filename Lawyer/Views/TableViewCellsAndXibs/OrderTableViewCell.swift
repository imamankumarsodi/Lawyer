//
//  OrderTableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 26/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class OrderTableViewCell: SBaseTableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblImage: UIImageView!
    
    
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
    public func configureNew(with info: OrderDataViewModel){
        self.lblDetails.numberOfLines = 0
       /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 1 // Whatever line spacing you want in points
        
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(info.CustomerName)\n\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.OrdersDateLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(info.BookingDate)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.OrdersTimeLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(info.BookingTime)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblDetails.attributedText = myMutableString
        
        
        if info.Status == "0"{
            self.lblImage.setImageTintColor(AppColor.errorColor)
            self.lblImage.image = #imageLiteral(resourceName: "icons8-future_filled")
            self.lblStatus.text = ConstantTexts.Pending_LT
            self.lblStatus.textColor = AppColor.errorColor
            
        }else if info.Status == "1"{
            self.lblImage.setImageTintColor(AppColor.passGreenColor)
            self.lblImage.image = #imageLiteral(resourceName: "icons8-verified_account")
            self.lblStatus.text = ConstantTexts.paymentDoneLT
            self.lblStatus.textColor = AppColor.passGreenColor
            
        }else if info.Status == "2"{
            self.lblImage.setImageTintColor(AppColor.passGreenColor)
            self.lblImage.image = #imageLiteral(resourceName: "icons8-verified_account")
            self.lblStatus.text = ConstantTexts.Expert_AssignedLT
            self.lblStatus.textColor = AppColor.passGreenColor
            
        }else{
            self.lblImage.setImageTintColor(AppColor.passGreenColor)
            self.lblImage.image = #imageLiteral(resourceName: "icons8-verified_account")
            self.lblStatus.text = ConstantTexts.Order_completedLT
            self.lblStatus.textColor = AppColor.passGreenColor
            
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
        
        
        
    }
    
    
    
}
