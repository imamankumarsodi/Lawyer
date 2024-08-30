//
//  SendQueryViewController+CustomMethods.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
extension SendQueryViewController{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.FreeCunsultationHT, leftBarButtonsType: [.back], rightBarButtonsType: [])
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
      
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        /*   self.header.viewBG.cornerRadius = 10
         self.header.viewBG.dashColor = AppColor.placeholderColor
         self.header.viewBG.dashWidth = 1.5
         self.header.viewBG.dashLength = 6.0
         self.header.viewBG.betweenDashesSpace = 2.0
         
         self.customMethodManager?.showLottieAnimation(self.header.imgLottie, ConstantTexts.Upload_filesHeader, .loop)
         self.header.lblInstruction1.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
         self.header.lblInstruction1.textColor = AppColor.darkGrayColor
         self.header.lblInstruction1.numberOfLines = 0
         self.header.lblInstruction1.textAlignment = .center */
        
        self.header.lblInstruction2.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.header.lblInstruction2.textColor = AppColor.app_gradient_color1
        self.header.lblInstruction2.numberOfLines = 0
        self.header.lblInstruction2.textAlignment = .left
        self.header.lblInstruction2.text = ConstantTexts.AdditionalQuerLT
        
        self.header.txtView.font = AppFont.Italic.size(AppFontName.OpenSans, size: 12)
        self.header.txtView.text = ConstantTexts.WriteCommentPH
        self.header.txtView.textColor = AppColor.darkGrayColor
        self.header.txtView.delegate = self
        
        self.customMethodManager?.provideCornerRadiusTo(self.header.viewBG, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.header.viewBG.backgroundColor = AppColor.tableBGColor
        self.header.txtView.backgroundColor = AppColor.tableBGColor
     
     
        self.tblDocuments.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        self.tblDocuments.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        
        self.tblDocuments.sectionHeaderHeight = 0.0;
        self.tblDocuments.sectionFooterHeight = 0.0;
        
        self.tblDocuments.hideEmptyCells()
        self.tblDocuments.isScrollEnabled = true
        self.tblDocuments.backgroundColor = AppColor.whiteColor
        
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.btnSubmitRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.btnSubmitRef.setTitle(ConstantTexts.Submit_BT, for: .normal)
        self.btnSubmitRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        
        self.btnSubmitRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnSubmitRef.backgroundColor = AppColor.app_gradient_color1
        
        
        self.header.viewLocationBackground.backgroundColor = AppColor.whiteColor
       
        self.customMethodManager?.provideShadowAndCornerRadius(self.header.viewLocationBackground, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        
        
        self.header.labelLoationTitle.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.labelLoationTitle.textColor = AppColor.darkGrayColor
        self.header.labelLoationTitle.text = ConstantTexts.Select_categories_LT
        
        
        self.header.imageViewDropDown.setImageTintColor(AppColor.darkGrayColor)
        
        self.header.btnSelectCategoryRef.addTarget(self, action: #selector(btnSelectCategoryTapped), for: .touchUpInside)
      
    }
    
    //TODO: Validate fields implementation
    internal func validateFields(validHandler: @escaping ( String, Bool) -> Void){
        
        if !validationMethodManager!.checkEmptyField(self.CategoryId){
            validHandler( ConstantTexts.EnterSelectCategoryALERT, Bool())
            return
            
        }
        
        if !validationMethodManager!.checkEmptyField(self.header.txtView.text.trimmingCharacters(in: .whitespacesAndNewlines)){
            validHandler( ConstantTexts.EnterDescriptionALERT, Bool())
            return
            
        }
        
        
        if self.header.txtView.text.trimmingCharacters(in: .whitespacesAndNewlines) == ConstantTexts.WriteCommentPH{
            validHandler( ConstantTexts.EnterDescriptionALERT, Bool())
            return
        }
        
        validHandler(ConstantTexts.empty,  true)
        
    }
    
    
    
    //MARK: - Web services
    //TODO: check-coupon Service
    internal func hitSendQueryService(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
      
        let parameters = [Api_keys_model.Query:self.header.txtView.text!.trimmingCharacters(in: .whitespacesAndNewlines),
                          Api_keys_model.CategoryName:self.CategoryName,
                          Api_keys_model.CategoryId:self.CategoryId,
                          Api_keys_model.Email:user.Email,
                          Api_keys_model.FullName:user.Fullname,
                          Api_keys_model.Phone:user.Mobile] as [String:AnyObject]
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: SCustomerApi.freeconsultation_V2, method: .post, parameters: parameters, header: header, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            NOTIFICATION_CENTER.post(name: NSNotification.Name(rawValue: ConstantTexts.paymentDone), object: nil)
                            self.navigationController?.popToRootViewController(animated: true)
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
