//
//  LawyerListCategoryList_VM.swift
//  Lawyer
//
//  Created by Aman Kumar on 05/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class LawyerListCategoryList_VM: FilterCategoryListModeling {
    
    static let shared = LawyerListCategoryList_VM()
    private init() {}
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> FilterCategory_List_ViewModel {
        let filterCategoryList = FilterCategory_List_ViewModel(filterCategories: [FilterCategory(title: ConstantTexts.CityLT, filters: Filter_List_ViewModel([Filter]())),
        FilterCategory(title: ConstantTexts.ExpertiseLT, filters: Filter_List_ViewModel([Filter]())),
        FilterCategory(title: ConstantTexts.LanguageLT, filters: Filter_List_ViewModel([Filter]())),
        FilterCategory(title: ConstantTexts.ExperienceLT, filters: Filter_List_ViewModel([Filter]()))])
        
        return filterCategoryList
    }
    
    
}
