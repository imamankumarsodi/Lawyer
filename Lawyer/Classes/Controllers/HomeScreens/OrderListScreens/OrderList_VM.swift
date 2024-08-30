//
//  OrderList_VM.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class OrderList_VM: OrderDataModeling {
    
    static let shared = OrderList_VM()
    private init() {}
    
    
    func initDataSource() -> OrderDataListViewModel {
        return OrderDataListViewModel([OrderDataModel]())
    }
    
    func prepareDataSource(dataArray: NSArray) -> OrderDataListViewModel {
        var orders:[OrderDataModel] = [OrderDataModel]()
        for item in dataArray{
            if let itemDict = item as? NSDictionary{
                var order = OrderDataModel(BookingDate: String(), BookingTime: String(), CategoryName: String(), CategoryId: String(), CityName: String(), CustomerEmail: String(), CustomerName: String(), CustomerPhone: String(), Id: String(),Query:String(),Status:String())
                if let BookingDate = itemDict.value(forKey: "BookingDate") as? String{
                    order.BookingDate = BookingDate
                }
                
                if let BookingTime = itemDict.value(forKey: "BookingTime") as? String{
                    order.BookingTime = BookingTime
                }
                
                if let CategoryName = itemDict.value(forKey: "CategoryName") as? String{
                    order.CategoryName = CategoryName
                }
                
                if let CategoryId = itemDict.value(forKey: "CategoryId") as? String{
                    order.CategoryId = CategoryId
                }
                
                if let CityName = itemDict.value(forKey: "CityName") as? String{
                    order.CityName = CityName
                }
                
                if let CategoryId = itemDict.value(forKey: "CategoryId") as? Int{
                    order.CategoryId = "\(CategoryId)"
                }
                
                
                if let CustomerEmail = itemDict.value(forKey: "CustomerEmail") as? String{
                    order.CustomerEmail = CustomerEmail
                }
                
                if let CustomerPhone = itemDict.value(forKey: "CustomerPhone") as? String{
                    order.CustomerPhone = "\(CustomerPhone)"
                }
                
                if let CustomerPhone = itemDict.value(forKey: "CustomerPhone") as? Int{
                    order.CustomerPhone = "\(CustomerPhone)"
                }
                
                if let CustomerName = itemDict.value(forKey: "CustomerName") as? String{
                    order.CustomerName = "\(CustomerName)"
                }
                
                if let Id = itemDict.value(forKey: "Id") as? String{
                    order.Id = "\(Id)"
                }
                
                if let Id = itemDict.value(forKey: "Id") as? Int{
                    order.Id = "\(Id)"
                }
                
                if let Status = itemDict.value(forKey: "Status") as? String{
                    order.Status = "\(Status)"
                }
                
                if let Status = itemDict.value(forKey: "Status") as? Int{
                    order.Status = "\(Status)"
                }
                
                if let Query = itemDict.value(forKey: "Query") as? String{
                    order.Query = "\(Query)"
                }
 
                orders.append(order)
            }
        }
        
        return OrderDataListViewModel(orders)
    }
    
}
