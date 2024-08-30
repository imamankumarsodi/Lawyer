//
//  QueryDetailVC+CustomMethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension QueryDetailVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.QueryStatusHT, leftBarButtonsType: [.back], rightBarButtonsType: [])
        
        
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        initialSetup()
        
    }
    
    
    
    //TODO: Intial setup implementation
    internal func initialSetup(){
        self.viewHeaderBG.backgroundColor = AppColor.header_color
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        self.viewBG.backgroundColor = AppColor.whiteColor
        self.lblStatus.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
        self.lblStatus.numberOfLines = 0
        self.lblImage.setImageTintColor(AppColor.passGreenColor)
        self.lblImage.image = #imageLiteral(resourceName: "icons8-verified_account")
        self.lblStatus.text = ConstantTexts.ResolvedLT
        self.lblStatus.textColor = AppColor.passGreenColor
        
        
        self.lblDetails.numberOfLines = 0
        /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(order.FullName)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(order.Email)\n", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CaseTypeLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(order.CategoryName)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.OrdersDateLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(order.Date)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.AdvLT) ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(order.AnswerByName)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblDetails.attributedText = myMutableString
        
        self.btnCallRef.backgroundColor = AppColor.app_gradient_color1
        CustomMethodClass.shared.provideCornerRadiusTo(self.btnCallRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.btnCallRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnCallRef.setTitle("\(ConstantTexts.GoToHome_BT)", for: .normal)
        
        self.btnMsgRef.backgroundColor = AppColor.app_gradient_color1
        CustomMethodClass.shared.provideCornerRadiusTo(self.btnMsgRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.btnMsgRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnMsgRef.setTitle("\(ConstantTexts.BookConsul_BT)", for: .normal)
        // self.btnMsgRef.setImage(#imageLiteral(resourceName: "email"), for: .normal)
        self.btnMsgRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        
        
        // self.btnCallRef.setImage(#imageLiteral(resourceName: "telephone"), for: .normal)
        self.btnCallRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        self.btnCallRef.isHidden = false
        //        self.btnMsgRef.isHidden = true
        
        self.textView.setContentOffset(CGPoint.zero, animated: false)
        self.textView.isEditable = false
        self.textView.attributedText = attributedText()
        
        hitQueryDetailsService()
    }
    
    
    
    //TODO: Intial setup attributedText
    
    func attributedText()-> NSAttributedString
    {
        
        let string = "\(ConstantTexts.QuestionLT)\(order.Query)\n\n\(ConstantTexts.AnswerLT)\(order.Answer)" as NSString
        
        let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 16.0)])
        
        let boldFontAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        
        // Part of string to be bold
        attributedString.addAttributes(boldFontAttribute, range: string.range(of: "\(ConstantTexts.QuestionLT)\(order.Query)"))
        
        return attributedString
    }
    
    
    
    //MARK: - Web services
    //TODO: Order Details Service
    internal func hitQueryDetailsService(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.query_detail_V2)?QueryId=\(self.order.Id)", method: .get, parameters: nil, header: header, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            print(data)
                            
                            
                            
                            self.lblDetails.numberOfLines = 0
                            /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
                            // *** Create instance of `NSMutableParagraphStyle`
                            let paragraphStyle = NSMutableParagraphStyle()
                            paragraphStyle.alignment = .left
                            // *** set LineSpacing property in points ***
                            paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
                            
                            
                            var myMutableString = NSMutableAttributedString()
                            
                            if let FullName = data.value(forKey: "FullName") as? String{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(FullName)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.textColor) ?? NSMutableAttributedString())
                            }
                            
                            if let Email = data.value(forKey: "Email") as? String{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(Email)\n", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            }
                            
                            myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CaseTypeLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            
                            
                            if let CategoryName = data.value(forKey: "CategoryName") as? String{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(CategoryName)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            }else{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            }
                            
                            myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.OrdersDateLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            
                            
                            if let Date = data.value(forKey: "Date") as? String{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(Date)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            }
                            
                            
                            
                            
                            myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.AdvLT) ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            
                            if let AnswerByName = data.value(forKey: "AnswerByName") as? String{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(AnswerByName)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                                
                            }
                            
                            
                            // *** Apply attribute to string ***
                            myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
                            // *** Set Attributed String to your label ***
                            self.lblDetails.attributedText = myMutableString
                            
                            
                        }
                    }else if code == 401{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.customMethodManager?.deleteAllData(entity: "User_Data", success: {
                                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                                    })
                                }
                            })
                        }
                    }else{
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                            
                        }
                        
                    }
                }
            }
            
        }) { (error) in
            print(error)
            self.customMethodManager?.stopLoader(view:self.view)
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
            }else{
                
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }
            
        }
    }
    
    
}
