//
//  ReferralVC+CustomMethods.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension ReferralVC{
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = false

    }
    
    //TODO: Init values
    internal func initValues(){
        
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
        initialSetup()
        
    }
    
    internal func initialSetup(){
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        self.lblRefer.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
        self.lblRefer.textColor = AppColor.darkGrayColor
        self.lblRefer.numberOfLines = 0
        self.lblRefer.textAlignment = .center
        self.lblRefer.text = ConstantTexts.ReferText_LT
        
        
        self.lblNotified.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
        self.lblNotified.textColor = AppColor.darkGrayColor
        self.lblNotified.numberOfLines = 0
        self.lblNotified.textAlignment = .center
        self.lblNotified.text = ConstantTexts.Notified_LT
        
        self.lblWallet.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
        self.lblWallet.textColor = AppColor.darkGrayColor
        self.lblWallet.numberOfLines = 0
        self.lblWallet.textAlignment = .center
        self.lblWallet.text = ConstantTexts.CashBack_LT
        
        
        self.lblCouponHeading.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
        self.lblCouponHeading.textColor = AppColor.darkGrayColor
        self.lblCouponHeading.numberOfLines = 0
        self.lblCouponHeading.textAlignment = .left
        self.lblCouponHeading.text = ConstantTexts.Unique_LT
        
        
        
        self.txtCoupon.addBorders(edges: [.top,.bottom,.left], color: AppColor.placeholderColor, inset: 0.0, thickness: 1.0)
        self.txtCoupon.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.txtCoupon.placeholder = ConstantTexts.CouponCode_PH
        self.txtCoupon.textColor = AppColor.textColor
        self.txtCoupon.addPadding(.both(10.0))
        
       // self.header.txtCoupon.maxLength = 10
        self.txtCoupon.keyboardType = .default
        self.txtCoupon.isSecureTextEntry = false
        self.txtCoupon.autocapitalizationType = .allCharacters
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        self.txtCoupon.text = user.CouponCode
        self.txtCoupon.isUserInteractionEnabled = false
        
        self.btnApplyRef.addBorders(edges: [.top,.bottom,.left,.right], color: AppColor.placeholderColor, inset: 0.0, thickness: 1.0)
        self.btnApplyRef.tintColor = AppColor.whiteColor
        self.btnApplyRef.backgroundColor = AppColor.app_gradient_color1
        self.btnApplyRef.setTitle(ConstantTexts.Copy_BT, for: .normal)
        self.btnApplyRef.titleLabel?.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.btnApplyRef.addTarget(self, action: #selector(btnApplyCouponTapped), for: .touchUpInside)
        
        self.lblShareHeading.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
        self.lblShareHeading.textColor = AppColor.darkGrayColor
        self.lblShareHeading.numberOfLines = 0
        self.lblShareHeading.textAlignment = .center
        self.lblShareHeading.text = ConstantTexts.ShareY_LT
        
        
        self.lblFB.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 8)
        self.lblFB.textColor = AppColor.darkGrayColor
        self.lblFB.numberOfLines = 0
        self.lblFB.textAlignment = .center
        self.lblFB.text = ConstantTexts.FB_LT
        
        self.lblWhatsApp.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 8)
        self.lblWhatsApp.textColor = AppColor.darkGrayColor
        self.lblWhatsApp.numberOfLines = 0
        self.lblWhatsApp.textAlignment = .center
        self.lblWhatsApp.text = ConstantTexts.WhatsApp_LT
        
        self.lblSMS.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 8)
        self.lblSMS.textColor = AppColor.darkGrayColor
        self.lblSMS.numberOfLines = 0
        self.lblSMS.textAlignment = .center
        self.lblSMS.text = ConstantTexts.Message_LT
        
        self.lblEmail.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 8)
        self.lblEmail.textColor = AppColor.darkGrayColor
        self.lblEmail.numberOfLines = 0
        self.lblEmail.textAlignment = .center
        self.lblEmail.text = ConstantTexts.EmailPH
        
        self.lblShare.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 8)
        self.lblShare.textColor = AppColor.darkGrayColor
        self.lblShare.numberOfLines = 0
        self.lblShare.textAlignment = .center
        self.lblShare.text = ConstantTexts.MoreLT
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewFB, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewWhatsApp, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewSMS, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewEmail, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewShare, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
    }
    
    
    
    //TODO: setup validation for coupon
    internal func isValidateCoupon(validHandler: @escaping ( String, Bool) -> Void){
        dismissKeyboard()
        
        if !validationMethodManager!.checkEmptyField(self.txtCoupon.text!.trimmingCharacters(in: .whitespacesAndNewlines)){
            validHandler( ConstantTexts.EnterCouponCodeALERT, Bool())
            return
            
        }
        
        validHandler(ConstantTexts.empty,  true)
        
    }
    
}
