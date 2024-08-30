//
//  OrderStatusVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import MessageUI
class OrderStatusVC:  SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewHeaderBG: UIView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblImage: UIImageView!
    @IBOutlet weak var tblOrderStatus: UITableView!
    
    @IBOutlet weak var btnCallRef: UIButton!
    @IBOutlet weak var btnMsgRef: UIButton!
    
   
    //MARK: - Variables
    internal var order:OrderDataViewModel = OrderDataViewModel(OrderDataModel(BookingDate: String(), BookingTime: String(), CategoryName: String(), CategoryId: String(), CityName: String(), CustomerEmail: String(), CustomerName: String(), CustomerPhone: String(), Id: String(),Query:String(),Status:String()))
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var orderModel:OrderStatusDataListViewModel?
    internal var orderVM:OrderStatusDataModeling?
    internal var SupportPhoneNumber:String = String()
    internal var SupportEmail:String = String()
    
    internal var lawyerName:String = String()
    internal var lawyerImage:String = String()
    
    internal var LawyerId:String = String()
    
    
    internal var rate:String = String()
    internal var Review:String = String()
    internal var Id: String = String()
    
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
        //  self.viewBG.gradientBackground(from: AppColor.app_gradient_color1, to: AppColor.app_gradient_color2, direction: .topToBottom)
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SCREEN_NAME = ConstantTexts.empty
    }
    
    
    
    //MARK: - Actions, Gestures, Selectors
    //TODO: Selectors
    
    @objc func btnExpendHeader(_ sender: UIButton) {
        
        if let orders = orderModel?.order{
            for index in 0..<orders.count{
                if index == sender.tag{
                    orders[index].isExpended = !orders[index].isExpended
                }else{
                    orders[index].isExpended = Bool()
                }
            }
        }
        
        DispatchQueue.main.async {
            self.tblOrderStatus.reloadData()
        }
    }
    
    
    @objc func reloadApiData(_ notification:Notification) {
        self.hitOrderDetailsService()
    }
    
    
    @objc func btnCellRateTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                       
                        let indexPath = IndexPath(row: 0, section: sender.tag)
                        if let cell = self.tblOrderStatus.cellForRow(at: indexPath) as? RateLawyer_UITableViewCell{
                            
                            self.customMethodManager?.provideShadowAndCornerRadius(cell.btnRatingRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                            cell.btnRatingRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                            
                            
                            
                        }
                        
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            
                            let indexPath = IndexPath(row: 0, section: 2)
                            if let cell = self.tblOrderStatus.cellForRow(at: indexPath) as? RateLawyer_UITableViewCell{
                                
                                
                                self.customMethodManager?.provideShadowAndCornerRadius(cell.btnRatingRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                                cell.btnRatingRef.transform = CGAffineTransform.identity
                                
                                let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: LawyerRatingVC.className) as! LawyerRatingVC
                                vc.lawyerName = self.lawyerName
                                vc.lawyerImage = self.lawyerImage
                                vc.ConsultationId = self.order.Id
                                vc.LawyerId = self.LawyerId
                                vc.callBackRating = {
                                    self.hitOrderDetailsService()
                                }
                                vc.modalPresentationStyle = .automatic //or .overFullScreen for transparency
                                self.present(vc, animated: true, completion: nil)
                                
                            }
                            
                           
                        }
                       })
        
    }
    
    
    //TODO: Actions
    
    @IBAction func btnMsgTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        self.btnMsgRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            
                            self.btnMsgRef.transform = CGAffineTransform.identity
                            
                            if self.order.Status == "3"{
                                self.navigationController?.popViewController(animated: true)
                            }else{
                                // Modify following variables with your text / recipient
                                let recipientEmail = self.SupportEmail
                                let subject = "Multi client email support"
                                let body = "This code supports sending email via multiple different email apps on iOS! :)"
                                
                                // Show default mail composer
                                if MFMailComposeViewController.canSendMail() {
                                    let mail = MFMailComposeViewController()
                                    mail.mailComposeDelegate = self
                                    mail.setToRecipients([recipientEmail])
                                    mail.setSubject(subject)
                                    mail.setMessageBody(body, isHTML: false)
                                    
                                    self.present(mail, animated: true)
                                    
                                    // Show third party email composer if default Mail app is not present
                                } else if let emailUrl = self.createEmailUrl(to: recipientEmail, subject: subject, body: body) {
                                    UIApplication.shared.open(emailUrl)
                                }
                            }
                            
                        }
                       })
        
    }
    
    @IBAction func btnCallTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        self.btnCallRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            
                            self.btnCallRef.transform = CGAffineTransform.identity
                            self.customMethodManager?.callNumber(phoneNumber: "\(self.SupportPhoneNumber)")
                        }
                       })
        
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     
     
     
    
     
     */
    
}
