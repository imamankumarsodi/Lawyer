//
//  EarnedVC+CustomMethods.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension EarnedVC{
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = false

    }
    
    //TODO: Init values
    internal func initValues(){
        
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        
        if self.earnVM == nil {
            self.earnVM = EarnVM.shared
        }
        
        if self.earnList == nil {
            self.earnList = earnVM?.initDataSource()
        }
       
        
       
        
        initialSetup()
        
    }
    
    internal func initialSetup(){
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewHeader, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        NOTIFICATION_CENTER.addObserver(self, selector: #selector(reloadApiData(_:)), name: NSNotification.Name(rawValue: ConstantTexts.hitEarnedService), object: nil)
        
        self.lblCorner.font = AppFont.Bold.size(AppFontName.OpenSans, size: 20)
        self.lblCorner.textColor = AppColor.whiteColor
        self.lblCorner.backgroundColor = AppColor.image_bg_color
        self.lblCorner.numberOfLines = 0
        self.lblCorner.textAlignment = .center
        self.lblCorner.text = ConstantTexts.CurLT
        
        self.customMethodManager?.provideCornerRadiusTo(self.lblCorner, self.lblCorner.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        self.lblDetails.numberOfLines = 0
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleCenter = NSMutableParagraphStyle()
        paragraphStyleCenter.alignment = .center
        
        // *** set LineSpacing property in points ***
        paragraphStyleCenter.lineSpacing = 1 // Whatever line spacing you want in points
        
       let myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.YourBalanceLT)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 16), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.CurLT) ", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 30), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(0)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 35), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
   
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
        self.lblDetails.attributedText = myMutableString
        
        self.earnTableView.separatorStyle = .none
        self.earnTableView.hideEmptyCells()
        self.earnTableView.isScrollEnabled = true
        self.earnTableView.backgroundColor = AppColor.whiteColor
        self.earnTableView.addSubview(self.refreshControl)
        self.earnTableView.dataSource = self
        self.earnTableView.delegate = self
        DispatchQueue.main.async {
            self.earnTableView.reloadData()
        }
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
        
        
        self.earnTableView.register(nib: ReferAndEarnTableViewCell.className)
        self.getEarnsService(isRefresh:true)
    }
    
    
    
    
    
    //MARK: - Web services methods
    //TODO: Get customer's orders web service
    internal func  getEarnsService(isRefresh:Bool){
        
        
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        print(header)
        
        
        self.customMethodManager?.startLoader(view:self.view)
        
        DispatchQueue.main.async {
            if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.earnTableView, childView: self.errorView){
                if isAddedSubview{
                    self.customMethodManager?.removeSubView(childView: self.errorView)
                }
            }
        }
        
        ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.wallet_list_V2)\(self.offset)", method: .get, parameters: nil, header: header, success: { (result) in
            print(result)
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            if let total = data.value(forKey: "total") as? Int{
                                
                                self.lblDetails.numberOfLines = 0
                                // *** Create instance of `NSMutableParagraphStyle`
                                let paragraphStyleCenter = NSMutableParagraphStyle()
                                paragraphStyleCenter.alignment = .center
                                
                                // *** set LineSpacing property in points ***
                                paragraphStyleCenter.lineSpacing = 1 // Whatever line spacing you want in points
                                
                               let myMutableString = NSMutableAttributedString()
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.YourBalanceLT)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 16), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                                
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.CurLT) ", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 30), color: AppColor.textColor) ?? NSMutableAttributedString())
                                
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(total)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 35), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
                           
                                // *** Apply attribute to string ***
                                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                                self.lblDetails.attributedText = myMutableString
                            }
                            
                            if let total = data.value(forKey: "total") as? String{
                                
                                self.lblDetails.numberOfLines = 0
                                // *** Create instance of `NSMutableParagraphStyle`
                                let paragraphStyleCenter = NSMutableParagraphStyle()
                                paragraphStyleCenter.alignment = .center
                                
                                // *** set LineSpacing property in points ***
                                paragraphStyleCenter.lineSpacing = 1 // Whatever line spacing you want in points
                                
                               let myMutableString = NSMutableAttributedString()
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.YourBalanceLT)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 16), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                                
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.CurLT) ", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 30), color: AppColor.textColor) ?? NSMutableAttributedString())
                                
                                myMutableString.append(self.customMethodManager?.provideSimpleAttributedText(text: "\(total)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 35), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
                           
                                // *** Apply attribute to string ***
                                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
                                self.lblDetails.attributedText = myMutableString
                            }
                            
                            
                            
                            print(data)
                          /*  DispatchQueue.main.async {
                                if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.earnTableView, childView: self.errorView){
                                    if isAddedSubview{
                                        self.customMethodManager?.removeSubView(childView: self.errorView)
                                    }
                                }
                            } */
                            
                            if let count = data.value(forKey: "count") as? Int{
                                self.dataCount = count
                            }
                            
                            if let count = data.value(forKey: "count") as? String{
                                self.dataCount = Int(count) ?? 0
                            }
                            
                              if let order = data.value(forKey: "data") as? NSArray{
                                //For table refresh
                                if isRefresh{
                                    /*  self.resetFilters() */
                                    if let count = self.earnList?.earns.count{
                                        if count > 0{
                                            self.earnList?.earns.removeAll()
                                        }
                                    }
                                }
                                
                                
                                //For checking pagination and append data
                                   if let count = self.earnList?.earns.count{
                                    if count == 0{
                                        
                                        self.isPagination = false
                                        if let orders = self.earnVM?.prepareDataSource(dataArray: order).earns{
                                            self.earnList?.earns.append(contentsOf: orders)
                                        }
                                    }else{
                                        if count >= self.dataCount{
                                            self.isPagination = true
                                            
                                        }else{
                                            
                                            self.isPagination = false
                                            if let orders = self.earnVM?.prepareDataSource(dataArray: order).earns{
                                                self.earnList?.earns.append(contentsOf: orders)
                                            }
                                        }
                                        
                                    }
                                }
                                
                                
                                //For checking pagination...
                                  if let count = self.earnList?.earns.count{
                                    self.offset = count
                                    
                                    if count == 0{
                                        self.isPagination = false
                                        
                                        DispatchQueue.main.async {
                                            if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.earnTableView, childView: self.errorView){
                                                if isAddedSubview{
                                                    
                                                }else{
                                                    self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.NoOrdersFoundALERT, callback: {
                                                        self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.EmptyBoxNew, .loop)
                                                    })
                                                    
                                                    self.customMethodManager?.addSubView(parentView: self.earnTableView, childView: self.errorView)
                                                }
                                            }
                                        }
                                        
                                        
                                    }else{
                                        if count >= self.dataCount{
                                            self.isPagination = true
                                            
                                        }else{
                                            self.isPagination = false
                                        }
                                    }
                                }
                                
                                
                                
                            }
                            
                        }
                        
                        // self.animateView()
                        DispatchQueue.main.async {
                            self.earnTableView.reloadData()
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
            
            if let count = self.earnList?.earns.count{
                if count > 0{
                    self.earnList?.earns.removeAll()
                }
            }
            
            DispatchQueue.main.async {
                self.earnTableView.reloadData()
            }
            
            self.customMethodManager?.stopLoader(view:self.view)
            if let _ = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                
                let errorCode = (error as NSError).code
                if let animationDetail = self.customMethodManager?.getAnimationNameAndMessage(errorCode: errorCode){
                    DispatchQueue.main.async {
                        if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.earnTableView, childView: self.errorView){
                            if isAddedSubview{
                                
                                self.customMethodManager?.setupError(chidView: self.errorView, message: animationDetail.1,callback: {
                                    self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, animationDetail.0, .loop)
                                })
                                
                            }else{
                                self.customMethodManager?.setupError(chidView: self.errorView, message: animationDetail.1,callback: {
                                    self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, animationDetail.0, .loop)
                                })
                                
                                self.customMethodManager?.addSubView(parentView: self.earnTableView, childView: self.errorView)
                            }
                        }
                    }
                    
                    
                }
                
            }else{
                DispatchQueue.main.async {
                    if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.earnTableView, childView: self.errorView){
                        if isAddedSubview{
                            
                            self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.errorMessage, callback: {
                                self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.SomeThingWentWrong, .loop)
                            })
                            
                        }else{
                            self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.errorMessage, callback: {
                                self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.SomeThingWentWrong, .loop)
                            })
                            
                            self.customMethodManager?.addSubView(parentView: self.earnTableView, childView: self.errorView)
                        }
                    }
                }
            }
        }
    }
    
}
