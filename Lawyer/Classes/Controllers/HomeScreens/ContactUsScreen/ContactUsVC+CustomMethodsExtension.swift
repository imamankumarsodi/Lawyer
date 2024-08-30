//
//  ContactUsVC+CustomMethodsExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 09/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension ContactUsVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.ContactUs_LT, leftBarButtonsType: [.back], rightBarButtonsType: [])
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        if self.contactUsListModel == nil {
            self.contactUsListModel = ContactUsVM.shared
        }
        
        if  self.dataListVM == nil{
            self.dataListVM = self.contactUsListModel?.prepareDataSource()
        }
        
        
        initialSetup()
        
    }
    
    //TODO: Intial setup implementation
    private func initialSetup(){
        //  self.customMethodManager?.showLottieAnimation(self.imgHeader, ConstantTexts.ContactUs, .loop)
        
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        self.lblMail.backgroundColor = AppColor.app_gradient_color1
        self.customMethodManager?.provideCornerRadiusTo(self.lblMail, 5, [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 8 // Whatever line spacing you want in points
        
        var myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: ConstantTexts.MailUsTitle_LT, font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.whiteColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideUnderlineAttributedText(text: "\n\(ConstantTexts.supportLink)", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), AppColor.whiteColor) ?? NSMutableAttributedString())
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblMail.numberOfLines = 0
        self.lblMail.attributedText = myMutableString
        
        
        self.lblContact.backgroundColor = AppColor.app_gradient_color1
        self.customMethodManager?.provideCornerRadiusTo(self.lblContact, 5, [ .layerMaxXMaxYCorner,.layerMaxXMinYCorner])
        
        myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: ConstantTexts.CallUsTitle_LT, font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.whiteColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\n\(ConstantTexts.supportConta)", font: AppFont.Regular.size(AppFontName.OpenSans, size: 11), color: AppColor.whiteColor) ?? NSMutableAttributedString())
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
        self.lblContact.numberOfLines = 0
        self.lblContact.attributedText = myMutableString
        
        
        self.lblInstruction.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 12)
        self.lblInstruction.textAlignment = .center
        self.lblInstruction.textColor = AppColor.textColor
        self.lblInstruction.numberOfLines = 0
        self.lblInstruction.text = ConstantTexts.NeedHelp_LT
        
        self.contactUsTable.separatorStyle = .none
        self.contactUsTable.backgroundColor = AppColor.whiteColor
        self.contactUsTable.isHidden = true
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.btnCallBackRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        
        self.btnCallBackRef.setTitle(ConstantTexts.RequestCallBack_BT, for: .normal)
        self.btnCallBackRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        
        self.btnCallBackRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnCallBackRef.backgroundColor = AppColor.app_gradient_color1
        
        registerNib()
        
    }
    
    //TODO: register nib file
       private func registerNib(){
           self.contactUsTable.register(nib: Auth_TextField_TableViewCell.className)
           
           DispatchQueue.main.asyncAfter(deadline: .now()) {
               self.contactUsTable.isHidden = false
               
               self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
               
               /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
               
               self.contactUsTable.reloadData()
           }
           
       }
    
    //TODO: setup validation
    internal func isValidate(){
        dismissKeyboard()
        
        if let dataListVM_T = self.dataListVM{
            self.contactUsListModel?.validateFields(dataStore: dataListVM_T, validHandler: { (strMsg, status, row, section) in
                if status{
                    
                    self.customMethodManager?.showAlert(ConstantTexts.ContactYouSoonALERT, okButtonTitle: ConstantTexts.OkBT, target: self)

                    
                    
                    
                }else{
                    let indexPath = IndexPath(row: row, section: section)
                    
                    if let cell = self.contactUsTable.cellForRow(at: indexPath) as? Auth_TextField_TableViewCell{
                        
                        self.customMethodManager?.showToolTip(msg: strMsg, anchorView: cell.textFieldFloating, sourceView: self.view)
                        cell.textFieldFloating.becomeFirstResponder()
                        
                    }
                    
                    
                }
            })
        }
        
    }
    
}
