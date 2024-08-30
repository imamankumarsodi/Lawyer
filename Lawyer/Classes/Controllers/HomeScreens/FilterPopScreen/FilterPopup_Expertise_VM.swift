//
//  FilterPopup_Expertise_VM.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class FilterPopup_Expertise_VM: FilterListModeling {
    
    static let shared = FilterPopup_Expertise_VM()
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
        guard  let filters = customMethodManager?.retrive_filter(entity: "Expertise", keyName: "expertise_name", keyId: "expertise_id") else {
            print("No expertise filters found...")
            fatalError("No expertise filters found...")
        }
        
        let filterCategoryList = Filter_List_ViewModel(filters)
        return filterCategoryList
    }
    
    
}
