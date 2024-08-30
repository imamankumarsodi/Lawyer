//
//  FilterPopup_Empty_VM.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
class FilterPopup_Empty_VM: FilterListModeling {
    
    static let shared = FilterPopup_Empty_VM()
    private init() {}
    
    internal var customMethodManager:CustomMethodProtocol?
    //TODO: Init values implementation
    func initValue(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
    }
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> Filter_List_ViewModel {
        self.initValue()
        let filterCategoryList = Filter_List_ViewModel([Filter(entity: String(), title: String(),id: String(), isSelected: Bool())])
        return filterCategoryList
    }
    
    
}
