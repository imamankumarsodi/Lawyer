//
//  AboutUsVC+CustomMethods.swift
//  Lawyer
//
//  Created by Aman Kumar on 09/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension AboutUsVC{
    
    //TODO: Navigation setup implenemtation
       internal func navSetup(){
           self.tabBarController?.tabBar.isHidden = true
           super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.AboutUs_LT, leftBarButtonsType: [.back], rightBarButtonsType: [])
           
           
       }
    
    
    //TODO: Intial setup implementation
    internal func initialSetup(){
        self.textView.setContentOffset(CGPoint.zero, animated: false)
        self.textView.isEditable = false
        self.textView.attributedText = attributedText()
    }
    
    
    //TODO: Intial setup attributedText
    
    func attributedText()-> NSAttributedString
        {
          
            let string = "About Us\n\nTechnology is a great enabler as it keeps finding innovative solutions. It becomes more effective when it comes loaded with domain expertise. At All India ITR, we blend cutting-edge technology with comprehensive knowledge of taxes to find answers to all your tax-related queries; be it e-filing of ITR or helping you get GST ready.  There are certain features that make us a dependable choice for taxpayers.\n\nInfallible Technology\n\nWe are living in the times where almost every existing business has an app. But not all apps are error free. At All India ITR, we have a team of proficient app developers to maintain our application and update it as and when required. So, rest assured you won’t face a glitch while using it.\n\nUnmatched Expertise\n\nDespite having a technologically-advance interface, for us, technology is only a means to an end, as offering tax solutions to clients tops our priority list. To achieve this, we have a team of tax experts which is willing to provide you tax solutions in shortest possible time.\n\nCredibility that Built Trust\n\nWhile revealing their details, taxpayers want to make it sure if the service provider is credible enough. As All India ITR is a government authorised intermediary, you can rest assured that your details are in safe hands.\n\nOne stop Tax Solutions\n\nWhile creating the app we have paid great attention to details. We have made sure our valued customers shouldn’t walk from pillar to post to find tax solutions. To facilitate them, we have Income Tax Calculator, HRA Calculator and Rent Receipt Generator that can be used for free. If you have any other query then you can call us on our numbers or can request a call back." as NSString
            
            let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16.0)])
            
            let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
            
            // Part of string to be bold
            attributedString.addAttributes(boldFontAttribute, range: string.range(of: "About Us"))
            attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Infallible Technology"))
            attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Unmatched Expertise"))
            attributedString.addAttributes(boldFontAttribute, range: string.range(of: "Credibility that Built Trust"))
            attributedString.addAttributes(boldFontAttribute, range: string.range(of: "One stop Tax Solutions"))
            
            // 4
            return attributedString
        }
    
}
