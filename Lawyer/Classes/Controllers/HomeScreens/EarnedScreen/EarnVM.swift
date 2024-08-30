//
//  EarnVM.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class EarnVM: EarnDataModeling {
    
    static let shared = EarnVM()
    private init() {}
    
    func initDataSource() -> EarnDataListViewModel {
        return EarnDataListViewModel([EarnDataModel]())
    }
    
    func prepareDataSource(dataArray: NSArray) -> EarnDataListViewModel {
        var earns:[EarnDataModel] = [EarnDataModel]()
        for item in dataArray{
            if let itemDict = item as? NSDictionary{
                var earn = EarnDataModel(name: String(), date: String(), price: String(), Id: String())
                if let name = itemDict.value(forKey: "fullname") as? String{
                    earn.name = name
                }
                
                if let date = itemDict.value(forKey: "created_at") as? String{
                    earn.date = date
                }
                
                if let price = itemDict.value(forKey: "couponAmount") as? String{
                    earn.price = price
                }
                
                if let price = itemDict.value(forKey: "couponAmount") as? Int{
                    earn.price = "\(price)"
                }
                
                if let Id = itemDict.value(forKey: "Id") as? String{
                    earn.Id = Id
                }
                
                if let Id = itemDict.value(forKey: "Id") as? Int{
                    earn.Id = "\(Id)"
                }
                earns.append(earn)
            }
        }
        
        return EarnDataListViewModel(earns)
    }
    
    
  

}
