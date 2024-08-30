//
//  PaymentVC+RazorpayPaymentCompletionProtocol.swift
//  Lawyer
//
//  Created by Aman Kumar on 11/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import Razorpay
extension PaymentVC: RazorpayPaymentCompletionProtocol{
    
    
    //TODO: Show payment
    internal func showPaymentForm(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        
        guard let logo = USER_DEFAULTS.value(forKey: ConstantTexts.mobile_logo) as? String else{
            print("No logo found...")
            return
        }
        
        //TODO: Razor pay integration
        self.razorpay = RazorpayCheckout.initWithKey(self.Key, andDelegate: self)
        
        
        let options: [String:Any] = [
            "amount": (Int(self.totalPaid)) * 100, //This is in currency subunits. 100 = 100 paise= INR 1.
            "currency": "INR",//We support more that 92 international currencies.
            "description": ConstantTexts.ConsultationPaymentLT,
            "name": ConstantTexts.AppName,
            "image": "\(logo)",
            "order_id":"\(self.RazorOrderId)",
            "prefill": [
                "contact": user.Mobile,
                "email": user.Email
            ],
            "theme": [
                "color": "#012B72"
            ]
        ]
        print(options)
        if let rzp = self.razorpay {
            rzp.open(options)
        } else {
            print("Unable to initialize")
        }
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
        
        self.customMethodManager?.showAlert(str, okButtonTitle: ConstantTexts.OkBT, target: self)

        
    }
    
    func onPaymentSuccess(_ payment_id: String) {
        print("success: ", payment_id)
        self.RazorpayPaymentId = payment_id
      //  self.generated_signature = "\(self.OrderId)|\(self.RazorpayPaymentId)".hmac(algorithm: .SHA256, key: key.data(using:.utf8)!)
        
        self.hitCheckPaymentService()
    }
    
    
}
