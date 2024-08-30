//
//  OrderStatusDataModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 28/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol OrderStatusDataModeling {
    
    //TODO: init data source
    func initDataSource() -> OrderStatusDataListViewModel
    
    //TODO: Prepare data source implementation
    func prepareDataSource(data:NSDictionary) -> OrderStatusDataListViewModel
}
