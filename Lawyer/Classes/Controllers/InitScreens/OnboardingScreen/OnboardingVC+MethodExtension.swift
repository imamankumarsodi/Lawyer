//
//  OnboardingVC+MethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 22/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension OnboardingVC{
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        super.isHiddenNavigationBar(true)
    }
    
    //TODO: Intial setup implementation
    internal func initialSetup(){
        self.buttonProceedRef.isHidden = true
        self.buttonProceedRef.alpha = 0
        self.buttonProceedRef.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        self.buttonProceedRef.setTitleColor(AppColor.app_gradient_color1, for: .normal)
        self.buttonProceedRef.setTitle(ConstantTexts.PROCEED_BT, for: .normal)
        self.buttonProceedRef.backgroundColor = AppColor.clearColor
        self.onboardingView.dataSource = self
        self.onboardingView.delegate = self
    }
 
}
