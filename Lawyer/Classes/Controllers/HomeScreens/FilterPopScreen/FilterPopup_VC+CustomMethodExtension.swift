//
//  FilterPopup_VC+CustomMethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator

extension FilterPopup_VC{
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
        initialSetup()
        
    }
    
   
    
    //TODO: IntialSetup
    private func initialSetup(){
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        self.customMethodManager?.provideCornerRadiusTo(self.viewBG, 5, [.layerMinXMinYCorner,.layerMaxXMinYCorner])
        
        self.viewHeader.backgroundColor = AppColor.tableBGColor
        
        self.headerLabel.textColor = AppColor.darkGrayColor
        self.headerLabel.font = AppFont.Bold.size(AppFontName.OpenSans, size: 14)
        self.headerLabel.text = headerTitle
        
       /* let image = UIImage(systemName: "x.circle.fill") ?? UIImage()
        image.setImageTintWith(AppColor.darkGrayColor)
        self.btnDismissRef.setImage(image, for: .normal)
        self.btnDismissRef.tintColor = AppColor.whiteColor */
        
        self.searchBar.backgroundImage = UIImage()
        self.searchBar.backgroundColor = AppColor.whiteColor
        self.searchBar.placeholder = "\(ConstantTexts.Search_PH) \(headerTitle)"
        self.searchBar.searchTextField.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.searchBar.searchTextField.backgroundColor = AppColor.whiteColor
        self.customMethodManager?.provideCornerBorderTo(self.searchBar, 1, AppColor.placeholderColor)
        
        
        self.customMethodManager?.provideCornerRadiusTo(self.btnClearRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.btnClearRef.backgroundColor = AppColor.tableBGColor
        self.btnClearRef.titleLabel?.font = AppFont.Bold.size(AppFontName.OpenSans, size: 12)
        self.btnClearRef.setTitle(ConstantTexts.CancelBT, for: .normal)
        self.btnClearRef.setTitleColor(AppColor.darkGrayColor, for: .normal)
        
        self.customMethodManager?.provideCornerRadiusTo(self.btnDoneRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.customMethodManager?.provideCornerBorderTo(self.btnDoneRef, 1, AppColor.darkGrayColor)
        self.btnDoneRef.backgroundColor = AppColor.app_gradient_color1
        self.btnDoneRef.titleLabel?.font = AppFont.Bold.size(AppFontName.OpenSans, size: 12)
        self.btnDoneRef.setTitle(ConstantTexts.Apply_BT, for: .normal)
        self.btnDoneRef.setTitleColor(AppColor.whiteColor, for: .normal)
        
        self.filterTableView.separatorStyle = .none
        self.filterTableView.hideEmptyCells()
        self.filterTableView.isHidden = true
        self.filterTableView.isScrollEnabled = true
        self.filterTableView.backgroundColor = AppColor.whiteColor
//        self.filterTableView.addSubview(self.refreshControl)
        
        recheckDataModels()
        
    }
    
    
    //TODO: Rreset filters
    internal func resetFilters(callBack:@escaping (()->())){
        
        
        guard let count = self.filterList?.filters.count else{
            print("No count found...")
            return
        }
        
        
        
        for index in 0..<count{
            if let isSelected = self.filterList?.filters[index].isSelected{
                if isSelected{
                    
                    if let filterItem = self.filterList?.filters[index]{
                        filterItem.isSelected = Bool()
                        
                        self.customMethodManager?.updateIsSelect(entity: self.headerTitle, primary_key: self.customMethodManager?.getTableAndKeys(entity: self.headerTitle) ?? String(), primary_value: filterItem.id, key: "is_selected", value: filterItem.isSelected)
                    }
                }
            }
        }
        
        callBack()
        
    }
    
    
    //TODO: Recheck data models implenemtation
    private func recheckDataModels(){
        setViewModels()
    }
    
    //TODO: Recheck data setViewModels implenemtation
    private func setViewModels(){
        switch index {
        case 0:
            if self.filterListVM == nil {
                self.filterListVM = FilterPopup_City_VM.shared
            }
            
        case 1:
            if self.filterListVM == nil {
                self.filterListVM = FilterPopup_Expertise_VM.shared
            }
            
        case 2:
            if self.filterListVM == nil {
                self.filterListVM = FilterPopup_Language_VM.shared
            }
            
            
        case 3:
            if self.filterListVM == nil {
                self.filterListVM = FilterPopup_Experience_VM.shared
            }
            
        default:
            print("Do nothing")
        }
        
        
        if filterList == nil {
            filterList = filterListVM?.prepareDataSource()
        }
        
        
        
        //For searching
        if self.search_filterListVM == nil {
            self.search_filterListVM = FilterPopup_Empty_VM.shared
        }
        
        if search_filterList == nil {
            search_filterList = search_filterListVM?.prepareDataSource()
        }
        
        
        registerNib()
    }
    
    
    
    
    //TODO: register nib file
    private func registerNib(){
        self.filterTableView.register(nib: FilterTableViewCellAndXib.className)
        animateView()
    }
    
    
    //TODO: Animate rotate collection view
    internal func animateView(){
        self.filterTableView.isHidden = false
        DispatchQueue.main.async {
            self.filterTableView.reloadData()
        }
        
        let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
        UIView.animate(views: filterTableView.visibleCells,
                       animations: [fromAnimation], delay: 0.5)  
    }

}
