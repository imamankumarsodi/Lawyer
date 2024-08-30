//
//  LawyerProfileVC+MethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 01/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import SkeletonView
extension LawyerProfileVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.LawyerDetailsHT, leftBarButtonsType: [.back], rightBarButtonsType: [])
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        if lawyerProfileVM == nil{
            lawyerProfileVM = LawyerProfileVM.shared
        }
        
       
        initialSetup()
        
    }
    
    
    //TODO: Intial setup implementation
    private func initialSetup(){
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.profileImageViewPlaceholder, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.customMethodManager?.provideCornerBorderTo(self.profileImageViewPlaceholder, 0.5, AppColor.darkGrayColor)
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.profileImageView, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.customMethodManager?.provideCornerBorderTo(self.profileImageView, 0.5, AppColor.darkGrayColor)
        
        
        self.nameLabel.font = ConstantFonts.mainBottomButtonFont
        self.nameLabel.textColor = AppColor.app_gradient_color1
        self.nameLabel.numberOfLines = 2
        
        if self.meetPrice == ConstantTexts.DefaultFeeValueLT{
            self.buttonMeetRef.isHidden = true
        }else{
            self.buttonMeetRef.isHidden = false
            self.buttonMeetRef.setTitleColor(AppColor.whiteColor, for: .normal)
            self.buttonMeetRef.backgroundColor = AppColor.app_gradient_color1
            self.buttonMeetRef.setTitle(ConstantTexts.MeetBT, for: .normal)
            self.buttonMeetRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
            self.customMethodManager?.provideCornerRadiusTo(self.buttonMeetRef, 3, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        }
        
        
        if self.callPrice == ConstantTexts.DefaultFeeValueLT{
            self.buttonCallRef.isHidden = true
        }else{
            self.buttonCallRef.isHidden = false
            self.buttonCallRef.setTitleColor(AppColor.whiteColor, for: .normal)
            self.buttonCallRef.backgroundColor = AppColor.app_gradient_color1
            self.buttonCallRef.setTitle(ConstantTexts.CallBT, for: .normal)
            self.buttonCallRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
            self.customMethodManager?.provideCornerRadiusTo(self.buttonCallRef, 3, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        }
        
        
        self.profileTable.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        self.profileTable.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        
        self.profileTable.sectionHeaderHeight = 0.0;
        self.profileTable.sectionFooterHeight = 0.0;
        
        self.profileTable.separatorStyle = .none
        self.profileTable.hideEmptyCells()
        self.profileTable.backgroundColor = AppColor.whiteColor
        
        self.profileTable.estimatedRowHeight = 50.0
        //self.profileTable.addSubview(self.refreshControl)
        
        
        self.nameLabel.isSkeletonable = true
        self.profileImageViewPlaceholder.isSkeletonable = true
        self.profileImageView.isSkeletonable = true
        self.profileTable.isSkeletonable = true
        self.buttonMeetRef.isSkeletonable = true
        self.buttonCallRef.isSkeletonable = true

        registerNib()
        self.nameLabel.text = self.name_Lawyer
        self.customMethodManager?.setImage(imageView: self.profileImageView, url: self.imageURL)
        lawyerDetailService()
        
    }
    
    //TODO: register nib file
    private func registerNib(){
        self.profileTable.register(nib: Detail_TableViewCellAndXib.className)
    
    }
    
    
    
    //TODO: Show sekeleton animation
    internal func showAnimation(){
        self.profileImageView.showAnimatedSkeleton()
        self.profileImageViewPlaceholder.showAnimatedSkeleton()
        self.nameLabel.showAnimatedSkeleton()
        self.profileTable.showAnimatedSkeleton()
        self.buttonCallRef.showAnimatedSkeleton()
        self.buttonMeetRef.showAnimatedSkeleton()
        
        
        
    }
    
    //TODO: Show all fields
    internal func hideAnimation(){
        
        DispatchQueue.main.async {
 
            
            self.profileImageView.hideSkeleton()
            self.profileImageViewPlaceholder.hideSkeleton()
            self.nameLabel.hideSkeleton()
            self.profileTable.hideSkeleton()
            self.buttonCallRef.hideSkeleton()
            self.buttonMeetRef.hideSkeleton()
        }
        
        
    }
    
    
    
    
    //TODO: Lawyer detail web service
    internal func lawyerDetailService(){
        
        DispatchQueue.main.async {
            //Start animating skeleton view
           
        }
        
        self.showAnimation()
        ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.lawyer_overview)\(self.Uuid)", method: .get, parameters: nil, header: nil, success: { (result) in
            print(result)
            
            self.hideAnimation()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            print(data)
                            
                            if self.lawyerDetailsVM == nil {
                                self.lawyerDetailsVM = self.lawyerProfileVM?.prepareDataSource(data: data)
                            }else{
                                if let count = self.lawyerDetailsVM?.profileItems.count{
                                    if count > 0{
                                        self.lawyerDetailsVM?.profileItems.removeAll()
                                    }
                                    self.lawyerDetailsVM = self.lawyerProfileVM?.prepareDataSource(data: data)
                                }
                            }
                            
                            DispatchQueue.main.async {
                                self.profileTable.reloadData()
                            }
                            
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
            self.hideAnimation()
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }else{
                
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)

                
            }
            
            
            
        }
        
        
    }
    
    
}
