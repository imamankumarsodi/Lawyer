//
//  AppointmentVC+MethodsExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator
extension AppointmentVC{
    
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.whiteColor,ConstantTexts.BookAppointmentLT, leftBarButtonsType: [.back], rightBarButtonsType: [])
        
    }
    
    //TODO: Init values
    internal func initValues(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
        if appointMentVM == nil {
            appointMentVM = AppointmentVM.shared
        }
        
        print(price)
        print(type)
        
        initialSetup()
    }
    
    
    //TODO: Intial setup implementation
    private func initialSetup(){
        
      //  self.viewHeader.gradientBackground(from: AppColor.errorColor, to: AppColor.app_gradient_color1, direction: .leftToRight)
    
        self.viewHeader.backgroundColor = AppColor.whiteColor
        
        self.btnBackRef.setImage(#imageLiteral(resourceName: "backDate").withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnForwardRef.setImage(#imageLiteral(resourceName: "forwardDate").withRenderingMode(.alwaysTemplate), for: .normal)
        self.btnBackRef.tintColor = AppColor.app_gradient_color1
        self.btnForwardRef.tintColor = AppColor.app_gradient_color1
        
        self.btnBackRef.isHidden = self.count_Tapped <= 0 ? true : false
        self.setuserBtnIteraction()
        
        self.lblDate.textColor = AppColor.darkGrayColor
        self.lblDate.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.lblDate.textAlignment = .center
        self.lblDate.backgroundColor = AppColor.whiteColor
        
        self.customMethodManager?.provideCornerRadiusTo(self.lblDate, 4, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy (EEEE)"
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.btnBookRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.btnBookRef.setTitle(ConstantTexts.BookConsul_BT, for: .normal)
        self.btnBookRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        
        self.btnBookRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnBookRef.backgroundColor = AppColor.app_gradient_color1
        
        
        
        self.tblAppointment.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        self.tblAppointment.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        
        self.tblAppointment.sectionHeaderHeight = 0.0;
        self.tblAppointment.sectionFooterHeight = 0.0;
        
        self.tblAppointment.separatorStyle = .none
        self.tblAppointment.hideEmptyCells()
        self.tblAppointment.isHidden = true
        self.tblAppointment.isScrollEnabled = true
        self.tblAppointment.backgroundColor = AppColor.whiteColor
        self.tblAppointment.addSubview(self.refreshControl)
        
        self.lblAlertEmpty.isHidden = true
        self.lblAlertEmpty.textColor = AppColor.errorColor
        self.lblAlertEmpty.numberOfLines = 0
        self.lblAlertEmpty.textAlignment = .center
        self.lblAlertEmpty.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.lblAlertEmpty.text = ConstantTexts.chooseNextDateALERT
        self.btnBookRef.isHidden = true

        
        
        formatter.dateFormat = "dd-MMM-yyyy"
        self.current_date = formatter.string(from: date)
        self.appointmentListService(current_date:self.current_date,another_date:self.next_date,isRefresh:Bool(), btnIdentity: String())
        registerNib()
        
    }
    
    
    //TODO: set header button user interaction
    internal func setuserBtnIteraction(){
        self.btnBackRef.isUserInteractionEnabled = !self.btnBackRef.isUserInteractionEnabled
        self.btnForwardRef.isUserInteractionEnabled = !self.btnForwardRef.isUserInteractionEnabled
    }
    
    
    //TODO: register nib file
    private func registerNib(){
        self.tblAppointment.register(nib: AppointMentTableViewCellAndXib.className)
        animateView()
    }
    
    //TODO: Animate rotate collection view
    internal func animateView(){
        self.tblAppointment.isHidden = false
        DispatchQueue.main.async {
            self.tblAppointment.reloadData()
        }
        
        let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
        UIView.animate(views: tblAppointment.visibleCells,
                       animations: [fromAnimation], delay: 0.5)
        
        
        
    }
    
    
    //TODO: Validate fields implementation
    internal func validateFields(validHandler: @escaping ( String, Bool,Bool) -> Void){
        if !validationMethodManager!.checkEmptyField(self.selectedSlot.trimmingCharacters(in: .whitespaces)) {
            validHandler( ConstantTexts.SelectTimeSlotALERT, Bool(),true)
            return
            
        }
        
        /*  if !validationMethodManager!.checkEmptyField(self.expID.trimmingCharacters(in: .whitespaces)){
         validHandler( ConstantTexts.SelectCaseTypeALERT, Bool(), Bool())
         return
         
         } */
        
        validHandler(ConstantTexts.empty,  true, Bool())
        
        
    }
    
    
    //TODO: Filter web service
    internal func appointmentListService(current_date:String,another_date:String,isRefresh:Bool,btnIdentity:String){
        
        self.customMethodManager?.startLoader(view:self.view)
        let serviceURL = "\(SCustomerApi.checkslot)\(current_date)&AnotherDateType=\(another_date)"
        
        ServiceClass.shared.webServiceBasicMethod(url: serviceURL, method: .get, parameters: nil, header: nil, success: { (result) in
            print(result)
            self.setuserBtnIteraction()
            
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            print(data)
                            
                            
                            self.selectedSlot = String()
                            var text = String()
                            if let CurrentDate = data.value(forKey: "CurrentDate") as? String{
                                self.current_date = CurrentDate
                                text = "\(CurrentDate)"
                            }
                            
                            if let WeekDay = data.value(forKey: "WeekDay") as? String{
                                text = text + " (\(WeekDay))"
                            }
                            self.lblDate.text = text
                            
                            
                            if let PrevDate = data.value(forKey: "PrevDate") as? String{
                                self.prev_date = PrevDate
                            }
                            
                            if let NextDate = data.value(forKey: "NextDate") as? String{
                                self.next_date = NextDate
                            }
                            
                            if let Expertise = data.value(forKey: "Expertise") as? NSArray{
                                if self.expertise_idArray.count > 0{
                                    self.expertise_idArray.removeAll()
                                }
                                
                                if self.expertise_nameArray.count > 0{
                                    self.expertise_nameArray.removeAll()
                                }
                                
                                self.expertise_idArray.append(ConstantTexts.empty)
                                self.expertise_nameArray.append(ConstantTexts.SelectLT)
                                
                                for item in Expertise{
                                    if let ExpertiseDict = item as? NSDictionary{
                                        
                                        if let expertise_id = ExpertiseDict.value(forKey: "ExpertiseId") as? String{
                                            self.expertise_idArray.append(expertise_id)
                                        }
                                        
                                        if let expertise_id = ExpertiseDict.value(forKey: "ExpertiseId") as? Int{
                                            self.expertise_idArray.append("\(expertise_id)")
                                        }
                                        
                                        if let expertise_name = ExpertiseDict.value(forKey: "ExpertiseName") as? String{
                                            self.expertise_nameArray.append(expertise_name)
                                        }
                                        
                                        
                                    }
                                }
                            }
                            
                            if btnIdentity == "NEXT"{
                                if self.count_Tapped >= 14{
                                    self.btnForwardRef.isHidden = true
                                    self.count_Tapped = 15
                                }else{
                                    self.count_Tapped += 1
                                    self.btnForwardRef.isHidden = false
                                    self.btnBackRef.isHidden = false
                                }
                            }else if btnIdentity == "PREV"{
                                if self.count_Tapped <= 1{
                                    self.btnBackRef.isHidden = true
                                    self.count_Tapped = 0
                                }else{
                                    self.count_Tapped -= 1
                                    self.btnBackRef.isHidden = false
                                    self.btnForwardRef.isHidden = false
                                }
                            }else{
                                print("Do nothing")
                            }
                            
                            
                            if self.appointMentListVM == nil {
                                self.appointMentListVM = self.appointMentVM?.prepareDataSource(data: data)
                            }else{
                                if let count = self.appointMentListVM?.appointments.count{
                                    if count > 0{
                                        self.appointMentListVM?.appointments.removeAll()
                                    }
                                    self.appointMentListVM = self.appointMentVM?.prepareDataSource(data: data)
                                }
                            }
                            
                        }
                        
                        if let count = self.appointMentListVM?.appointments.count{
                            if count > 0{
                                self.btnBookRef.isHidden = false
                                self.lblAlertEmpty.isHidden = true
                            }else{
                               /* self.btnBookRef.isHidden = true
                                self.lblAlertEmpty.isHidden = false */
                                self.setuserBtnIteraction()
                                self.btnBookRef.isHidden = false
                                self.lblAlertEmpty.isHidden = true
                                self.appointmentListService(current_date:self.current_date,another_date:"next_date",isRefresh:Bool(), btnIdentity: "NEXT")
                                
                                
                                
                            }
                        }
                        
                        
                        DispatchQueue.main.async {
                            self.tblAppointment.reloadData()
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
            self.setuserBtnIteraction()
            self.customMethodManager?.stopLoader(view:self.view)
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)

                
            }else{
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)

            }
            
        }
        
    }
    
    
    
    
    
    //TODO: Book cunsultation Service
    internal func hitCheckCouponService(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
            self.cityName = city
        }
        
        let parameters = [Api_keys_model.CategoryId:self.expID,
                          Api_keys_model.CategoryName:self.expName,
                          Api_keys_model.BookingDate:self.current_date,
                          Api_keys_model.BookingTime:self.selectedSlot,
                          Api_keys_model.BookingId:self.BookingId,
                          Api_keys_model.CityName:self.cityName] as [String:AnyObject]
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: SCustomerApi.book_consultation, method: .post, parameters: parameters, header: header, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                            
                            if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                                print(data)
                                
                                
                                let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: UploadDocumentVC.className) as! UploadDocumentVC
                                /* vc.Uuid = self.Uuid
                                 vc.price = self.price
                                 vc.lawyer = self.lawyer */
                                vc.date = self.current_date
                                vc.selectedSlot = self.selectedSlot
                                vc.type = self.type
                                vc.expID = self.expID
                                vc.expName = self.expName
                                vc.isComingFromOrder = self.isComingFromOrder

                                
                                if let Id = data.value(forKey: "Id") as? Int{
                                    UserDefaults.standard.setValue("\(Id)", forKey: ConstantTexts.orderID)
                                }
                                
                                
                                if let Id = data.value(forKey: "Id") as? String{
                                    USER_DEFAULTS.setValue("\(Id)", forKey: ConstantTexts.orderID)
                                }
                                
                                
                              /*  if let category = data.value(forKey: "category") as? NSDictionary{
                                    if let Id = category.value(forKey: "Id") as? Int{
                                        UserDefaults.standard.setValue("\(Id)", forKey: ConstantTexts.orderID)
                                    }
                                    
                                    
                                    if let Id = category.value(forKey: "Id") as? String{
                                        USER_DEFAULTS.setValue("\(Id)", forKey: ConstantTexts.orderID)
                                    }
                                    
                                } */
                                
                               
                                
                                self.navigationController?.pushViewController(vc, animated: true)
                                
                                
                                
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


