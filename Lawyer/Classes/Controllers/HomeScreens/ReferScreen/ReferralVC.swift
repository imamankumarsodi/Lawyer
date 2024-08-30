//
//  ReferralVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 16/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class ReferralVC: SBaseViewController {
    
    
    //MARK: - IBOutlets
    //  @IBOutlet weak var orderListTableView: UITableView!
    
    @IBOutlet weak var lblRefer: UILabel!
    @IBOutlet weak var lblNotified: UILabel!
    @IBOutlet weak var lblWallet: UILabel!
    @IBOutlet weak var lblCouponHeading: UILabel!
    
    @IBOutlet weak var txtCoupon: UITextField!
    @IBOutlet weak var btnApplyRef: UIButton!
    @IBOutlet weak var lblShareHeading: UILabel!
    
    @IBOutlet weak var lblFB: UILabel!
    @IBOutlet weak var lblWhatsApp: UILabel!
    @IBOutlet weak var lblSMS: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblShare: UILabel!
    
    
    @IBOutlet weak var viewFB: UIView!
    @IBOutlet weak var viewWhatsApp: UIView!
    @IBOutlet weak var viewSMS: UIView!
    @IBOutlet weak var viewEmail: UIView!
    @IBOutlet weak var viewShare: UIView!
    
    //MARK: - Variables
    internal var validationMethodManager:ValidationProtocol?
    internal var customMethodManager:CustomMethodProtocol?
   
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
    
    
    @objc func btnApplyCouponTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.btnApplyRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnApplyRef.transform = CGAffineTransform.identity
                            self.isValidateCoupon { (msg, status) in
                                if status{
                                 //   self.hitCheckCouponService()
                                }else{
                                    self.customMethodManager?.showToolTip(msg: msg, anchorView: self.txtCoupon, sourceView: self.view)
                                    self.txtCoupon.becomeFirstResponder()
                                }
                            }
                        }
        })
    }

    
}
