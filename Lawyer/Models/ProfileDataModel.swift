//
//  ProfileDataModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 02/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
class ProfileDataModel{
    var title: String = String()
    var isSelected:Bool = Bool()
    var image:UIImage = UIImage()
    var items:[String] = [String]()
    
    init(title:String,isSelected:Bool,image:UIImage,items:[String]){
        self.title = title
        self.isSelected = isSelected
        self.image = image
        self.items = items
        
    }
}
