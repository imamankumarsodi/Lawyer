//
//  PaymentCompleteVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 12/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class PaymentCompleteVC: SBaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblKeys: UILabel!
    @IBOutlet weak var lblValues: UILabel!
    @IBOutlet weak var lblFooter: UILabel!
    @IBOutlet weak var btnHomeRef: UIButton!
    @IBOutlet weak var btnSendToOrderStatusRef: UIButton!
    
    //MARK: - Variables
    internal var lawyer:Lawyer_Model = Lawyer_Model(CityName: String(), ConsulationType_Call_Fee: String(), ConsulationType_Meet_Fee: String(), ConsulationType_Video_Call_Fee: String(), Experience_Name: String(), Expertise_String: String(), FullName: String(), Id: String(), Language_String: String(), ProfilePhoto: String(), Uuid: String())
    internal var customMethodManager:CustomMethodProtocol?
    internal var date:String = String()
    internal var time:String = String()
    internal var type:String = String()
    internal var cost:String = String()
    internal var id:String = String()
    
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
    //TODO: Actions
    @IBAction func btnGoHomeTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.btnHomeRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.btnHomeRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.btnHomeRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.btnHomeRef.transform = .identity
                            
                            NOTIFICATION_CENTER.post(name: NSNotification.Name(rawValue: ConstantTexts.paymentDone), object: ["Id":self.id])
                            self.navigationController?.popToRootViewController(animated: true)
                            
                        }
        })
        
    }
    
    
    @IBAction func btnGoOrderStatusTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.btnSendToOrderStatusRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.btnSendToOrderStatusRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.btnSendToOrderStatusRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.btnSendToOrderStatusRef.transform = .identity
                            
                            let order: OrderDataModel = OrderDataModel(BookingDate: String(), BookingTime: String(), CategoryName: String(), CategoryId: String(), CityName: String(), CustomerEmail: String(), CustomerName: String(), CustomerPhone: String(), Id: self.id, Query: String(), Status: String())
                            
                            
                            let viewController = AppStoryboard.homeSB.instantiateViewController(withIdentifier: OrderStatusVC.className) as! OrderStatusVC
                            viewController.order = OrderDataViewModel(order)
                            let navigationController = UINavigationController(rootViewController: viewController)
                            navigationController.navigationBar.isHidden = false
                            self.view.window?.rootViewController = navigationController
                            
                           
                            
                        }
        })
        
    }


}
