//
//  PaymentCompleteVC+CustomMethods.swift
//  Lawyer
//
//  Created by Aman Kumar on 12/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension PaymentCompleteVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.whiteColor,ConstantTexts.empty, leftBarButtonsType: [.empty], rightBarButtonsType: [])
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
       
        initialSetup()
        
    }
    
    
    //TODO: Intial setup implementation
    internal func initialSetup(){
       // self.customMethodManager?.showLottieAnimation(self.imgView, ConstantTexts.wallet_animation, .loop)
        self.imgView.setImageTintColor(AppColor.app_gradient_color1)
        self.imgView.image = #imageLiteral(resourceName: "icons8-verified_account")
        self.lblTitle.numberOfLines = 0
        self.lblTitle.font = ConstantFonts.mainBottomButtonFont
        self.lblTitle.textColor = AppColor.app_gradient_color1
        self.lblTitle.textAlignment = .center
        self.lblTitle.text = ConstantTexts.PaymentSuccessfull_LT
        
        self.viewBG.backgroundColor = AppColor.whiteColor
        self.customMethodManager?.provideCornerBorderTo(self.viewBG, 0.8, AppColor.placeholderColor)
        
        self.lblKeys.numberOfLines = 0
        self.lblKeys.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
        self.lblKeys.textColor = AppColor.darkGrayColor
        self.lblKeys.textAlignment = .left
        self.lblKeys.text = "\(ConstantTexts.DateLT)\n\n\(ConstantTexts.BookingTimeLT)\n\n\(ConstantTexts.ConsultationTypeLT)\n\n\(ConstantTexts.ConsultationCostLT)"
        
        
        self.lblValues.numberOfLines = 0
        self.lblValues.font = AppFont.Bold.size(AppFontName.OpenSans, size: 10)
        self.lblValues.textColor = AppColor.darkGrayColor
        self.lblValues.textAlignment = .right
        self.lblValues.text = "\(self.date)\n\n\(self.time)\n\n\(self.type)\n\n\(self.cost)"
        
        
        self.lblFooter.numberOfLines = 0
        self.lblFooter.font = AppFont.Regular.size(AppFontName.OpenSans, size: 10)
        self.lblFooter.textColor = AppColor.darkGrayColor
        self.lblFooter.textAlignment = .center
        self.lblFooter.text = "\(ConstantTexts.FooterLT)"
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.btnHomeRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.btnHomeRef.setTitle(ConstantTexts.GoToHome_BT, for: .normal)
        self.btnHomeRef.titleLabel?.font = AppFont.Bold.size(AppFontName.OpenSans, size: 14)
        
        self.btnHomeRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnHomeRef.backgroundColor = AppColor.app_gradient_color1
        
        
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.btnSendToOrderStatusRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.btnSendToOrderStatusRef.setTitle(ConstantTexts.GoToOrderStatus_BT, for: .normal)
        self.btnSendToOrderStatusRef.titleLabel?.font = AppFont.Bold.size(AppFontName.OpenSans, size: 14)
        
        self.btnSendToOrderStatusRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnSendToOrderStatusRef.backgroundColor = AppColor.app_gradient_color2
        
        
    }
    
}

