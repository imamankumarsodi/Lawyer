//
//  OTP_VC.swift
//  Lawyer
//
//  Created by Aman Kumar on 23/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class OTP_VC: SBaseViewController {
    //MARK: - IBOutlets
    
    @IBOutlet weak var otpView: VPMOTPView!
    @IBOutlet weak var lblInstruction: UILabel!
    @IBOutlet weak var btnDoneOTPRef: UIButton!
    @IBOutlet weak var btnResendOTPRef: UIButton!
    @IBOutlet weak var lblTimer: UILabel!
    @IBOutlet weak var btnDismissRef: UIButton!
    
    
    //MARK: - Variables
    internal var enteredOtp: String = String()
    internal var customMethodManager:CustomMethodProtocol?
    internal var validationMethodManager:ValidationProtocol?
    
    internal var timer: Timer?
    internal var time: Int = 30
    internal var phoneNumber: String = String()
    internal var type: String = String()
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initValues()
    }
    
    
    //TODO: Implementation viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navSetup()
    }
    
    //TODO: Implementation viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissKeyboard()
        stopTimer()
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     
     
     /*  */
     
     
     }
     */
    
    
    //MARK: - Actions, Gestures, Selectors
    //TODO: Actions
    
    @IBAction func btnDismissTapped(_ sender: UIButton) {
        dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
        
        
    }
  
    @IBAction func btnDoneTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.btnDoneOTPRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.btnDoneOTPRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.btnDoneOTPRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.btnDoneOTPRef.transform = CGAffineTransform.identity
                            self.isValidate()
                        }
        })
        
    }
    
    @IBAction func btnResendTapped(_ sender: UIButton) {
        hitResendOTP_Service()
    }
    
    
    //TODO: Selectors
    @objc func runTimedCode(){
        if time > 0{
            time -= 1
            lblTimer.text = (time > 9) ? "\(ConstantTexts.ResendInLT) 00:\(time)" : "\(ConstantTexts.ResendInLT) 00:0\(time)"
        }else{
            stopTimer()
        }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}
