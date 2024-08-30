//
//  OrderStatusDataViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 28/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation

//TODO: Parent view model for showing list of OrderStatusDataViewModel
struct OrderStatusDataListViewModel {
    var order:[OrderStatusViewModel]
}

extension OrderStatusDataListViewModel{
    init(_ order:[OrderStatusViewModel]) {
        self.order = order
    }
}

extension OrderStatusDataListViewModel{
    var numberOfSections:Int{
        return order.count
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.order[section].values.count
    }
    
    
    public func orderAtIndex(_ index:Int) -> OrderStatusDataViewModel{
        return OrderStatusDataViewModel(self.order[index])
    }
    
}



//TODO: Child view model for showing a single OrderStatusDataViewModel
struct OrderStatusDataViewModel {
    var orderDetail:OrderStatusViewModel
}

extension OrderStatusDataViewModel{
    init(_ orderDetail:OrderStatusViewModel) {
        self.orderDetail = orderDetail
    }
}

extension OrderStatusDataViewModel{
    var isExpended:Bool{
        return self.orderDetail.isExpended
    }
    
    var isCompleted:Bool{
        return self.orderDetail.isCompleted
    }
    
    var title:String{
        return self.orderDetail.title
    }
    
    var values:[OrederStatusDataModel]{
        return self.orderDetail.values
    }
   
}
