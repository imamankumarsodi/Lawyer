//
//  FilterPopup_Language_VM.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class FilterPopup_Language_VM: FilterListModeling {
    
    static let shared = FilterPopup_Language_VM()
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
        guard  let filters = customMethodManager?.retrive_filter(entity: "Language", keyName: "language_name", keyId: "language_id") else {
            print("No language filters found...")
            fatalError("No language filters found...")
        }
        
        let filterCategoryList = Filter_List_ViewModel(filters)
        return filterCategoryList
    }
    
    
}
