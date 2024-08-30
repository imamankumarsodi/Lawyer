//
//  LoginVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 23/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
class LoginVC: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var btnSendOTPRef: UIButton!
    @IBOutlet weak var lblSignUpRef_Customer: UILabel!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var logInTable: UITableView!
    
    
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var logInModel: DataStoreStructListModeling?
    internal var dataListVM:DataStoreStruct_List_ViewModel?
    internal var tag = Int()
    //MARK: - variables for the animate tableview
    internal var animationName = String()
    
    /// an enum of type TableAnimation - determines the animation to be applied to the tableViewCells
    internal var currentTableAnimation: TableAnimation = .fadeIn(duration: 0.85, delay: 0.03) {
        didSet {
            self.animationName = currentTableAnimation.getTitle()
        }
    }
    internal var animationDuration: TimeInterval = 0.85
    internal var delay: TimeInterval = 0.05
    
    
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
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
     
     
     */
    
    
    //MARK: - Actions, Gestures, Selectors
    
    //TODO: Selectors
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func lblSignUpRef_Customer_Tapped(_ sender: UITapGestureRecognizer) {
        self.tag = 0
        let vc = AppStoryboard.authSB.instantiateViewController(withIdentifier: SignUpVC.className) as! SignUpVC
        vc.tag = self.tag
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //TODO: Actions
    
    @IBAction func btnSendOTPTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.btnSendOTPRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.btnSendOTPRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.btnSendOTPRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.btnSendOTPRef.transform = CGAffineTransform.identity
                            self.isValidate()
                        }
        })
        
    }
    
    
    
    
}
