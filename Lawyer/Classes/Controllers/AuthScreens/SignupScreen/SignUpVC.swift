//
//  SignUpVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 23/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
class SignUpVC: SBaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var registerTable: UITableView!

    @IBOutlet weak var btnRegisterRef: UIButton!
    @IBOutlet weak var lblInstruction_SignIn_Customer: UILabel!
    
    
    //MARK: - Variables
    public var tag = Int()
    
    
    internal var customMethodManager:CustomMethodProtocol?
    internal var registerListModel: DataStoreStructListModeling?
    internal var dataListVM:DataStoreStruct_List_ViewModel?
   
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
    //TODO: Actions
    
    
    //TODO: Selectors
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @objc func lblInstruction_SignIn_Customer_Tapped(_ sender: UITapGestureRecognizer) {
        self.tag = 0
        self.navigationController?.popViewController(animated: true)
    }
    

    @IBAction func btnSendOTPTapped(_ sender: UIButton) {
           UIView.animate(withDuration: 0.1,
           animations: {
               self.customMethodManager?.provideShadowAndCornerRadius(self.btnRegisterRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, 0, 0, 0, 0, 0, AppColor.clearColor)
               self.btnRegisterRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
           },
           completion: { _ in
               UIView.animate(withDuration: 0.1) {
                   self.customMethodManager?.provideShadowAndCornerRadius(self.btnRegisterRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                   self.btnRegisterRef.transform = CGAffineTransform.identity
                   self.isValidate()
               }
           })
    
       }
    
    
    
}
