//
//  MoreVM.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
class MoreVM: CategoryListModeling {
   
   
    
    //TODO: Singleton object
    static let shared = MoreVM()
    private init() {}
    
    
    func prepareDataEmpty() -> CategoryListViewModel {
        return CategoryListViewModel(categories: [Category]())
    }
    
    
    //TODO: Prepare data source implementation
   /* func prepareDataSource() -> CategoryListViewModel {
        let categories = [Category(image: #imageLiteral(resourceName: "GoogleBlogSearch100px").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.BlogsLT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "Comments96px1").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.FAQs_LT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "Share96px1").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.Share_LT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "icons8_Bank_Cards_100px").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.Custom_Payment_LT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "Rating96px").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.RateUs_LT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "About100px").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.AboutUs_LT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "Call96px").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.ContactUs_LT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "translation").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.LanguageLT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "LogoutRoundedUp96px").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.LogOut_LT, ExpertiseId: String(), Description: String())]
        
        return CategoryListViewModel(categories: categories)
    } */
    
    
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> CategoryListViewModel {
        let categories = [Category(image: #imageLiteral(resourceName: "Share96px1").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.Share_LT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "Rating96px").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.RateUs_LT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "About100px").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.AboutUs_LT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "Call96px").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.ContactUs_LT, ExpertiseId: String(), Description: String()),
                          Category(image: #imageLiteral(resourceName: "LogoutRoundedUp96px").maskWithColor(color: AppColor.app_gradient_color1) ?? UIImage(), Url: String(), title: ConstantTexts.LogOut_LT, ExpertiseId: String(), Description: String())]
        
        return CategoryListViewModel(categories: categories)
    }
    
    
    
    
}
