//
//  PaymentVC+MethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import Razorpay
extension PaymentVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.PaymentHT, leftBarButtonsType: [.back], rightBarButtonsType: [])
        
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
        if self.gstinModeling == nil {
            self.gstinModeling = PaymentVM.shared
        }
        
        if  self.dataListVM == nil{
            self.dataListVM = self.gstinModeling?.prepareDataSource()
        }
        
        
        initialSetup()
        
    }
    
    
    //TODO: Intial setup implementation
    private func initialSetup(){
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        if self.isComingFromOrder{
            print("True")
            print(self.OrderId)
        }else{
            print("false")

            if let orderID = USER_DEFAULTS.value(forKey: ConstantTexts.orderID) as? String{
                self.OrderId = orderID
                print(self.OrderId)
            }
        }
        
        self.tblPayment.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        self.tblPayment.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        
        self.tblPayment.sectionHeaderHeight = 0.0;
        self.tblPayment.sectionFooterHeight = 0.0;
        
        self.tblPayment.separatorStyle = .none
        self.tblPayment.hideEmptyCells()
        self.tblPayment.isHidden = false
        self.tblPayment.isScrollEnabled = true
        self.tblPayment.backgroundColor = AppColor.tableBGColor
        registerNib()
        
        self.header.viewUser.backgroundColor = AppColor.whiteColor
        self.customMethodManager?.provideCornerBorderTo(self.header.viewUser, 0.8, AppColor.placeholderColor)
        
        self.header.lblUserHeading.font = AppFont.Bold.size(AppFontName.OpenSans, size: 14)
        self.header.lblUserHeading.textColor = AppColor.app_gradient_color1
        self.header.lblUserHeading.numberOfLines = 0
        self.header.lblUserHeading.text = ConstantTexts.UserDetail_LT
        
        
        self.header.imgName.image = UIImage(systemName: "person.circle") ?? UIImage()
        self.header.imgName.setImageTintColor(AppColor.darkGrayColor)
        self.header.imgName.contentMode = .scaleToFill
        self.header.lblName.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.lblName.textColor = AppColor.darkGrayColor
        self.header.lblName.numberOfLines = 0
        
        self.header.imgEmail.image = UIImage(systemName: "envelope") ?? UIImage()
        self.header.imgEmail.setImageTintColor(AppColor.darkGrayColor)
        self.header.imgEmail.contentMode = .scaleToFill
        self.header.lblEmail.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.lblEmail.textColor = AppColor.darkGrayColor
        self.header.lblEmail.numberOfLines = 0
        
        self.header.imgPhone.image = UIImage(systemName: "phone") ?? UIImage()
        self.header.imgPhone.setImageTintColor(AppColor.darkGrayColor)
        self.header.imgPhone.contentMode = .scaleToFill
        self.header.lblPhone.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.lblPhone.textColor = AppColor.darkGrayColor
        self.header.lblPhone.numberOfLines = 0
        
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideUnderlineAttributedText(text: "\(ConstantTexts.ChangeDateAndTimeBT)", font: AppFont.Bold.size(AppFontName.OpenSans, size: 10), AppColor.app_gradient_color1) ?? NSMutableAttributedString())
        self.header.btnChangeDateRef.setAttributedTitle(myMutableString, for: .normal)
        self.header.btnChangeDateRef.addTarget(self, action: #selector(btnbtnChangeDateTapped), for: .touchUpInside)
        
        
        self.header.viewConsultation.backgroundColor = AppColor.whiteColor
        self.customMethodManager?.provideCornerBorderTo(self.header.viewConsultation, 0.8, AppColor.placeholderColor)
        
        self.header.lblConsultationHeader.font = AppFont.Bold.size(AppFontName.OpenSans, size: 14)
        self.header.lblConsultationHeader.textColor = AppColor.app_gradient_color1
        self.header.lblConsultationHeader.numberOfLines = 0
        self.header.lblConsultationHeader.text = ConstantTexts.ConsultationDetail_LT
        
        self.header.lblDetailLeft.numberOfLines = 0
        self.header.lblDetailRightt.numberOfLines = 0
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleLeft = NSMutableParagraphStyle()
        paragraphStyleLeft.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyleLeft.lineSpacing = 1 // Whatever line spacing you want in points
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.LawyerNameLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(lawyer.FullName)\n\n", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.DateLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(self.date)\n\n", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
     
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.ConsultationCostLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        self.amountPaid = round(Double(self.price) ?? 0.0)
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.CurLT) \(self.amountPaid)", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleLeft, range:NSMakeRange(0, myMutableString.length))
        self.header.lblDetailLeft.attributedText = myMutableString
        
        
        
        
        
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleRight = NSMutableParagraphStyle()
        paragraphStyleRight.alignment = .right
        
        // *** set LineSpacing property in points ***
        paragraphStyleRight.lineSpacing = 1 // Whatever line spacing you want in points
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.ConsultationTypeLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        let c_type:String = self.type == "0" ? ConstantTexts.CallConsultationLT : ConstantTexts.MeetConsultationLT
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(c_type)\n\n", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.TimeLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(self.selectedSlot)\n\n", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.ConsultationCaseTypeLT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        self.amountPaid = round(Double(self.price) ?? 0.0)
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(self.expName)", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleRight, range:NSMakeRange(0, myMutableString.length))
        self.header.lblDetailRightt.attributedText = myMutableString
        
        self.header.viewPayment.backgroundColor = AppColor.whiteColor
        self.customMethodManager?.provideCornerBorderTo(self.header.viewPayment, 0.8, AppColor.placeholderColor)
        
        
        
        
        self.header.paymentSummaryTitle.font = AppFont.Bold.size(AppFontName.OpenSans, size: 14)
        self.header.paymentSummaryTitle.textColor = AppColor.app_gradient_color1
        self.header.paymentSummaryTitle.numberOfLines = 0
        self.header.paymentSummaryTitle.text = ConstantTexts.PaySummary_LT
        
        self.header.originalPriceTitle.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.originalPriceTitle.textColor = AppColor.darkGrayColor
        self.header.originalPriceTitle.numberOfLines = 0
        self.header.originalPriceTitle.text = ConstantTexts.OriginalPrice_LT
        
        self.header.originalPriceValue.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.originalPriceValue.textColor = AppColor.darkGrayColor
        self.header.originalPriceValue.numberOfLines = 0
        
        self.header.gstPriceTitle.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.gstPriceTitle.textColor = AppColor.darkGrayColor
        self.header.gstPriceTitle.numberOfLines = 0
        self.header.gstPriceTitle.text = "\(ConstantTexts.Gst_LT)\(18)\(ConstantTexts.Per_LT)"
        
        self.header.gstPriceValue.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.gstPriceValue.textColor = AppColor.darkGrayColor
        self.header.gstPriceValue.numberOfLines = 0
        
        self.header.couponAppliedTitle.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.couponAppliedTitle.textColor = AppColor.passGreenColor
        self.header.couponAppliedTitle.numberOfLines = 0
        self.header.couponAppliedTitle.text = ConstantTexts.CouponApplied_LT
        self.header.couponAppliedTitle.isHidden = true
        
        self.header.imgCoupon.image = #imageLiteral(resourceName: "check")
        self.header.imgCoupon.setImageTintColor(AppColor.passGreenColor)
        self.header.imgCoupon.isHidden = true
        
        self.header.totalPriceTitle.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.header.totalPriceTitle.textColor = AppColor.darkGrayColor
        self.header.totalPriceTitle.numberOfLines = 0
        self.header.totalPriceTitle.text = ConstantTexts.Total_LT
        
        self.header.totalPriceValue.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.header.totalPriceValue.textColor = AppColor.darkGrayColor
        self.header.totalPriceValue.numberOfLines = 0
        
        self.header.viewBGTotal.backgroundColor = AppColor.tableBGColor
        
        self.header.txtCoupon.addBorders(edges: [.top,.bottom,.left], color: AppColor.placeholderColor, inset: 0.0, thickness: 1.0)
        self.header.txtCoupon.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.txtCoupon.placeholder = ConstantTexts.CouponCode_PH
        self.header.txtCoupon.textColor = AppColor.textColor
        self.header.txtCoupon.addPadding(.both(10.0))
        
       // self.header.txtCoupon.maxLength = 10
        self.header.txtCoupon.keyboardType = .default
        self.header.txtCoupon.isSecureTextEntry = false
        self.header.txtCoupon.autocapitalizationType = .allCharacters
        
        self.header.btnApplyRef.addBorders(edges: [.top,.bottom,.left,.right], color: AppColor.placeholderColor, inset: 0.0, thickness: 1.0)
        self.header.btnApplyRef.tintColor = AppColor.whiteColor
        self.header.btnApplyRef.backgroundColor = AppColor.app_gradient_color1
        self.header.btnApplyRef.setTitle(ConstantTexts.Apply_BT, for: .normal)
        self.header.btnApplyRef.titleLabel?.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.btnApplyRef.addTarget(self, action: #selector(btnApplyCouponTapped), for: .touchUpInside)
        
        
        self.header.viewSwitch.backgroundColor = AppColor.tableBGColor
        self.header.switch_Ref.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        
        
        guard let user = customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        self.header.lblName.text = user.Fullname
        self.header.lblEmail.text = user.Email
        self.header.lblPhone.text = "\(ConstantTexts.CountryCodeLT)\(ConstantTexts.DashLT)\(user.Mobile)"
        
        
        self.header.originalPriceValue.text = "\(ConstantTexts.CurLT) \(self.amountPaid)"
        
        self.gst18Paid = round(self.getPercentValue(value: self.amountPaid, percentage: 18.0))
        self.header.gstPriceValue.text = "\(ConstantTexts.CurLT) \(self.gst18Paid)"
        
        self.totalPaid = round(self.amountPaid + self.gst18Paid)
        self.header.totalPriceValue.text = "\(ConstantTexts.CurLT) \(self.totalPaid)"
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 1 // Whatever line spacing you want in points
        
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.HaveGSTIN_LT)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        if self.header.switch_Ref.isOn{
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.HaveGSTIN_Ins_LT)", font: AppFont.Regular.size(AppFontName.OpenSans, size: 12), color: AppColor.textColor) ?? NSMutableAttributedString())
        }
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        
        // *** Set Attributed String to your label ***
        header.lblGSTIN.numberOfLines = 0
        header.lblGSTIN.attributedText = myMutableString
        
        
        self.header.btnWalletRef.tintColor = AppColor.darkGrayColor
        self.header.btnWalletRef.setTitleColor(AppColor.darkGrayColor, for: .normal)
        self.header.btnWalletRef.setTitle(ConstantTexts.Use_Wallet_BT, for: .normal)
        self.header.btnWalletRef.titleLabel?.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.header.btnWalletRef.addTarget(self, action: #selector(btnPayWalletTapped), for: .touchUpInside)
        
        
        self.header.lblWallet.numberOfLines = 0
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleCenter = NSMutableParagraphStyle()
        paragraphStyleCenter.alignment = .center
        
        // *** set LineSpacing property in points ***
        paragraphStyleCenter.lineSpacing = 1 // Whatever line spacing you want in points
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.YourBalanceLT)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.CurLT) ", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 20), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        if self.wallet < 590{
            
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(self.wallet)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 30), color: AppColor.errorColor) ?? NSMutableAttributedString())
            
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n(\(ConstantTexts.LowWalletLT))", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
            
            
        }else{
            
            myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(self.wallet)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 30), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
            
        }
        
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
        self.header.lblWallet.attributedText = myMutableString
        
        
        if let statesModels = self.customMethodManager?.getStates().0{
            self.stateModel = statesModels
        }
        
        if let statesName = self.customMethodManager?.getStates().1{
            self.states = statesName
        }
        
        
        
        
    }
    
    
    
    //TODO: register nib file
    private func registerNib(){
        self.tblPayment.register(nib: GSTIN_TableViewCellAndXib.className)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.tblPayment.isHidden = false
            
            /* self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay) */
            
            self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 55,duration: self.animationDuration, delay: self.delay)
            
            self.tblPayment.reloadData()
        }
    }
    
    
    //TODO: get 18% percent value
    private func getPercentValue(value:Double,percentage:Double)->Double{
        return percentage/100.0 * value
    }
    
    
    
    //TODO: setup validation
    internal func isValidate(){
        dismissKeyboard()
        
        if let dataListVM_T = self.dataListVM{
            self.gstinModeling?.validateFields(dataStore: dataListVM_T, validHandler: { (strMsg, status, row, section) in
                if status{
                    self.hitCreateOrderService()
                }else{
                    let indexPath = IndexPath(row: row, section: section)
                    
                    if let cell = self.tblPayment.cellForRow(at: indexPath) as? GSTIN_TableViewCellAndXib{
                        
                        self.customMethodManager?.showToolTip(msg: strMsg, anchorView: cell.textField, sourceView: self.view)
                        if row != 2{
                            cell.textField.becomeFirstResponder()
                        }
                    }
                }
            })
        }
    }
    
    
    //TODO: setup validation for coupon
    internal func isValidateCoupon(validHandler: @escaping ( String, Bool) -> Void){
        dismissKeyboard()
        
        if !validationMethodManager!.checkEmptyField(self.header.txtCoupon.text!.trimmingCharacters(in: .whitespacesAndNewlines)){
            validHandler( ConstantTexts.EnterCouponCodeALERT, Bool())
            return
            
        }
        
        validHandler(ConstantTexts.empty,  true)
        
    }
    
    
    //TODO: setup cut wallet
    internal func cutWallet(isWalletSelected:Bool){
        
        if isWalletSelected{
            self.header.btnWalletRef.setImage(UIImage(systemName: "checkmark.square") ?? UIImage(), for: .normal)
            self.header.btnApplyRef.tintColor = AppColor.whiteColor
            self.header.btnApplyRef.setTitleColor(AppColor.whiteColor, for: .normal)
            self.header.btnApplyRef.backgroundColor = AppColor.app_gradient_color1
            self.header.btnApplyRef.setTitle(ConstantTexts.Apply_BT, for: .normal)
            self.header.txtCoupon.text = ConstantTexts.empty
            self.header.btnApplyRef.isUserInteractionEnabled = true
            self.header.couponAppliedTitle.isHidden = true
            self.header.imgCoupon.isHidden = true
            self.header.txtCoupon.isUserInteractionEnabled = true
            
            self.amountPaid = Double(self.price) ?? 0.0
            
            self.header.originalPriceValue.text = "\(ConstantTexts.CurLT) \(self.amountPaid)"
            self.gst18Paid = round(self.getPercentValue(value: self.amountPaid, percentage: 18.0))
            self.header.gstPriceValue.text = "\(ConstantTexts.CurLT) \(self.gst18Paid)"
            self.totalPaid = round(self.amountPaid + self.gst18Paid)
            self.header.totalPriceValue.text = "\(ConstantTexts.CurLT) \(self.totalPaid)"
            
        }else{
            self.header.btnWalletRef.setImage(UIImage(systemName: "squareshape") ?? UIImage(), for: .normal)
        }

    }
    
    
    
    //MARK: - Web services
    //TODO: check-coupon Service
    internal func hitCheckCouponService(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        let parameters = [Api_keys_model.AppliedCoupon:self.header.txtCoupon.text!.trimmingCharacters(in: .whitespacesAndNewlines)] as [String:AnyObject]
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: SCustomerApi.check_coupon, method: .post, parameters: parameters, header: header, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                                if let Discount = data.value(forKey: "Discount") as? String{
                                    
                                    if let discount_type = data.value(forKey: "DiscountType") as? String{
                                        if discount_type == "amount"{
                                            
                                          //  self.amountPaid = self.amountPaid - self.getPercentValue(value: self.amountPaid, percentage: Double(Discount) ?? 0.0)
                                            
                                            self.amountPaid = self.amountPaid - (Double(Discount) ?? 0.0)
                                            
                                            
                                            self.header.originalPriceValue.text = "\(ConstantTexts.CurLT) \(self.amountPaid)"
                                            
                                            self.gst18Paid = round(self.getPercentValue(value: self.amountPaid, percentage: 18.0))
                                            self.header.gstPriceValue.text = "\(ConstantTexts.CurLT) \(self.gst18Paid)"
                                            self.totalPaid = round(self.amountPaid + self.gst18Paid)
                                            self.header.totalPriceValue.text = "\(ConstantTexts.CurLT) \(self.totalPaid)"
                                            
                                            self.header.couponAppliedTitle.isHidden = false
                                            self.header.imgCoupon.isHidden = false
                                            self.header.btnApplyRef.isUserInteractionEnabled = false
                                            self.header.btnApplyRef.backgroundColor = AppColor.tableBGColor
                                            self.header.btnApplyRef.setTitleColor(AppColor.darkGrayColor, for: .normal)
                                            self.header.btnApplyRef.setTitle(ConstantTexts.Applied_BT, for: .normal)
                                            self.header.txtCoupon.isUserInteractionEnabled = false
                                            print(self.amountPaid)
                                            
                                            self.isWalletSelected = Bool()
                                            self.cutWallet(isWalletSelected:self.isWalletSelected)
                                        }else{
                                            
                                            self.amountPaid = self.amountPaid - self.getPercentValue(value: self.amountPaid, percentage: Double(Discount) ?? 0.0)
                                            
                                          //  self.amountPaid = self.amountPaid - (Double(Discount) ?? 0.0)
                                            
                                            
                                            self.header.originalPriceValue.text = "\(ConstantTexts.CurLT) \(self.amountPaid)"
                                            
                                            self.gst18Paid = round(self.getPercentValue(value: self.amountPaid, percentage: 18.0))
                                            self.header.gstPriceValue.text = "\(ConstantTexts.CurLT) \(self.gst18Paid)"
                                            self.totalPaid = round(self.amountPaid + self.gst18Paid)
                                            self.header.totalPriceValue.text = "\(ConstantTexts.CurLT) \(self.totalPaid)"
                                            
                                            self.header.couponAppliedTitle.isHidden = false
                                            self.header.imgCoupon.isHidden = false
                                            self.header.btnApplyRef.isUserInteractionEnabled = false
                                            self.header.btnApplyRef.backgroundColor = AppColor.tableBGColor
                                            self.header.btnApplyRef.setTitleColor(AppColor.darkGrayColor, for: .normal)
                                            self.header.btnApplyRef.setTitle(ConstantTexts.Applied_BT, for: .normal)
                                            self.header.txtCoupon.isUserInteractionEnabled = false
                                            print(self.amountPaid)
                                            
                                            self.isWalletSelected = Bool()
                                            self.cutWallet(isWalletSelected:self.isWalletSelected)
                                        }
                                    }
                                    
                                    
                                }
                            }
                            
                            
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                        }
                    }else if code == 401{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.customMethodManager?.deleteAllData(entity: "User_Data", success: {
                                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                                    })
                                }
                            })
                            
                           
                        }
                    }else{
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                        }
                        
                    }
                }
            }
            
        }) { (error) in
            print(error)
            self.customMethodManager?.stopLoader(view:self.view)
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)

                
            }else{
                
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)

                
            }
            
        }
    }
    
    
    //TODO: create-order Service
    internal func hitCreateOrderService(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        let walletStrin:String = self.isWalletSelected ? "1" : "0"
        
        let parameters = [Api_keys_model.Wallet: walletStrin,
                          Api_keys_model.CasTypeId: self.expID,
                          Api_keys_model.CaseTypeName: self.expName,
                          Api_keys_model.CompanyAddress: self.dataListVM?.dataStoreStructAtIndex(3).value ?? String(),
                          Api_keys_model.CompanyName: self.dataListVM?.dataStoreStructAtIndex(1).value ?? String(),
                          Api_keys_model.ConsultDate: self.date,
                          Api_keys_model.ConsultTime: self.selectedSlot,
                          Api_keys_model.ConsultType: self.type,
                          Api_keys_model.Docs: self.Docs,
                          Api_keys_model.OrderId: self.OrderId,
                          Api_keys_model.GstIn: self.dataListVM?.dataStoreStructAtIndex(0).value ?? String(),
                          Api_keys_model.IsGstin: self.header.switch_Ref.isOn,
                          Api_keys_model.LawyerId: self.Uuid,
                          Api_keys_model.PackageID: self.Uuid,
                          Api_keys_model.Name: user.Fullname,
                          Api_keys_model.MobileNo: "\(ConstantTexts.CountryCodeLT) \(user.Mobile)",
            Api_keys_model.Email: user.Email,
            Api_keys_model.QueryData: self.desc,
            Api_keys_model.Receipt:"\(100000 + arc4random_uniform(900000))",
            Api_keys_model.StateName: self.stateName,
            Api_keys_model.StateId: self.stateID,
            Api_keys_model.CoupanCode:"\(self.header.txtCoupon.text!.trimmingCharacters(in: .whitespacesAndNewlines))"] as [String:AnyObject]
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: SCustomerApi.create_order_V2, method: .post, parameters: parameters, header: header, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200 || code == 201{
                        
                        if let _ = result_Dict.value(forKey: "message") as? String{
                            
                            if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                                print(data)
                                if let OrderId = data.value(forKey: "OrderId") as? String{
                                    self.OrderId = OrderId
                                }
                                
                                if let RazorOrderId = data.value(forKey: "RazorOrderId") as? String{
                                    self.RazorOrderId = RazorOrderId
                                }
                                
                                
                                if let Key = data.value(forKey: "Key") as? String{
                                    self.Key = Key
                                }
                                
                                if let BookedConsulationId = data.value(forKey: "BookedConsulation") as? String{
                                    self.BookedConsulationId = BookedConsulationId
                                }
                                
                                if let BookedConsulationId = data.value(forKey: "BookedConsulation") as? Int{
                                    self.BookedConsulationId = "\(BookedConsulationId)"
                                }
                                
                                
                                if self.isWalletSelected{
                                    
                                    if USER_DEFAULTS.value(forKey: ConstantTexts.orderID) != nil{
                                    USER_DEFAULTS.removeObject(forKey: ConstantTexts.orderID)
                                    }
                                    
                                    let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: PaymentCompleteVC.className) as! PaymentCompleteVC
                                    vc.lawyer = self.lawyer
                                    vc.date = self.date
                                    vc.time = self.selectedSlot
                                    vc.type = self.type == "0" ? ConstantTexts.CallConsultationLT : ConstantTexts.MeetConsultationLT
                                    vc.cost = "\(ConstantTexts.CurLT) \(self.amountPaid)"
                                    vc.id = self.OrderId
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }else{
                                    self.showPaymentForm()
                                }
                                
                                
                            }
                            
                        }
                    }else if code == 404{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    super.goBackToIndex(2)
                                    
                                }
                            })
                            
                        }
                        
                    }else if code == 401{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.customMethodManager?.deleteAllData(entity: "User_Data", success: {
                                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                                    })
                                }
                            })

                            
                        }
                    }else{
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                        }
                        
                    }
                }
            }
            
        }) { (error) in
            print(error)
            self.customMethodManager?.stopLoader(view:self.view)
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
            }else{
                
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)

                
            }
            
        }
    }
    
    
    
    //TODO: create-order Service
    internal func hitCheckPaymentService(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        let parameters = [Api_keys_model.RazorpayOrderId: self.RazorOrderId,
                          Api_keys_model.RazorpayPaymentId: self.RazorpayPaymentId,
                          Api_keys_model.RazorpaySignature:self.generated_signature,
                          Api_keys_model.TaxAmount: "\(self.gst18Paid)",
            Api_keys_model.Amount: "\(self.amountPaid)",
            Api_keys_model.BookedConsulationId: self.OrderId] as [String:AnyObject]
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: SCustomerApi.check_payment_V2, method: .post, parameters: parameters, header: header, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        USER_DEFAULTS.removeObject(forKey: ConstantTexts.orderID)
                        
                        let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: PaymentCompleteVC.className) as! PaymentCompleteVC
                        vc.lawyer = self.lawyer
                        vc.date = self.date
                        vc.time = self.selectedSlot
                        vc.type = self.type == "0" ? ConstantTexts.CallConsultationLT : ConstantTexts.MeetConsultationLT
                        vc.cost = "\(ConstantTexts.CurLT) \(self.amountPaid)"
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        
                      /*  if let message = result_Dict.value(forKey: "message") as? String{
                            _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: message, style: .success, buttonTitle: ConstantTexts.OkBT, action: { (status) in
                                if status{
                                    print("Screen new wali par le jao")
                                    let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: PaymentCompleteVC.className) as! PaymentCompleteVC
                                    vc.lawyer = self.lawyer
                                    vc.date = self.date
                                    vc.time = self.selectedSlot
                                    vc.type = self.type == "0" ? ConstantTexts.CallConsultationLT : ConstantTexts.MeetConsultationLT
                                    vc.cost = "\(ConstantTexts.CurLT) \(self.amountPaid)"
                                    
                                    self.navigationController?.pushViewController(vc, animated: true)
                                    
                                }
                            })
                        } */
                    }else if code == 404{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    super.goBackToIndex(2)
                                    
                                }
                            })
                            
                        }
                        
                    }else if code == 401{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.customMethodManager?.deleteAllData(entity: "User_Data", success: {
                                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                                    })
                                }
                            })

                        }
                    }else{
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                            
                        }
                        
                    }
                }
            }
            
        }) { (error) in
            print(error)
            self.customMethodManager?.stopLoader(view:self.view)
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }else{
                
                
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)

                
            }
            
        }
    }
    
    
    
}
