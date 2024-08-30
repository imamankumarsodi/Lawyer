//
//  SignUpVC+MethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 23/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

extension SignUpVC{
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        super.isHiddenNavigationBar(true)
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.registerListModel == nil {
            self.registerListModel = SignUpVM.shared
        }
        
        if  self.dataListVM == nil{
            self.dataListVM = self.registerListModel?.prepareDataSource()
        }
        
        initialSetup()
        
    }
    
    
    //TODO: IntialSetup
    private func initialSetup(){
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
      //  customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.registerTable.separatorStyle = .none
        self.registerTable.backgroundColor = AppColor.whiteColor
        
        registerNib()
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.btnRegisterRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        
        self.btnRegisterRef.setTitle(ConstantTexts.Register_BT, for: .normal)
        self.btnRegisterRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        
        self.btnRegisterRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnRegisterRef.backgroundColor = AppColor.app_gradient_color1
        
        
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 0 // Whatever line spacing you want in points
        
        
        let myMutableString = NSMutableAttributedString()
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.AlreadyHaveBT)  ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: ConstantTexts.LoginHT, font: AppFont.Bold.size(AppFontName.OpenSans, size: 12), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        // *** Set Attributed String to your label ***
        
        self.lblInstruction_SignIn_Customer.attributedText = myMutableString
        
        let lblInstruction_SignIn_Customer_Tap = UITapGestureRecognizer(target: self, action: #selector(self.lblInstruction_SignIn_Customer_Tapped(_:)))
        self.lblInstruction_SignIn_Customer.isUserInteractionEnabled = true
        self.lblInstruction_SignIn_Customer.addGestureRecognizer(lblInstruction_SignIn_Customer_Tap)
      
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        self.registerTable.register(nib: AuthNewTableViewCellAndXib.className)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.registerTable.isHidden = false
            
            self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
            
            /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
            
            self.registerTable.reloadData()
        }
        
        
        
    }
    
    //TODO: setup validation
    internal func isValidate(){
        dismissKeyboard()
        
        if let dataListVM_T = self.dataListVM{
            self.registerListModel?.validateFields(dataStore: dataListVM_T, validHandler: { (strMsg, status, row, section) in
                if status{
                    
                    self.hitSignupService()
                    
                }else{
                    let indexPath = IndexPath(row: row, section: section)
                    
                    if let cell = self.registerTable.cellForRow(at: indexPath) as? AuthNewTableViewCellAndXib{
                        
                        self.customMethodManager?.showToolTip(msg: strMsg, anchorView: cell.textFieldFloating, sourceView: self.view)
                        cell.textFieldFloating.becomeFirstResponder()
                        
                    }
                    
                    
                }
            })
        }
        
    }
    
    
    //MARK: - Web services
    //TODO: Signup Service
    private func hitSignupService(){
        
        guard let dataListVM_T = self.dataListVM else{
            print("No dataListVM_T found...")
            return
        }
        
        
        guard let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String else {
            print("No FirebaseId found...")
            return
        }
        
       
        
        let parameters = [Api_keys_model.Fullname:dataListVM_T.dataStoreStructAtIndex(0).value,
                          Api_keys_model.Mobile:dataListVM_T.dataStoreStructAtIndex(1).value,
                          Api_keys_model.Email:dataListVM_T.dataStoreStructAtIndex(2).value,
                          Api_keys_model.type:self.tag == 0 ? "0" : "1",
                          Api_keys_model.DeviceType:ConstantTexts.deviceType,
                          Api_keys_model.IpAddress:ConstantTexts.IpAddress_Key,
                          Api_keys_model.DeviceId:FirebaseId,
                          Api_keys_model.FirebaseId:FirebaseId] as [String:AnyObject]
        
        
        
        
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.signup, method: .post, parameters: parameters, header: nil, success: { (result) in
            print(result)
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            
                            let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: OTP_VC.className) as! OTP_VC
                            vc.phoneNumber = dataListVM_T.dataStoreStructAtIndex(1).value
                            vc.type = self.tag == 0 ? "0" : "1"
                            vc.modalPresentationStyle = .automatic //or .overFullScreen for transparency
                            self.present(vc, animated: true, completion: nil)

                         
                            
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
