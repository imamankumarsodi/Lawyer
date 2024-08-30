//
//  OrderDataModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol OrderDataModeling {
    
    //TODO: init data source
    func initDataSource() -> OrderDataListViewModel
    
    //TODO: Prepare data source implementation
    func prepareDataSource(dataArray:NSArray) -> OrderDataListViewModel
}
