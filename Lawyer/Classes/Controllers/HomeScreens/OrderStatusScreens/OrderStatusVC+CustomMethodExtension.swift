//
//  OrderStatusVC+CustomMethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension OrderStatusVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.OrdersStatusHT, leftBarButtonsType: [.backRoot], rightBarButtonsType: [])
        
        SCREEN_NAME = ConstantTexts.OrdersStatusHT
        
    }
    
    //TODO: Init values
    internal func initValues(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        if self.orderVM == nil {
            self.orderVM = OrderStatusVM.shared
        }
        
        if self.orderModel == nil {
            self.orderModel = orderVM?.initDataSource()
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
        
        self.lblDetails.numberOfLines = 0
        /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points
        
        
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(order.CustomerName)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CaseTypeLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(order.CategoryName)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.OrdersDateLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(order.BookingDate)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.OrdersTimeLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(order.BookingTime)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblDetails.attributedText = myMutableString
        
        self.btnCallRef.backgroundColor = AppColor.app_gradient_color2
        CustomMethodClass.shared.provideCornerRadiusTo(self.btnCallRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.btnCallRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnCallRef.setTitle("     \(ConstantTexts.CallLT)", for: .normal)
        // self.btnCallRef.setImage(#imageLiteral(resourceName: "telephone"), for: .normal)
        self.btnCallRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
       
        self.tblOrderStatus.isScrollEnabled = false
        self.tblOrderStatus.separatorStyle = .none
        self.tblOrderStatus.hideEmptyCells()
        self.tblOrderStatus.backgroundColor = AppColor.whiteColor
        self.tblOrderStatus.dataSource = self
        self.tblOrderStatus.delegate = self
        
        
      
       
        
        NOTIFICATION_CENTER.addObserver(self, selector: #selector(reloadApiData(_:)), name: NSNotification.Name(rawValue: ConstantTexts.hitOrderStatusService), object: nil)
        
        recheckDataModels()
        
    }
    
    
    //TODO: Recheck data models implenemtation
    private func recheckDataModels(){
        registerNib()
        
        
        /* DispatchQueue.main.asyncAfter(deadline: .now()) {
         self.lawyerTableView.isHidden = false
         
         self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 260,duration: self.animationDuration, delay: self.delay)
         
         self.lawyerTableView.reloadData()
         } */
        
        
    }
    
    //TODO: register nib file
    private func registerNib(){
        /* For Tableview
         self.categoryTableView.register(nib: LawyerTableViewCell.className)
         
         DispatchQueue.main.asyncAfter(deadline: .now()) {
         self.categoryTableView.isHidden = false
         
         self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
         
         /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
         
         self.categoryTableView.reloadData()
         } */
        
        
        self.tblOrderStatus.registerMultiple(nibs: [OrderStatusNewTableViewCell.className,OrderStatusTableViewCell.className,RateLawyer_UITableViewCell.className,AfterRateTableViewCell.className])
        
        self.tblOrderStatus.isHidden = false
        self.btnMsgRef.isHidden = true
        self.btnCallRef.isHidden = true
       
        self.hitOrderDetailsService()
        
    }
    
    
    internal func setStatus(Id:String){
        
        self.tblOrderStatus.isHidden = false
        
        self.btnMsgRef.isHidden = true
        self.btnCallRef.isHidden = true
       
        if Id == "0"{
            self.lblImage.setImageTintColor(AppColor.errorColor)
            self.lblImage.image = #imageLiteral(resourceName: "icons8-future_filled")
            self.lblStatus.text = ConstantTexts.Pending_LT
            self.lblStatus.textColor = AppColor.errorColor
            
            self.btnMsgRef.backgroundColor = AppColor.app_gradient_color1
            CustomMethodClass.shared.provideCornerRadiusTo(self.btnMsgRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            self.btnMsgRef.setTitleColor(AppColor.whiteColor, for: .normal)
            self.btnMsgRef.setTitle("     \(ConstantTexts.EmailPH)", for: .normal)
            // self.btnMsgRef.setImage(#imageLiteral(resourceName: "email"), for: .normal)
            self.btnMsgRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
            self.tblOrderStatus.isHidden = false
            
            self.btnMsgRef.isHidden = true
            self.btnCallRef.isHidden = true
           
        }else if Id == "1"{
            self.lblImage.setImageTintColor(AppColor.passGreenColor)
            self.lblImage.image = #imageLiteral(resourceName: "icons8-verified_account")
            self.lblStatus.text = ConstantTexts.paymentDoneLT
            self.lblStatus.textColor = AppColor.passGreenColor
            
            self.btnMsgRef.backgroundColor = AppColor.app_gradient_color1
            CustomMethodClass.shared.provideCornerRadiusTo(self.btnMsgRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            self.btnMsgRef.setTitleColor(AppColor.whiteColor, for: .normal)
            self.btnMsgRef.setTitle("     \(ConstantTexts.EmailPH)", for: .normal)
            // self.btnMsgRef.setImage(#imageLiteral(resourceName: "email"), for: .normal)
            self.btnMsgRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
            
            self.tblOrderStatus.isHidden = false
            
            self.btnMsgRef.isHidden = true
            self.btnCallRef.isHidden = true
            
        }else if Id == "2"{
            self.lblImage.setImageTintColor(AppColor.passGreenColor)
            self.lblImage.image = #imageLiteral(resourceName: "icons8-verified_account")
            self.lblStatus.text = ConstantTexts.Expert_AssignedLT
            self.lblStatus.textColor = AppColor.passGreenColor
            
            self.btnMsgRef.backgroundColor = AppColor.app_gradient_color1
            CustomMethodClass.shared.provideCornerRadiusTo(self.btnMsgRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            self.btnMsgRef.setTitleColor(AppColor.whiteColor, for: .normal)
            self.btnMsgRef.setTitle("     \(ConstantTexts.EmailPH)", for: .normal)
            // self.btnMsgRef.setImage(#imageLiteral(resourceName: "email"), for: .normal)
            self.btnMsgRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
            
            self.tblOrderStatus.isHidden = false
            
            self.btnMsgRef.isHidden = true
            self.btnCallRef.isHidden = true
           
        }else{
            self.lblImage.setImageTintColor(AppColor.passGreenColor)
            self.lblImage.image = #imageLiteral(resourceName: "icons8-verified_account")
            self.lblStatus.text = ConstantTexts.Order_completedLT
            self.lblStatus.textColor = AppColor.passGreenColor
            
            self.btnMsgRef.backgroundColor = AppColor.app_gradient_color1
            CustomMethodClass.shared.provideCornerRadiusTo(self.btnMsgRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
            self.btnMsgRef.setTitleColor(AppColor.whiteColor, for: .normal)
            self.btnMsgRef.setTitle("\(ConstantTexts.GoToHome_BT)", for: .normal)
            self.btnMsgRef.setImage(UIImage(), for: .normal)
            self.btnMsgRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
            /*
            self.tblOrderStatus.isHidden = true
            
            self.btnMsgRef.isHidden = true
            self.btnCallRef.isHidden = true
            self.btnRatingRef.isHidden = true
            self.imgSuccess.isHidden = false
            self.lblSuccess.isHidden = false */
            
            self.tblOrderStatus.isHidden = false
            
            self.btnMsgRef.isHidden = true
            self.btnCallRef.isHidden = true
           
        }
        
        self.btnMsgRef.isHidden = true
        self.btnCallRef.isHidden = true
        
        
    }
    
    
    //MARK: - Web services
    //TODO: Order Details Service
    internal func hitOrderDetailsService(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.get_orders_details_V2)?OrderId=\(self.order.Id)", method: .get, parameters: nil, header: header, success: { (result) in
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
                            
                            
                            let myMutableString = NSMutableAttributedString()
                            myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(user.Fullname)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.textColor) ?? NSMutableAttributedString())
                            
                            myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CaseTypeLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            
                            if let CategoryName = data.value(forKey: "CategoryName") as? String{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(CategoryName)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            }
                          
                            myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.OrdersDateLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            
                            
                            if let BookingDate = data.value(forKey: "BookingDate") as? String{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(BookingDate)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            }
                            
                            
                            
                            
                            myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.OrdersTimeLT): ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            
                            
                            if let BookingTime = data.value(forKey: "BookingTime") as? String{
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(BookingTime)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                            }
                            
                            
                            
                            
                            
                            // *** Apply attribute to string ***
                            myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
                            // *** Set Attributed String to your label ***
                            self.lblDetails.attributedText = myMutableString
                            
                            
                            
                            if let Status = data.value(forKey: "Status") as? NSArray{
                                
                                for item in Status{
                                    if let itemDict = item as? NSDictionary{
                                        if let id = itemDict.value(forKey: "id") as? String{
                                            self.Id = id
                                        }
                                        
                                        if let id = itemDict.value(forKey: "id") as? Int{
                                            self.Id = "\(id)"
                                        }
                                        
                                    }
                                }
                                
                                self.setStatus(Id: self.Id)
                                
                               
                                if let IsRating = data.value(forKey: "IsRating") as? String{
                                    self.rate = "\(IsRating)"
                                }
                                
                                if let IsRating = data.value(forKey: "IsRating") as? Int{
                                    self.rate = "\(IsRating)"
                                }
                                
                                self.Review = data.value(forKey: "Review") as? String ?? String()
                                
                              
 
                            }
                            
                            
                            
                            
                            if let SupportPhoneNumber = data.value(forKey: "SupportPhoneNumber") as? String{
                                self.SupportPhoneNumber = "\(SupportPhoneNumber)"
                            }
                            
                            if let SupportPhoneNumber = data.value(forKey: "SupportPhoneNumber") as? Int{
                                self.SupportPhoneNumber = "\(SupportPhoneNumber)"
                            }
                            
                            if let SupportEmail = data.value(forKey: "SupportEmail") as? String{
                                self.SupportEmail = "\(SupportEmail)"
                            }
                            
                            
                            if let LawyerName = data.value(forKey: "LawyerName") as? String{
                                self.lawyerName = LawyerName
                            }
                            
                            if let LawyerAssign = data.value(forKey: "LawyerAssign") as? String{
                                self.LawyerId = LawyerAssign
                            }
                            
                            if let ProfilePhoto = data.value(forKey: "ProfilePhoto") as? String{
                                self.lawyerImage = ProfilePhoto
                            }
                            
                          
                            self.orderModel = self.orderVM?.prepareDataSource(data: data)
                            
                            DispatchQueue.main.async {
                                self.tblOrderStatus.reloadData()
                            }
                            
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
