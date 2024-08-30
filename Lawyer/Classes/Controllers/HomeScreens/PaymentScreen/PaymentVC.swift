//
//  PaymentVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import DropDown
import Razorpay
class PaymentVC: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblPayment: UITableView!
    
    //MARK: - Variables
    
    internal var gstinModeling: DataStoreStructListModeling_GSTIN?
    internal var dataListVM:DataStoreStruct_GSTIN_List_ViewModel?
    
    internal var customMethodManager:CustomMethodProtocol?
    
    internal let header: PaymentHeaderView  = Bundle.main.loadNibNamed(PaymentHeaderView.className, owner: self, options: nil)?.first as! PaymentHeaderView
    
    internal let footer: PaymentFooterView  = Bundle.main.loadNibNamed(PaymentFooterView.className, owner: self, options: nil)?.last as! PaymentFooterView
    
    
    //MARK: - Variables
    internal var lawyer:Lawyer_Model = Lawyer_Model(CityName: String(), ConsulationType_Call_Fee: String(), ConsulationType_Meet_Fee: String(), ConsulationType_Video_Call_Fee: String(), Experience_Name: String(), Expertise_String: String(), FullName: String(), Id: String(), Language_String: String(), ProfilePhoto: String(), Uuid: String())
    internal var Uuid:String = String()
    internal var descriptionTxtView: String = String()
    
    internal var selectedSlot:String = String()
    internal var date:String = String()
    
    internal var Docs:String = String()
    internal var price:String = String()
    internal var type:String = String()
    internal var expID:String = String()
    internal var expName:String = String()
    
    
    internal var amountPaid:Double = Double()
    internal var gst18Paid:Double = Double()
    internal var totalPaid:Double = Double()
    internal var desc:String = String()
    
    
    internal var stateName:String = String()
    internal var stateID:String = String()
    internal var stateModel:[State_DataModel] = [State_DataModel]()
    internal var states:[String] = [String]()
    
    internal let dropDown = DropDown()
    internal var validationMethodManager:ValidationProtocol?
    
    //MARK: - variables for RazorpayCheckout
    internal var razorpay: RazorpayCheckout!
    internal var OrderId:String = String()
    internal var RazorOrderId:String = String()
    internal var Key:String = String()
    internal var BookedConsulationId:String = String()
    internal var RazorpayPaymentId:String = String()
    internal var generated_signature:String = String()
    internal var wallet:Int = Int()
    internal var isWalletSelected:Bool = Bool()
    internal var isComingFromOrder:Bool = Bool()
    
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
        print(self.OrderId)
        
        
        
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
    
    
    
    @objc func btnDropDownTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        let indexPath = IndexPath(row: sender.tag, section: 0)
                        if let cell = self.tblPayment.cellForRow(at: indexPath) as? GSTIN_TableViewCellAndXib{
                            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                        }
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            let indexPath = IndexPath(row: sender.tag, section: 0)
                            if let cell = self.tblPayment.cellForRow(at: indexPath) as? GSTIN_TableViewCellAndXib{
                                cell.transform = CGAffineTransform.identity
                                
                                self.customMethodManager?.openDownOnView(dropDown: self.dropDown, array: self.states, anchor: cell.textField, callBack: { (dropDown) in
                                    dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                                        print("Selected item: \(item) at index: \(index)")
                                        cell.textField.text = item
                                        self.dataListVM?.dataStoreStructs[sender.tag].value = item
                                        self.stateName = item
                                        self.stateID = self.stateModel[sender.tag].Id
                                    }
                                })
                            }
                        }
        })
    }
    
    
    @objc func switchChanged(mySwitch: UISwitch) {
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 1 // Whatever line spacing you want in points
        
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.HaveGSTIN_LT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        if self.header.switch_Ref.isOn{
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.HaveGSTIN_Ins_LT)", font: AppFont.Regular.size(AppFontName.OpenSans, size: 12), color: AppColor.textColor) ?? NSMutableAttributedString())
            
        }
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        // *** Set Attributed String to your label ***
        header.lblGSTIN.numberOfLines = 0
        header.lblGSTIN.attributedText = myMutableString
        
        _ = self.dataListVM?.dataStoreStructs.map{$0.value = ConstantTexts.empty}
        self.stateName = ConstantTexts.empty
        self.stateID = ConstantTexts.empty
        
        self.tblPayment.reloadData()
        // Do something
    }
    
    
    @objc func btnCheckOutTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.footer.btnCheckOutRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.footer.btnCheckOutRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.footer.btnCheckOutRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.footer.btnCheckOutRef.transform = CGAffineTransform.identity
                            //TODO: Temp code need to remove
                            if self.header.switch_Ref.isOn{
                                self.isValidate()
                            }else{
                               self.hitCreateOrderService()
                            }
                        }
        })
        
    }
    
    
    @objc func btnApplyCouponTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.header.btnApplyRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.header.btnApplyRef.transform = CGAffineTransform.identity
                            self.isValidateCoupon { (msg, status) in
                                if status{
                                    self.hitCheckCouponService()
                                }else{
                                    self.customMethodManager?.showToolTip(msg: msg, anchorView: self.header.txtCoupon, sourceView: self.view)
                                    self.header.txtCoupon.becomeFirstResponder()
                                }
                            }
                        }
        })
    }
    
    
    @objc func btnPayWalletTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.header.btnWalletRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.header.btnWalletRef.transform = CGAffineTransform.identity
                            if self.wallet < 590{
                                self.customMethodManager?.showAlert(ConstantTexts.LowWalletLT, okButtonTitle: ConstantTexts.OkBT, target: self)
                                
                            }else{
                                self.isWalletSelected = !self.isWalletSelected
                                self.cutWallet(isWalletSelected:self.isWalletSelected)
                            }
                            
                            
                        }
        })
    }
    
    
    @objc func btnbtnChangeDateTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.header.btnChangeDateRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.header.btnChangeDateRef.transform = CGAffineTransform.identity
                            super.goBackToIndex(2)
                        }
        })
    }
    
    
    
    
}
