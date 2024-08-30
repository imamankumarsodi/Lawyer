//
//  FilterPopup_Experience_VM.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class FilterPopup_Experience_VM: FilterListModeling {
    
    static let shared = FilterPopup_Experience_VM()
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
        guard  let filters = customMethodManager?.retrive_filter(entity: "Experience", keyName: "experience_name", keyId: "experience_id") else {
            print("No experience filters found...")
            fatalError("No experience filters found...")
        }
        
        let filterCategoryList = Filter_List_ViewModel(filters)
        return filterCategoryList
    }
    
    
}
