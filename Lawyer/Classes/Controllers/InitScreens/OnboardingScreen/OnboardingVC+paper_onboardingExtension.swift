//
//  OnboardingVC+paper_onboardingExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 22/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import paper_onboarding

//MARK: - Extension PaperOnboardingDataSource
extension OnboardingVC:PaperOnboardingDataSource{
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        
        let titleFont = UIFont.boldSystemFont(ofSize: 24)
        let descFont = UIFont.boldSystemFont(ofSize: 18)
        
        
        return [OnboardingItemInfo(informationImage:#imageLiteral(resourceName: "justice"),
                                   title: ConstantTexts.ChooseLT,
                                   description: ConstantTexts.ChooseDecLT,
                                   pageIcon: #imageLiteral(resourceName: "one"),
                                   color: AppColor.bgColorOne,
                                   titleColor: AppColor.whiteColor,
                                   descriptionColor: AppColor.whiteColor,
                                   titleFont: titleFont,
                                   descriptionFont: descFont),
                OnboardingItemInfo(informationImage:#imageLiteral(resourceName: "LawCases"),
                                   title: ConstantTexts.CompareLT,
                                   description: ConstantTexts.CompareDecLT,
                                   pageIcon: #imageLiteral(resourceName: "two"),
                                   color: AppColor.bgColorTwo,
                                   titleColor: AppColor.whiteColor,
                                   descriptionColor: AppColor.whiteColor,
                                   titleFont: titleFont,
                                   descriptionFont: descFont),
                OnboardingItemInfo(informationImage:#imageLiteral(resourceName: "location"),
                                   title: ConstantTexts.BookLT,
                                   description: "\(ConstantTexts.BookDec1LT) \(ConstantTexts.AppName) \(ConstantTexts.BookDec2LT)",
                                   pageIcon: #imageLiteral(resourceName: "three"),
                                   color: AppColor.bgColorThree,
                                   titleColor: AppColor.whiteColor,
                                   descriptionColor: AppColor.whiteColor,
                                   titleFont: titleFont,
                                   descriptionFont: descFont)][index]
    }
    
    
}


//MARK: - Extension PaperOnboardingDelegate
extension OnboardingVC:PaperOnboardingDelegate{
    
    func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
        
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index == 1{
            if self.buttonProceedRef.alpha == 1{
                UIView.animate(withDuration: 0.2) {
                    self.buttonProceedRef.alpha = 0
                }
                self.buttonProceedRef.isHidden = true
            }
        }
    }
    
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index == 2{
            self.buttonProceedRef.isHidden = false
            UIView.animate(withDuration: 0.4) {
                self.buttonProceedRef.alpha = 1
            }
        }
    }
    
}
