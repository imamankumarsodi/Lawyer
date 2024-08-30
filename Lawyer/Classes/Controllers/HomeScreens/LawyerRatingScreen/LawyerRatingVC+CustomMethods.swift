//
//  LawyerRatingVC+CustomMethods.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator

extension LawyerRatingVC{
    
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
        
        self.customMethodManager?.provideCornerRadiusTo(self.viewBG, 5, [.layerMinXMinYCorner,.layerMaxXMinYCorner])
        
        self.customMethodManager?.provideCornerRadiusTo(self.imgLawyer, 3, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
       // self.customMethodManager?.setImage(imageView: self.imgLawyer, url: self.lawyerImage)
        
        self.btnDismissCRef.tintColor = AppColor.app_gradient_color1
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.btnDoneRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
       // self.customMethodManager?.provideCornerBorderTo(self.btnDoneRef, 1, AppColor.darkGrayColor)
        
        self.btnDoneRef.backgroundColor = AppColor.app_gradient_color1
        self.btnDoneRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        self.btnDoneRef.setTitle(ConstantTexts.Submit_BT, for: .normal)
        self.btnDoneRef.setTitleColor(AppColor.whiteColor, for: .normal)
        
        self.lblPopUPInstruction.numberOfLines = 0
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleCenter = NSMutableParagraphStyle()
        paragraphStyleCenter.alignment = .center
        
        // *** set LineSpacing property in points ***
        paragraphStyleCenter.lineSpacing = 1 // Whatever line spacing you want in points
        
       let myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(self.lawyerName)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\n\(ConstantTexts.RateLawyerLT) ", font: AppFont.Regular.size(AppFontName.OpenSans, size: 12), color: AppColor.textColor) ?? NSMutableAttributedString())
       
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
        self.lblPopUPInstruction.attributedText = myMutableString
        
        self.viewRating.sizeToFit()
        self.viewRating.rating = 0
        self.viewRating.backgroundColor = AppColor.clearColor
        
        
        self.txtView.font = AppFont.Italic.size(AppFontName.OpenSans, size: 12)
        self.txtView.text = ConstantTexts.WriteCommentNewPH
        self.txtView.textColor = AppColor.darkGrayColor
        self.txtView.delegate = self
        
        self.customMethodManager?.provideCornerRadiusTo(self.viewBG_Txt, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.viewBG_Txt.backgroundColor = AppColor.tableBGColor
        self.txtView.backgroundColor = AppColor.tableBGColor
     
     
  
    }
    
    
    
    //TODO: Validate fields implementation
    internal func validateFields(validHandler: @escaping ( String, Bool) -> Void){
        
        if !validationMethodManager!.checkEmptyField(self.txtView.text.trimmingCharacters(in: .whitespacesAndNewlines)) && self.viewRating.rating <= 0.0 {
         validHandler( ConstantTexts.EnterRateCommentALERT, Bool())
         return
         
         }
         
         
        if self.txtView.text.trimmingCharacters(in: .whitespacesAndNewlines) == ConstantTexts.WriteCommentNewPH && self.viewRating.rating <= 0.0 {
         validHandler( ConstantTexts.EnterRateCommentALERT, Bool())
         return
         }
         
         validHandler(ConstantTexts.empty,  true)
        
    }
    
    //MARK: - Web services
    //TODO: check-coupon Service
    internal func hitSendCommentService(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        let msg = self.txtView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ConstantTexts.WriteCommentNewPH ? String() : self.txtView.text!.trimmingCharacters(in: .whitespacesAndNewlines)
      
        let parameters = [Api_keys_model.Message:msg,
                          Api_keys_model.UserId:user.Id,
                          Api_keys_model.ConsultationId:self.ConsultationId,
                          Api_keys_model.LawyerId:self.LawyerId,
                          Api_keys_model.Ratnig:"\(self.viewRating.rating)"] as [String:AnyObject]
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: SCustomerApi.lawyer_ratingt_V2, method: .post, parameters: parameters, header: header, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                          //  self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)

                            NOTIFICATION_CENTER.post(name: NSNotification.Name(rawValue: ConstantTexts.paymentDone), object: nil)
                            self.callBackRating?()
                            self.dismiss(animated: true, completion: nil)
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
