//
//  OTP_VC+MethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 23/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import CoreData
extension OTP_VC{
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        super.isHiddenNavigationBar(true)
        //  super.setupNavigationBarTitle(AppColor.header_color, ConstantTexts.VarificationHT, leftBarButtonsType: [.back], rightBarButtonsType: [.empty])
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
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
        
        
        otpView.otpFieldsCount = 4
        otpView.otpFieldDefaultBorderColor = AppColor.darkGrayColor
        otpView.otpFieldEnteredBorderColor = AppColor.app_gradient_color1
        otpView.otpFieldErrorBorderColor = AppColor.app_gradient_color1
        otpView.otpFieldBorderWidth = 2
        otpView.delegate = self
        otpView.shouldAllowIntermediateEditing = false
        
        otpView.otpFieldTextColor = AppColor.app_gradient_color1
        otpView.otpFieldSize = 45
        otpView.otpFieldSeparatorSpace = 10
        otpView.otpFieldFont = AppFont.Regular.size(AppFontName.OpenSans, size: 14)
        otpView.otpFieldDisplayType = .underlinedBottom
        otpView.cursorColor = AppColor.app_gradient_color1
        otpView.placeHolder = ConstantTexts.ZeroLT
        // Create the UI
        otpView.initializeUI()
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.btnDoneOTPRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        
        self.btnDoneOTPRef.setTitle(ConstantTexts.Varify_BT, for: .normal)
        self.btnDoneOTPRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        
        self.btnDoneOTPRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnDoneOTPRef.backgroundColor = AppColor.app_gradient_color1
        
        
        
        let image = UIImage(systemName: "x.circle.fill") ?? UIImage()
        image.setImageTintWith(AppColor.darkGrayColor)
        self.btnDismissRef.setImage(image, for: .normal)
        self.btnDismissRef.tintColor = AppColor.whiteColor
        
        
        
