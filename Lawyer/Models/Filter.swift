//
//  Filter.swift
//  Lawyer
//
//  Created by Aman Kumar on 04/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
// MARK: - Filter Struct
class Filter{
    var entity:String = String()
    var title:String = String()
    var id:String = String()
    var isSelected:Bool = Bool()
    
    //TODO: For custom methods
    init(entity:String,title:String,id:String,isSelected:Bool) {
        self.entity = entity
        self.title = title
        self.id = id
        self.isSelected = isSelected
    }
    
}
