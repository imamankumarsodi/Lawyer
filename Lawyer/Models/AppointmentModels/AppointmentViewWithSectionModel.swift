//
//  AppointmentViewWithSectionModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 29/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

class AppointmentViewWithSectionModel{
    var image:UIImage = UIImage()
    var headerTitle:String = String()
    var headerApiTitle:String = String()
    var list:[AppointmentTimeDataModel] = [AppointmentTimeDataModel]()
    
    init(_ image: UIImage, _ headerTitle: String,_ headerApiTitle: String, _ list: [AppointmentTimeDataModel]){
        self.image = image
        self.headerTitle = headerTitle
        self.headerApiTitle = headerApiTitle
        self.list = list
        
    }
    
}
