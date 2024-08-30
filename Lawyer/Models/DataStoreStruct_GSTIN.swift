//
//  DataStoreStruct_GSTIN.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
// MARK: - GSTIN Struct
class DataStoreStruct_GSTIN{
    
    var title:String = String()
    var placeholder:String = String()
    var value:String = String()
    var type:GSTIN_Type?
    
    //TODO: For custom methods
    init(title:String,placeholder:String,value:String,type:GSTIN_Type) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
        self.type = type
    }

}
