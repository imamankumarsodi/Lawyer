//
//  AppointmentVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import ViewAnimator
import DropDown

class AppointmentVC: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var btnBackRef: UIButton!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var btnForwardRef: UIButton!
    @IBOutlet weak var tblAppointment: UITableView!
    @IBOutlet weak var btnBookRef: UIButton!
    @IBOutlet weak var lblAlertEmpty: UILabel!
    
    //MARK: - Variables
    
    internal var lawyer:Lawyer_Model = Lawyer_Model(CityName: String(), ConsulationType_Call_Fee: String(), ConsulationType_Meet_Fee: String(), ConsulationType_Video_Call_Fee: String(), Experience_Name: String(), Expertise_String: String(), FullName: String(), Id: String(), Language_String: String(), ProfilePhoto: String(), Uuid: String())
    
    internal let dropDown = DropDown()
    internal var customMethodManager:CustomMethodProtocol?
    internal let footer: AppointmentFooterNew  = Bundle.main.loadNibNamed(AppointmentFooterNew.className, owner: self, options: nil)?.last as! AppointmentFooterNew
    
    
    internal var count_Tapped = 0
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.app_gradient_color1
        
        return refreshControl
    }()
    
    
    //TODO: Variables for api
    internal let errorView: ErrorView  = Bundle.main.loadNibNamed(ErrorView.className, owner: self, options: nil)?.first as! ErrorView
    internal var Uuid:String = String()
    internal var current_date = String()
    internal var prev_date = String()
    internal var next_date = String()
    
    internal var price:String = String()
    internal var type:String = String()
    
    internal var expertise_idArray = [String]()
    internal var expertise_nameArray = [String]()
    
    
    //MARK: - For hitting api...
    internal var appointMentVM:AppointmentDataModeling?
    internal var appointMentListVM:AppointmentTimeDataViewModelList?
    internal var validationMethodManager:ValidationProtocol?
    
    internal var expID:String = String()
    internal var expName:String = String()
    internal var selectedSlot:String = String()
    internal var BookingId:String = String()
    internal var cityName:String = String()
    
    internal var isComingFromOrder:Bool = Bool()
    internal var OrderId:String = String()
    
    // internal var data = [AppointmentViewModel]()
    
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
    
    @IBAction func btnPrevTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.setuserBtnIteraction()
                        self.btnBackRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            
                            self.btnBackRef.transform = CGAffineTransform.identity
                            self.appointmentListService(current_date:self.current_date,another_date:"prev_date",isRefresh:Bool(), btnIdentity: "PREV")
                            
                        }
                       })
        
    }
    
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.setuserBtnIteraction()
                        self.btnForwardRef.isUserInteractionEnabled = false
                        self.btnForwardRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            
                            self.btnForwardRef.transform = CGAffineTransform.identity
                            self.appointmentListService(current_date:self.current_date,another_date:"next_date",isRefresh:Bool(), btnIdentity: "NEXT")
                            
                        }
                       })
        
        
    }
    
    @IBAction func btnBookConsultationTappedNew(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.btnBookRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.btnBookRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.btnBookRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.btnBookRef.transform = CGAffineTransform.identity
                            
                            self.validateFields { (msg, status, isSlot) in
                                if status{
                                    
                                    if self.isComingFromOrder{
                                        let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: UploadDocumentVC.className) as! UploadDocumentVC
                                        /* vc.Uuid = self.Uuid
                                         vc.price = self.price
                                         vc.lawyer = self.lawyer */
                                        vc.date = self.current_date
                                        vc.selectedSlot = self.selectedSlot
                                        vc.type = self.type
                                        vc.expID = self.expID
                                        vc.expName = self.expName
                                        vc.orderId = self.OrderId
                                        vc.isComingFromOrder = self.isComingFromOrder
                                        self.navigationController?.pushViewController(vc, animated: true)
                                        
                                    }else{
                                        if let orederId = USER_DEFAULTS.value(forKey: ConstantTexts.orderID) as? String{
                                            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: UploadDocumentVC.className) as! UploadDocumentVC
                                            /* vc.Uuid = self.Uuid
                                             vc.price = self.price
                                             vc.lawyer = self.lawyer */
                                            vc.date = self.current_date
                                            vc.selectedSlot = self.selectedSlot
                                            vc.type = self.type
                                            vc.expID = self.expID
                                            vc.expName = self.expName
                                            vc.orderId = orederId
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        }else{
                                            self.hitCheckCouponService()
                                        }
                                        
                                    }
                                    
                                    
                                    
                                    
                                }else{
                                    if isSlot{
                                        
                                        self.customMethodManager?.showAlert(msg, okButtonTitle: ConstantTexts.OkBT, target: self)
                                        
                                    }
                                    /*else{
                                     self.customMethodManager?.showToolTip(msg: msg, anchorView: self.footer.lblValue, sourceView: self.view)
                                     } */
                                }
                            }
                        }
                       })
        
    }
    
    
    //TODO: Selectors
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.count_Tapped = 0
        self.btnBackRef.isHidden = self.count_Tapped <= 0 ? true : false
        self.setuserBtnIteraction()
        self.appointmentListService(current_date:self.current_date,another_date:self.next_date,isRefresh:Bool(), btnIdentity: String())
        refreshControl.endRefreshing()
    }
    
    
    
    
    
    
    
    @objc func btnBookConsultationTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.footer.btnBookConsultaionRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.footer.btnBookConsultaionRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.footer.btnBookConsultaionRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.footer.btnBookConsultaionRef.transform = CGAffineTransform.identity
                            
                            self.validateFields { (msg, status, isSlot) in
                                if status{
                                    self.hitCheckCouponService()
                                    
                                }else{
                                    if isSlot{
                                        
                                        self.customMethodManager?.showAlert(msg, okButtonTitle: ConstantTexts.OkBT, target: self)
                                        
                                    }
                                    /*else{
                                     self.customMethodManager?.showToolTip(msg: msg, anchorView: self.footer.lblValue, sourceView: self.view)
                                     } */
                                }
                            }
                        }
                       })
        
    }
    
    
    /*  @objc func btnDropDownTapped(_ sender: UIButton) {
     self.customMethodManager?.openDownOnView(dropDown: self.dropDown, array: self.expertise_nameArray, anchor: self.footer.viewLine, callBack: { (dropDown) in
     
     dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
     print("Selected item: \(item) at index: \(index)")
     
     if item == ConstantTexts.SelectLT{
     self.expName = String()
     self.expID = String()
     self.footer.lblValue.text = ConstantTexts.SelectLT
     }else{
     self.expName = item
     self.expID = self.expertise_idArray[index]
     self.footer.lblValue.text = item
     
     }
     }
     
     
     })
     
     } */
    
    
    
    
}