        self.lblTimer.font = ConstantFonts.mainBottomButtonFont
        self.lblTimer.textColor = AppColor.errorColor
        self.lblTimer.textAlignment = .center
        
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 1 // Whatever line spacing you want in points
        
        
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.VarificationCode_LT)", font: AppFont.Bold.size(AppFontName.OpenSans, size: 18), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\n\(ConstantTexts.EnterOTP2_LT)\n", font: AppFont.Regular.size(AppFontName.OpenSans, size: 12), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        
        //   myMutableString.append(customMethodManager?.provideUnderlineAttributedText(text: "\(ConstantTexts.CountryCodeLT) \(phoneNumber)", font: AppFont.Bold.size(AppFontName.OpenSans, size: 12), AppColor.app_gradient_color1) ?? NSMutableAttributedString())
        
        
        //   myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.PleaseVarify_LT)", font: AppFont.Regular.size(AppFontName.OpenSans, size: 12), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        // *** Set Attributed String to your label ***
        lblInstruction.numberOfLines = 0
        lblInstruction.attributedText = myMutableString
        
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.DidntRecieve_BT) ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 12), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.ResendAgain_BT)", font: AppFont.Bold.size(AppFontName.OpenSans, size: 14), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
        self.btnResendOTPRef.setAttributedTitle(myMutableString, for: .normal)
        self.btnResendOTPRef.backgroundColor = AppColor.whiteColor
        
       
        
        startTimer()
        
    }
    
    
    //TODO: setup validation
    internal func isValidate(){
        if !validationMethodManager!.checkEmptyField(enteredOtp.trimmingCharacters(in: .whitespaces)){
            self.customMethodManager?.showToolTip(msg: ConstantTexts.EnterOTPALERT, anchorView: self.otpView, sourceView: self.view)
            return
        } else if !validationMethodManager!.isValidOTPCount(enteredOtp.trimmingCharacters(in: .whitespaces)){
            self.customMethodManager?.showToolTip(msg: ConstantTexts.EnterValidOTPALERT, anchorView: self.otpView, sourceView: self.view)
            
            return
        }else{
            dismissKeyboard()
            self.hitVerificationService()
     
        }
        
    }
    
    
    
    //MARK: - Timer methods
    //TODO: Start timer
    internal func startTimer(){
        self.btnResendOTPRef.isHidden = true
        self.lblTimer.isHidden = false
        self.lblTimer.text = "\(ConstantTexts.ResendInLT) 00:\(time)"
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: true)
    }
    
    //TODO: Stop timer
    internal func stopTimer(){
        self.btnResendOTPRef.isHidden = false
        self.lblTimer.isHidden = true
        timer?.invalidate()
        time = 30
    }
    
    
    
    
    //MARK: - Web services
    //TODO: Verification Service
    private func hitVerificationService(){
        
        
        let parameters = [Api_keys_model.OtpVerification:enteredOtp,
                          Api_keys_model.Mobile:self.phoneNumber,
                          Api_keys_model.type:self.type] as [String:AnyObject]
        
        
        
        self.customMethodManager?.startLoader(view:self.view)
        
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.verify_otp, method: .post, parameters: parameters, header: nil, success: { (result) in
            print(result)
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            
                            let DeviceId = data.value(forKey: "DeviceId") as? String ?? String()
                            
                            var DeviceType = String()
                            if let DeviceType_Parse = data.value(forKey: "DeviceType") as? String{
                                DeviceType = DeviceType_Parse
                            }
                            
                            if let DeviceType_Parse = data.value(forKey: "DeviceType") as? Int{
                                DeviceType = "\(DeviceType_Parse)"
                            }
                            
                            let Email = data.value(forKey: "Email") as? String ?? String()
                            
                            let FirebaseId = data.value(forKey: "FirebaseId") as? String ?? String()
                            
                            let Fullname = data.value(forKey: "Fullname") as? String ?? String()
                            
                            let CouponCode = data.value(forKey: "CouponCode") as? String ?? String()
                            
                            var Id = String()
                            if let Id_Parse = data.value(forKey: "Id") as? String{
                                Id = Id_Parse
                            }
                            
                            if let Id_Parse = data.value(forKey: "Id") as? Int{
                                Id = "\(Id_Parse)"
                            }
                            
                            
                            
                            let IpAddress = data.value(forKey: "IpAddress") as? String ?? String()
                            
                            var Mobile = String()
                            if let Mobile_Parse = data.value(forKey: "Mobile") as? String{
                                Mobile = Mobile_Parse
                            }
                            
                            if let Mobile_Parse = data.value(forKey: "Mobile") as? Int{
                                Mobile = "\(Mobile_Parse)"
                            }
                            
                            
                            var Type = String()
                            if let Type_Parse = data.value(forKey: "Type") as? String{
                                Type = Type_Parse
                            }
                            
                            if let Type_Parse = data.value(forKey: "Type") as? Int{
                                Type = "\(Type_Parse)"
                            }
                            
                            let Uuid = data.value(forKey: "Uuid") as? String ?? String()
                            
                            let token = result_Dict.value(forKey: "token") as? String ?? String()
                           // USER_DEFAULTS.setValue(token, forKey: ConstantTexts.userToken)
                            
                            self.saveDataToLocal_DB(DeviceId: DeviceId, DeviceType: DeviceType, Email: Email, FirebaseId: FirebaseId, Fullname: Fullname, Id: Id, IpAddress: IpAddress, Mobile: Mobile, Type: Type, Uuid: Uuid, token: token,MobileLogo:String(), Version:String(), WebLogo:String(),CouponCode:CouponCode)
                            
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
    
    
    //TODO: Resend OTP Service
    internal func hitResendOTP_Service(){
        
        
        guard let FirebaseId = USER_DEFAULTS.value(forKey: ConstantTexts.deviceToken) as? String else {
              print("No FirebaseId found...")
              return
          }
        
        
        let parameters = [Api_keys_model.FirebaseId:FirebaseId,
                          Api_keys_model.Mobile:self.phoneNumber,
                          Api_keys_model.type:self.type] as [String:AnyObject]
        
        
        
        
        self.customMethodManager?.startLoader(view:self.view)
        
        ServiceClass.shared.webServiceBasicMethod(url: SAuthApi.resend_otp, method: .post, parameters: parameters, header: nil, success: { (result) in
            print(result)
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        self.startTimer()
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
    
    //TODO: Save data to local database
    private func saveDataToLocal_DB(DeviceId:String,DeviceType:String,Email:String,FirebaseId:String,Fullname:String,Id:String,IpAddress:String,Mobile:String,Type:String,Uuid:String,token:String,MobileLogo:String,Version:String,WebLogo:String,CouponCode:String){
        let context = kAppDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User_Data", in: context)
        let user = NSManagedObject(entity: entity!, insertInto: context)
        user.setValue(DeviceId, forKey: "device_id")
        user.setValue(DeviceType, forKey: "device_type")
        user.setValue(Email, forKey: "email")
        user.setValue(FirebaseId, forKey: "firebase_id")
        user.setValue(Fullname, forKey: "full_name")
        user.setValue(Id, forKey: "id")
        user.setValue(IpAddress, forKey: "ip_address")
        user.setValue(Mobile, forKey: "mobile")
        user.setValue(Type, forKey: "type")
        user.setValue(Uuid, forKey: "uuid")
        user.setValue(token, forKey: "token")
        
        user.setValue(MobileLogo, forKey: "mobile_logo")
        user.setValue(Version, forKey: "version")
        user.setValue(WebLogo, forKey: "web_logo")
        user.setValue(CouponCode, forKey: "coupon_code")
        
        do {
           try context.save()
          } catch {
           print("Failed saving: - \(error)")
        }
        
        
        self.dismiss(animated: true) {
            let vc = AppStoryboard.tabBarSB.instantiateViewController(withIdentifier: TabBarVC.className) as! TabBarVC
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
  
    }
    
    
    
}
