//
//  AppTourVC+CustomMethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension AppTourVC{
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        super.isHiddenNavigationBar(true)
    }
    
    //TODO: Intial setup implementation
    internal func initialSetup(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
     
        
      //  self.customMethodManager?.provideShadowAndCornerRadius(self.buttonProceedRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.buttonProceedRef.isHidden = false
        self.buttonProceedRef.setTitle(ConstantTexts.SKIP_BT, for: .normal)
        self.buttonProceedRef.titleLabel?.font = AppFont.Bold.size(AppFontName.OpenSans, size: 12)
        
        self.buttonProceedRef.setTitleColor(AppColor.app_gradient_color1, for: .normal)
        self.buttonProceedRef.backgroundColor = AppColor.whiteColor
        
        self.pageControl.currentPage = 0
        self.pageControl.numberOfPages = self.tourArray.count
        self.pageControl.currentPageIndicatorTintColor = AppColor.app_gradient_color1
        self.pageControl.pageIndicatorTintColor = AppColor.app_gradient_color2
        registerNib()
        
        
        
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        
        self.tourCollectionView.register(nib: AppTourCollectionViewCell.className)
    }
 
}
