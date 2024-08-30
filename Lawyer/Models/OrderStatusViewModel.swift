//
//  OrderStatusViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 28/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation


class OrderStatusViewModel {
    var isExpended:Bool = Bool()
    var isCompleted:Bool = Bool()
    var title:String = String()
    var values:[OrederStatusDataModel] = [OrederStatusDataModel]()
    init(isExpended:Bool,isCompleted:Bool,title:String,values:[OrederStatusDataModel]) {
        self.isExpended = isExpended
        self.isCompleted = isCompleted
        self.title = title
        self.values = values
    }
    
}
