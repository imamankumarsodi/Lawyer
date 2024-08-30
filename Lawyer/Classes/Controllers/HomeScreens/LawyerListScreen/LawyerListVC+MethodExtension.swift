//
//  LawyerListVC+MethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 21/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import Foundation
import ViewAnimator

extension LawyerListVC{
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,self.headerTitle, leftBarButtonsType: [.back], rightBarButtonsType: [])
        
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        if self.filterCategoryListVM == nil {
            self.filterCategoryListVM = LawyerListCategoryList_VM.shared
        }
        
        if filterCategoryListDataVM == nil {
            filterCategoryListDataVM = filterCategoryListVM?.prepareDataSource()
        }
        
        if lawyerListVM_protocol == nil {
            lawyerListVM_protocol = LawyerList_VM.shared
        }
        
        if lawyerListVM == nil{
            lawyerListVM = lawyerListVM_protocol?.initDataSource()
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
        
        self.view.backgroundColor = AppColor.tableBGColor
        
        self.viewFilterBG.backgroundColor = AppColor.whiteColor
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewFilterBG, 3, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, 2, 2, 2, 2, 0, AppColor.clearColor)
        
        self.txtSearch.addBorders(edges: [.top,.bottom,.left], color: AppColor.placeholderColor, inset: 0.0, thickness: 1.0)
        self.txtSearch.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.txtSearch.placeholder = ConstantTexts.KeywordsPH
        self.txtSearch.textColor = AppColor.textColor
        self.txtSearch.addPadding(.both(10.0))
        
        self.txtSearch.maxLength = 50
        self.txtSearch.keyboardType = .default
        self.txtSearch.isSecureTextEntry = false
        self.txtSearch.autocapitalizationType = .none
        
        
        
        
        self.btnSearchRef.addBorders(edges: [.top,.bottom,.left,.right], color: AppColor.placeholderColor, inset: 0.0, thickness: 1.0)
        self.btnSearchRef.tintColor = AppColor.whiteColor
        self.btnSearchRef.backgroundColor = AppColor.app_gradient_color1
        
        self.btnFilterRef.backgroundColor = AppColor.tableBGColor
        self.btnFilterRef.titleLabel?.font = AppFont.Bold.size(AppFontName.OpenSans, size: 12)
        self.btnFilterRef.setTitle(ConstantTexts.ClearFiltersBT, for: .normal)
        self.btnFilterRef.setTitleColor(AppColor.darkGrayColor, for: .normal)
        
        self.lawyerTableView.separatorStyle = .none
        self.lawyerTableView.hideEmptyCells()
        self.lawyerTableView.isHidden = true
        self.lawyerTableView.isScrollEnabled = true
        self.lawyerTableView.backgroundColor = AppColor.tableBGColor
        self.lawyerTableView.addSubview(self.refreshControl)
        self.lawyerTableView.dataSource = self
        self.lawyerTableView.delegate = self
        DispatchQueue.main.async {
            self.lawyerTableView.reloadData()
        }
        
        self.filterCollectionView.showsHorizontalScrollIndicator = false
        self.filterCollectionView.isHidden = true
        self.filterCollectionView.isUserInteractionEnabled = true
        
        self.filterItemCollectionView.showsHorizontalScrollIndicator = false
        self.filterItemCollectionView.isUserInteractionEnabled = true
        self.getHeightAndIsHiddenForFilterItemCollectionViewWithAnimation(entity: String())
        
        self.txtSearch.isHidden = true
        self.btnFilterRef.isHidden = true
        self.btnFilterRef.isHidden = true
        self.viewFilterBG.isHidden = true
        
        recheckDataModels()
        
        self.cityName = self.cityName.replacingOccurrences(of: ConstantTexts.blankSpace, with: ConstantTexts.mod20)
        
        self.service_url = "CityId=\(self.cityId)&CityName=\(self.cityName)&ExpertiseId=\(String())&LanguageId=\(String())&ExperienceId=\(String())&Keyword="
        
        self.lawyerListService(serviceURL:service_url, keyword: self.txtSearch.text!.trimmingCharacters(in: .whitespaces), offset: self.offset, isRefresh: Bool(), isFilterApplied: Bool(), isSearchActive: Bool())
        
        
        
        
    }
    
    
    
    //TODO: Recheck data models implenemtation
    private func recheckDataModels(){
        registerNib()
        
        
        /* DispatchQueue.main.asyncAfter(deadline: .now()) {
         self.lawyerTableView.isHidden = false
         
         self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 260,duration: self.animationDuration, delay: self.delay)
         
         self.lawyerTableView.reloadData()
         } */
        
        
    }
    
    //TODO: register nib file
    private func registerNib(){
        /* For Tableview
         self.categoryTableView.register(nib: LawyerTableViewCell.className)
         
         DispatchQueue.main.asyncAfter(deadline: .now()) {
         self.categoryTableView.isHidden = false
         
         self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
         
         /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
         
         self.categoryTableView.reloadData()
         } */
        
        self.filterCollectionView.register(nib: FilterCollectionViewCell.className)
        self.filterItemCollectionView.register(nib: FilterItemCollectionViewCell.className)
        self.lawyerTableView.register(nib: LawyerNewTableViewCell.className)
        
        self.animateView()
        
        
        
    }
    
    //TODO: Animate rotate collection view
    internal func animateView(){
        self.viewFilterBG.isHidden = false
        self.txtSearch.isHidden = false
        self.btnFilterRef.isHidden = false
        self.btnFilterRef.isHidden = false
        self.filterCollectionView.isHidden = false
        
        self.lawyerTableView.isHidden = false
        
        UIView.animate(views: filterCollectionView.visibleCells,
                       animations: [zoomAnimation, rotateAnimation],
                       duration: 0.5)
        
        UIView.animate(views: [self.txtSearch,self.btnSearchRef,btnFilterRef], animations: [zoomAnimation, rotateAnimation],
                       duration: 0.5)
        
        UIView.animate(views: lawyerTableView.visibleCells,
                       animations: [fromAnimation], delay: 0.5)
        
    }
    
    
    
    //MARK: - Filter methods
    //TODO: Set filter array collection view
    internal func setFilterArray(filter:[Filter],entity:String){
        
        if self.filters.count == 0{
            
            for item in filter{
                self.filters.append(item)
            }
            
        }else{
            
            for item in filter{
                var flag = Bool()
                for mainItem in self.filters{
                    if item.id == mainItem.id && item.title == mainItem.title{
                        flag = true
                        break
                    }
                }
                
                if flag == false{
                    self.filters.append(item)
                }
                
            }
            
        }
        
        self.getHeightAndIsHiddenForFilterItemCollectionViewWithAnimation(entity: entity)
        self.applyFilters()
        
        
        
    }
    
    //TODO: Reset filter array collection view
    internal func resetFilters(){
        for item in self.filters{
            self.customMethodManager?.updateIsSelect(entity: item.entity, primary_key: self.customMethodManager?.getTableAndKeys(entity: item.entity) ?? String(), primary_value: item.id, key: "is_selected", value: Bool())
        }
        
        self.filters.removeAll()
        self.getHeightAndIsHiddenForFilterItemCollectionViewWithAnimation(entity: String())
        
    }
    
    
    //TODO: Apply clear filters and all data
    internal func actionOnClearFilter(){
        self.isPagination = false
        self.offset = Int()
        self.resetFilters()
        self.service_url = "CityId=\(String())&CityName=\(String())&ExpertiseId=\(String())&LanguageId=\(String())&ExperienceId=\(String())&Keyword="
        
        self.lawyerListService(serviceURL:self.service_url, keyword: self.txtSearch.text!.trimmingCharacters(in: .whitespaces), offset: self.offset, isRefresh: Bool(), isFilterApplied: true, isSearchActive: Bool())
    }
    
    
    //TODO: Apply filters
    internal func applyFilters(){
        self.offset = 0
        var cityArray = [String]()
        var expertiseArray = [String]()
        var languageArray = [String]()
        var experienceArray = [String]()
        
        for item in self.filters{
            if item.entity == ConstantTexts.CityLT{
                cityArray.append(item.id)
            }else if item.entity == ConstantTexts.ExpertiseLT{
                expertiseArray.append(item.id)
            }else if item.entity == ConstantTexts.LanguageLT{
                languageArray.append(item.id)
            }else{
                experienceArray.append(item.id)
            }
        }
        
        self.service_url = "CityId=\(cityArray.joined(separator: ","))&CityName=\(self.cityName)&ExpertiseId=\(expertiseArray.joined(separator: ","))&LanguageId=\(languageArray.joined(separator: ","))&ExperienceId=\(experienceArray.joined(separator: ","))&Keyword="
        
        
        self.lawyerListService(serviceURL:service_url, keyword: self.txtSearch.text!.trimmingCharacters(in: .whitespaces), offset: self.offset, isRefresh: Bool(), isFilterApplied: true, isSearchActive: Bool())
    }
    
    
    //TODO: Set height and isHidden for filterItemCollectionView
    internal func getHeightAndIsHiddenForFilterItemCollectionViewWithAnimation(entity:String){
        
        if self.filters.count > 0{
            self.filterItemCollectionView.isHidden = false
            self.heightFilterItemCollectionView.constant = 30
        }else{
            self.filterItemCollectionView.isHidden = true
            self.heightFilterItemCollectionView.constant = 0
            
        }
        
        DispatchQueue.main.async {
            self.filterItemCollectionView.reloadData()
        }
        
    }
    
    
    
    //TODO: Filter web service
    internal func lawyerListService(serviceURL:String,keyword:String,offset:Int,isRefresh:Bool,isFilterApplied:Bool,isSearchActive:Bool){
        
        self.customMethodManager?.startLoader(view:self.view)
        
        ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.lawyer_list)\(serviceURL)\(keyword)&OffSet=\(self.offset)", method: .get, parameters: nil, header: nil, success: { (result) in
            print(result)
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200 || code == 201{
                        
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            
                            
                            
                            DispatchQueue.main.async {
                                if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.lawyerTableView, childView: self.errorView){
                                    if isAddedSubview{
                                        self.customMethodManager?.removeSubView(childView: self.errorView)
                                    }
                                }
                            }
                            
                            
                            if let count = data.value(forKey: "count") as? Int{
                                self.dataCount = count
                            }
                            
                            if let count = data.value(forKey: "count") as? String{
                                self.dataCount = Int(count) ?? 0
                            }
                            
                            
                            if let lawyer = data.value(forKey: "lawyer") as? NSArray{
                                
                                //For table refresh
                                if isRefresh{
                                    /*  self.resetFilters() */
                                    if let count = self.lawyerListVM?.lawyers.count{
                                        if count > 0{
                                            self.lawyerListVM?.lawyers.removeAll()
                                        }
                                    }
                                }
                                
                                //For apply new filters
                                if isFilterApplied == true || isSearchActive == true{
                                    if let count = self.lawyerListVM?.lawyers.count{
                                        if count > 0{
                                            self.lawyerListVM?.lawyers.removeAll()
                                        }
                                    }
                                }
                                
                                
                                
                                //For checking pagination and append data
                                if let count = self.lawyerListVM?.lawyers.count{
                                    
                                    if count == 0{
                                        
                                        self.isPagination = false
                                        if let lawyers = self.lawyerListVM_protocol?.prepareDataSource(dataArray: lawyer).lawyers{
                                            self.lawyerListVM?.lawyers.append(contentsOf: lawyers)
                                        }
                                    }else{
                                        if count >= self.dataCount{
                                            self.isPagination = true
                                            
                                        }else{
                                            
                                            self.isPagination = false
                                            if let lawyers = self.lawyerListVM_protocol?.prepareDataSource(dataArray: lawyer).lawyers{
                                                self.lawyerListVM?.lawyers.append(contentsOf: lawyers)
                                            }
                                        }
                                        
                                    }
                                    
                                }

                                //For checking pagination...
                                if let count = self.lawyerListVM?.lawyers.count{
                                    self.offset = count
                                    
                                    if count == 0{
                                        self.isPagination = false
                                        
                                        DispatchQueue.main.async {
                                            if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.lawyerTableView, childView: self.errorView){
                                                if isAddedSubview{
                                                    
                                                }else{
                                                    self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.NoDataFoundALERT, callback: {
                                                        self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.EmptyBoxNew, .loop)
                                                    })
                                                    
                                                    self.customMethodManager?.addSubView(parentView: self.lawyerTableView, childView: self.errorView)
                                                }
                                            }
                                        }
                                        
                                        
                                    }else{
                                        if count >= self.dataCount{
                                            self.isPagination = true
                                            
                                        }else{
                                            self.isPagination = false
                                        }
                                    }
                                }
                                
                                
                            }
                        }
                        
                        if code == 200{
                            if let message = result_Dict.value(forKey: "message") as? String{
                                
                                self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)

                                
                            }
                        }

                        DispatchQueue.main.async {
                            self.lawyerTableView.reloadData()
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
            
            if let count = self.lawyerListVM?.lawyers.count{
                if count > 0{
                    self.lawyerListVM?.lawyers.removeAll()
                }
            }
            
            DispatchQueue.main.async {
                self.lawyerTableView.reloadData()
            }
            
            self.customMethodManager?.stopLoader(view:self.view)
            if let _ = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                
                let errorCode = (error as NSError).code
                if let animationDetail = self.customMethodManager?.getAnimationNameAndMessage(errorCode: errorCode){
                    DispatchQueue.main.async {
                        if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.lawyerTableView, childView: self.errorView){
                            if isAddedSubview{
                                
                                self.customMethodManager?.setupError(chidView: self.errorView, message: animationDetail.1,callback: {
                                    self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, animationDetail.0, .loop)
                                })
                                
                            }else{
                                self.customMethodManager?.setupError(chidView: self.errorView, message: animationDetail.1,callback: {
                                    self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, animationDetail.0, .loop)
                                })
                                
                                self.customMethodManager?.addSubView(parentView: self.lawyerTableView, childView: self.errorView)
                            }
                        }
                    }
                    
                    
                }
                
            }else{
                DispatchQueue.main.async {
                    if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.lawyerTableView, childView: self.errorView){
                        if isAddedSubview{
                            
                            self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.errorMessage, callback: {
                                self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.SomeThingWentWrong, .loop)
                            })
                            
                        }else{
                            self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.errorMessage, callback: {
                                self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.SomeThingWentWrong, .loop)
                            })
                            
                            self.customMethodManager?.addSubView(parentView: self.lawyerTableView, childView: self.errorView)
                        }
                    }
                }
            }
        }
    }
}
