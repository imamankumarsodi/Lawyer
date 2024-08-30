//
//  DataStoreStruct_Model.swift
//  Lawyer
//
//  Created by Aman Kumar on 31/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Login Struct
class DataStoreStruct{
    
    var title:String = String()
    var placeholder:String = String()
    var value:String = String()
    var type:SignUpType?
    var image: UIImage = UIImage()
    
    //TODO: For custom methods
    init(title:String,placeholder:String,value:String,type:SignUpType,image:UIImage) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
        self.type = type
        self.image = image
    }

}


