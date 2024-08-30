//
//  FilterCategory.swift
//  Lawyer
//
//  Created by Aman Kumar on 04/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
// MARK: - FilterCategory Struct
class FilterCategory{
    var title:String = String()
    var filters:Filter_List_ViewModel?
    
    //TODO: For custom methods
    init(title:String,filters:Filter_List_ViewModel) {
        self.title = title
        self.filters = filters
    }
    
}
