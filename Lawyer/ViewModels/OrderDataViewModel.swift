//
//  OrderDataViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation

//TODO: Parent view model for showing list of OrderDataModel
struct OrderDataListViewModel {
    var orders:[OrderDataModel]
}

extension OrderDataListViewModel{
    init(_ orders:[OrderDataModel]) {
        self.orders = orders
    }
}

extension OrderDataListViewModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.orders.count
    }
    
    
    public func orderAtIndex(_ index:Int) -> OrderDataViewModel{
        return OrderDataViewModel(self.orders[index])
    }
    
}


//TODO: Child view model for showing a single OrderDataModel
struct OrderDataViewModel {
    var order:OrderDataModel
}

extension OrderDataViewModel{
    init(_ order:OrderDataModel) {
        self.order = order
    }
}

extension OrderDataViewModel{
    var BookingDate:String{
        return self.order.BookingDate
    }
    
    var BookingTime:String{
        return self.order.BookingTime
    }
    
    var CategoryName:String{
        return self.order.CategoryName
    }
    
    var CategoryId:String{
        return self.order.CategoryId
    }
    
    var CityName:String{
        return self.order.CityName
    }
    
    
    
    var CustomerEmail:String{
        return self.order.CustomerEmail
    }
    
    var CustomerName:String{
        return self.order.CustomerName
    }
    
    var CustomerPhone:String{
        return self.order.CustomerPhone
    }
    
    var Id:String{
        return self.order.Id
    }
    
    var Query:String{
        return self.order.Query
    }
    
    var Status:String{
        return self.order.Status
    }
    
}
