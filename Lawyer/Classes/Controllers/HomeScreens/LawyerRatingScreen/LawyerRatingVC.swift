//
//  LawyerRatingVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import Cosmos
class LawyerRatingVC:SBaseViewController  {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var imgLawyer: UIImageView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var btnDismissRef: UIButton!
    @IBOutlet weak var btnDismissCRef: UIButton!
    @IBOutlet weak var btnDoneRef: UIButton!
    @IBOutlet weak var lblPopUPInstruction: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    
    @IBOutlet weak var viewBG_Txt: UIView!
    @IBOutlet weak var txtView: UITextView!
    
    //MARK: - Variables

    internal var validationMethodManager:ValidationProtocol?
    internal var customMethodManager:CustomMethodProtocol?
    internal var descriptionTxtView: String = String()
    
    internal var lawyerName:String = String()
    internal var lawyerImage:String = String()
    
    internal var LawyerId:String = String()
    internal var ConsultationId:String = String()
    internal var callBackRating:(()->())?
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initValues()
    }
    
    
    /*  //TODO: Implementation viewDidAppear
     override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated)
     
     animateView()
     } */
    
    
    //TODO: Implementation viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissKeyboard()
    }
    
    
    //MARK: - Actions, Gestures, Selectors
    //TODO: Actions
    @IBAction func btnDismissTapped(_ sender: UIButton) {
        dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnApplyTapped(_ sender: UIButton) {
        dismissKeyboard()
       
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        self.btnDoneRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.btnDoneRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                            self.btnDoneRef.transform = CGAffineTransform.identity
                            
                            self.validateFields { (strMsg, status) in
                                if status{
                                    print("hit api")
                                    self.hitSendCommentService()
                                }else{
                                    
                                    self.customMethodManager?.provideShadowAndCornerRadius(self.btnDoneRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                                    
                                    self.customMethodManager?.showToolTip(msg: strMsg, anchorView: self.viewRating, sourceView: self.view)
                                    
                                    self.customMethodManager?.showToolTip(msg: strMsg, anchorView: self.txtView, sourceView: self.view)
                                    
                                    self.txtView.becomeFirstResponder()
                                }
                            }

                            
                      
                        }
        })
    }
    
    
    
    //TODO: Selectors
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
   
    
    
}
