//
//  DashboardVC+CustomMethods.swift
//  Lawyer
//
//  Created by Aman Kumar on 05/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import DropDown
import ViewAnimator
import FSPagerView
import CoreData

extension DashboardVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = false
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.ChooseServiceHT, leftBarButtonsType: [.empty], rightBarButtonsType: [.location])
        super.isHiddenNavigationBar(true)
      //  self.navigationController?.navigationBar.isHidden = true
        
    }
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        initialSetup()
        
    }
    
    
    //TODO: Intial setup implementation
    private func initialSetup(){
        self.viewHeaderBG.backgroundColor = AppColor.whiteColor
        self.lblHeaderTitle.backgroundColor = AppColor.clearColor
        self.lblHeaderTitle.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.lblHeaderTitle.textColor = AppColor.textColor
        self.lblHeaderTitle.textAlignment = .center
        self.lblHeaderTitle.numberOfLines = 0
        self.lblHeaderTitle.text = ConstantTexts.ChooseServiceHT
        
        self.lblHeaderSelectLocationTitle.backgroundColor = AppColor.clearColor
        self.lblHeaderSelectLocationTitle.font = AppFont.Regular.size(AppFontName.OpenSans, size: 8)
        self.lblHeaderSelectLocationTitle.textColor = AppColor.textColor
        self.lblHeaderSelectLocationTitle.textAlignment = .center
        self.lblHeaderSelectLocationTitle.numberOfLines = 0
        self.lblHeaderSelectLocationTitle.text = ConstantTexts.ChooseCityHT
        
        if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
            self.cityName = city
            self.lblHeaderSelectLocationTitle.text = self.cityName
        }else{
            self.cityName = String()
            self.lblHeaderSelectLocationTitle.text = ConstantTexts.ChooseCityHT
        }
        
      
        
        if MAIN_SCREEN_HEIGHT > 736{
            self.NSLayoutConstraintHeaderHeight.constant = 84
        }else{
            self.NSLayoutConstraintHeaderHeight.constant = 64
        }
        
        self.viewMainBG.backgroundColor = AppColor.app_bg_color
        self.scrollView.backgroundColor = AppColor.app_bg_color
        self.view.backgroundColor = AppColor.app_bg_color
        self.dash_CollectionView.backgroundColor = AppColor.whiteColor
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.viewGradient, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewGradient, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.image_bg_color, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        
        self.lblStartCons_Paid.backgroundColor = AppColor.clearColor
        self.lblStartCons_Paid.font = AppFont.Bold.size(AppFontName.Tahoma, size: 14)
        self.lblStartCons_Paid.textColor = AppColor.whiteColor
        self.lblStartCons_Paid.textAlignment = .center
        self.lblStartCons_Paid.numberOfLines = 0
        self.lblStartCons_Paid.text = ConstantTexts.NeedQuickConsultationLT
        
        self.customMethodManager?.provideCornerRadiusTo(self.btnStartCons_Paid, self.btnStartCons_Paid.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        self.btnStartCons_Paid.setTitle(ConstantTexts.Start_Cuslutation_With_New_BT, for: .normal)
        self.btnStartCons_Paid.titleLabel?.font = AppFont.Bold.size(AppFontName.Tahoma, size: 14)
        
        self.btnStartCons_Paid.setTitleColor(AppColor.app_gradient_color1, for: .normal)
        self.btnStartCons_Paid.backgroundColor = AppColor.whiteColor
        
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewCollectionBG, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.image_bg_color, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.dash_CollectionView, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        self.customMethodManager?.provideCornerRadiusTo(self.viewMoreBG, self.viewMoreBG.frame.size.height / 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.customMethodManager?.provideCornerBorderTo(self.viewMoreBG, 0, AppColor.app_gradient_color1)
        
        self.imgMore.setImageTintColor(AppColor.app_gradient_color1)
        self.lblMore.backgroundColor = AppColor.clearColor
        self.lblMore.font = AppFont.Bold.size(AppFontName.Tahoma, size: 12)
        self.lblMore.textColor = AppColor.app_gradient_color1
        self.lblMore.textAlignment = .center
        self.lblMore.numberOfLines = 0
        self.lblMore.text = ConstantTexts.OthersServicesLT
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewConsu_Free, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.image_bg_color, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.viewConsu_Free.backgroundColor = AppColor.whiteColor
        
        self.lblStartCons_Free.backgroundColor = AppColor.clearColor
        self.lblStartCons_Free.font = AppFont.Bold.size(AppFontName.Tahoma, size: 14)
        self.lblStartCons_Free.textColor = AppColor.darkGrayColor
        self.lblStartCons_Free.textAlignment = .center
        self.lblStartCons_Free.numberOfLines = 0
        self.lblStartCons_Free.text = ConstantTexts.GetReplyLT
        
        self.customMethodManager?.provideCornerRadiusTo(self.btnStartCons_Free, self.btnStartCons_Free.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        
        self.btnStartCons_Free.setTitle(ConstantTexts.Cuslutation_For_Free_BT, for: .normal)
        self.btnStartCons_Free.titleLabel?.font = AppFont.Bold.size(AppFontName.Tahoma, size: 14)
        
        self.btnStartCons_Free.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnStartCons_Free.backgroundColor = AppColor.app_gradient_color1
        
        self.bannerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
      //  self.bannerView.transformer = FSPagerViewTransformer(type: .cubic)
        self.bannerView.dataSource = self
        self.bannerView.delegate = self
        self.bannerView.backgroundColor = AppColor.placeholderColor
        self.bannerView.isUserInteractionEnabled = true
        self.bannerView.automaticSlidingInterval = 4.0
        self.bannerView.isInfinite = true
        
        
        
        
        
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.bannerView, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.image_bg_color, -1, 1, 1, 3, 0, AppColor.clearColor)
       
        
        super.goToCity = {
            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: CityListViewController.className) as! CityListViewController
            vc.getCity = { item in
                if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
                    self.cityName = city
                    self.lblHeaderSelectLocationTitle.text = self.cityName
                }
                
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        self.viewGradient.isSkeletonable = true
        self.lblStartCons_Paid.isSkeletonable = true
        self.btnStartCons_Paid.isSkeletonable = true
        
        self.dash_CollectionView.isSkeletonable = true
        self.viewMoreBG.isSkeletonable = true
        self.viewCollectionBG.isSkeletonable = true
        
        self.viewConsu_Free.isSkeletonable = true
        self.lblStartCons_Free.isSkeletonable = true
        self.btnStartCons_Free.isSkeletonable = true
        
        self.bannerView.isSkeletonable = true
        self.pageControl.isSkeletonable = true
        
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.viewPopup, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        self.lblHeaderPopupTitle.numberOfLines = 0
        
        /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleCenter = NSMutableParagraphStyle()
        paragraphStyleCenter.alignment = .left
        // *** set LineSpacing property in points ***
        paragraphStyleCenter.lineSpacing = 5 // Whatever line spacing you want in points
        
        let myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.AppName)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 18), color: AppColor.app_gradient_color1) ?? NSMutableAttributedString())
        
        
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(ConstantTexts.SelectCityALERT)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
        
        
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleCenter, range:NSMakeRange(0, myMutableString.length))
        // *** Set Attributed String to your label ***
   
        self.lblHeaderPopupTitle.attributedText = myMutableString
        
        self.customMethodManager?.provideCornerRadiusTo(self.btnCancelRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.customMethodManager?.provideCornerBorderTo(self.btnCancelRef, 2, AppColor.app_gradient_color1)
        self.btnCancelRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        self.btnCancelRef.setTitle(ConstantTexts.CancelBT, for: .normal)
        self.btnCancelRef.setTitleColor(AppColor.app_gradient_color1, for: .normal)
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.btnOkRef, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.customMethodManager?.provideCornerBorderTo(self.btnOkRef, 2, AppColor.app_gradient_color1)
        self.btnOkRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        self.btnOkRef.setTitle(ConstantTexts.OkBT, for: .normal)
        self.btnOkRef.setTitleColor(AppColor.app_gradient_color1, for: .normal)
        
        self.initalHideBlurView()
        
        recheckDataModels()
        
        
        
    }
    
    //TODO: Recheck data models implenemtation
    private func recheckDataModels(){
        if  self.homeVM == nil{
            self.homeVM = HomeVM.shared
        }
        
        registerNib()
        
    }
    
    //TODO: register nib file
    private func registerNib(){
        
        self.dash_CollectionView.register(nib: CategoryCollectionViewCellAndXib.className)
        self.animateView()
    }
    
    
    
    
    //TODO: without animate table view
    internal func animateView(){
        UIView.animate(views: dash_CollectionView.visibleCells,
                       animations: [zoomAnimation, rotateAnimation],
                       duration: 0.5)
        
        self.forceUpdateService()
    }
    
    
    
    //TODO: without animate table view
    internal func reloadView(){
        DispatchQueue.main.async {
            self.dash_CollectionView.reloadData()
        }
    }
    
    
    //TODO: Show sekeleton animation
    internal func showAnimation(){
        
        self.viewGradient.showAnimatedSkeleton()
        self.lblStartCons_Paid.showAnimatedSkeleton()
        self.btnStartCons_Paid.showAnimatedSkeleton()
        
        self.dash_CollectionView.showAnimatedSkeleton()
        self.viewMoreBG.showAnimatedSkeleton()
        self.viewCollectionBG.showSkeleton()
        
        
        self.viewConsu_Free.showAnimatedSkeleton()
        self.lblStartCons_Free.showAnimatedSkeleton()
        self.btnStartCons_Free.showAnimatedSkeleton()
        
        self.bannerView.showAnimatedSkeleton()
        self.pageControl.showAnimatedSkeleton()
       
    }
    
    
    //TODO: Show all fields
    internal func hideAnimation(){
        
        DispatchQueue.main.async {
            
            
            self.viewGradient.hideSkeleton()
            self.lblStartCons_Paid.hideSkeleton()
            self.btnStartCons_Paid.hideSkeleton()
            
            self.dash_CollectionView.hideSkeleton()
            self.viewMoreBG.hideSkeleton()
            self.viewCollectionBG.hideSkeleton()
            
            self.viewConsu_Free.hideSkeleton()
            self.lblStartCons_Free.hideSkeleton()
            self.btnStartCons_Free.hideSkeleton()
            
            self.bannerView.hideSkeleton()
            self.pageControl.hideSkeleton()
 
        }
        
        
    }

    
    //TODO: Implementation initail hide blur view
    internal func initalHideBlurView(){
        self.blurView.isHidden = true
        self.blurView.alpha = 0
        self.animateView()
    }
    
    
    //TODO: Implementation hide blur view
    internal func hideBlurView(){
        UIView.animate(withDuration: 0.3, animations: {
            self.blurView.alpha = 0
        }) { (status) in
            self.blurView.alpha = 0
            self.blurView.isHidden = true
            
        }
        
    }
    
    //TODO: Show blurr view
    internal func showAlert() {
        animateView()
        self.blurView.isHidden = false
        UIView.animate(withDuration: 0.3, animations: {
            self.blurView.alpha = 0.85
        }) { (status) in
            self.blurView.alpha = 0.85
        }
        
    }
    
    
    //TODO: Expertise web service
    internal func expertise_list(){
        self.showAnimation()
        ServiceClass.shared.webServiceBasicMethod(url: SCustomerApi.expertise_list, method: .get, parameters: nil, header: nil, success: { (result) in
            print(result)
            self.hideAnimation()
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            print(data)
                            
                            var baseURL:String = String()
                            if let ExpertiseId = data.value(forKey: "SelectedExpertise") as? NSArray{
                                
                                if let Url = data.value(forKey: "Url") as? String{
                                    baseURL = Url
                                    if  self.categoryListVM == nil{
                                        self.categoryListVM = self.homeVM?.prepareDataSourceWithJSON(data: ExpertiseId, baseUrl: Url)
                                        self.reloadView()
                                        
                                    }else{
                                        self.categoryListVM = self.homeVM?.prepareDataSourceWithJSON(data: ExpertiseId, baseUrl: Url)
                                        self.reloadView()
                                        
                                    }
                                }
                                
                                
                                
                            }
                            
                            if let fullList = data.value(forKey: "ExpertiseId") as? NSArray{
                                
                                if let Url = data.value(forKey: "Url") as? String{
                                    if  self.expertiseVM == nil{
                                        self.expertiseVM = self.homeVM?.prepareDataSourceWithJSON(data: fullList, baseUrl: Url)
                                       
                                        
                                    }else{
                                        self.expertiseVM = self.homeVM?.prepareDataSourceWithJSON(data: fullList, baseUrl: Url)
                                        
                                    }
                                }
                                
                                
                                
                            }
                            
                            
                            
                            
                            if let Banner = data.value(forKey: "Banner") as? NSArray{
                                if self.images.count > 0{
                                    self.images.removeAll()
                                }
                                for item in Banner{
                                    if let itemStr = item as? String{
                                        self.images.append("\(baseURL)\(itemStr)")
                                    }
                                }
                                self.pageControl.numberOfPages = self.images.count
                                DispatchQueue.main.async {
                                    self.bannerView.reloadData()
                                }
                                
                            }
                            
                            
                            
                            
                            //expertiseVM
                            
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
    
    
    
    //TODO: Expertise web service
    internal func forceUpdateService(){
        self.showAnimation()
        ServiceClass.shared.webServiceBasicMethod(url: SCustomerApi.force_updateV2, method: .get, parameters: nil, header: nil, success: { (result) in
            print(result)
            self.hideAnimation()
            
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            
                            
                            guard let MobileLogo = data.value(forKey: "MobileLogo") as? String else{
                                print("No MobileLogo")
                                return
                            }
                                                       
                            guard let WebLogo = data.value(forKey: "WebLogo") as? String else{
                                print("No WebLogo")
                                return
                            }
                            
                            
                            
                            
                            
                            guard let Version = data.value(forKey: "Version") as? String else{
                                print("No Version")
                                return
                            }
                            
                            
                            guard  let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else{
                                print("No appVersion")
                                return
                            }
                            
                            print(appVersion)
                            
                            if Version == appVersion{
                                USER_DEFAULTS.set(MobileLogo, forKey: ConstantTexts.mobile_logo)
                                self.expertise_list()
                               // self.saveDataToLocal_DB(MobileLogo:MobileLogo,Version:Version,WebLogo:WebLogo)
                            }else{
                                print("do force update...")
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
    
    
    
    //TODO: Save data to local database
    private func saveDataToLocal_DB(MobileLogo:String,Version:String,WebLogo:String){
        let context = kAppDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User_Data", in: context)
        let user = NSManagedObject(entity: entity!, insertInto: context)
        
        user.setValue(MobileLogo, forKey: "mobile_logo")
        user.setValue(Version, forKey: "version")
        user.setValue(WebLogo, forKey: "web_logo")
        
        do {
           try context.save()
          } catch {
           print("Failed saving: - \(error)")
        }
        
        
        
    }
    
    
    
}
