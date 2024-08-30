//
//  LawyerProfileVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 01/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class LawyerProfileVC: SBaseViewController {
    
    //MARK: - IBOutlets
    
    
    @IBOutlet weak var profileImageViewPlaceholder: UIView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var buttonMeetRef: UIButton!
    @IBOutlet weak var buttonCallRef: UIButton!
    @IBOutlet weak var profileTable: UITableView!
    
    
    //MARK: - Variables
    internal var lawyer:Lawyer_Model = Lawyer_Model(CityName: String(), ConsulationType_Call_Fee: String(), ConsulationType_Meet_Fee: String(), ConsulationType_Video_Call_Fee: String(), Experience_Name: String(), Expertise_String: String(), FullName: String(), Id: String(), Language_String: String(), ProfilePhoto: String(), Uuid: String())
    internal var Uuid:String = String()
    internal var Id:String = String()
    internal var name_Lawyer:String = String()
    internal var imageURL:String = String()
    internal var callPrice:String = String()
    internal var meetPrice:String = String()
    
    internal var customMethodManager:CustomMethodProtocol?
    internal var lawyerProfileVM:ProfileDataModelModeling?
    internal var lawyerDetailsVM:ProfileDataViewModelList?
    
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.app_gradient_color1
        
        return refreshControl
    }()
    
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
    
    //TODO: Implementation viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    //MARK: - Actions, Gestures, Selectors
    
    //TODO: Actions
    @IBAction func btnMeetTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.buttonMeetRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.buttonMeetRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.buttonMeetRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.buttonMeetRef.transform = CGAffineTransform.identity
                            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: AppointmentVC.className) as! AppointmentVC
                            vc.Uuid = self.Uuid
                            vc.price = self.meetPrice
                            vc.type = "1"
                            vc.lawyer = self.lawyer
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
        })
        
    }
    
    @IBAction func btnCallTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.buttonCallRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.buttonCallRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.buttonCallRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.buttonCallRef.transform = CGAffineTransform.identity
                            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: AppointmentVC.className) as! AppointmentVC
                            vc.Uuid = self.Uuid
                            vc.price = self.callPrice
                            vc.type = "0"
                            vc.lawyer = self.lawyer
                            self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
        })
        
    }
    
    
    
    //TODO: Selectors
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        lawyerDetailService()
        refreshControl.endRefreshing()
        
    }
    
    
    
}
