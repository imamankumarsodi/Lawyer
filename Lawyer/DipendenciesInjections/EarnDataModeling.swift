//
//  EarnDataModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol EarnDataModeling {
    
    //TODO: init data source
    func initDataSource() -> EarnDataListViewModel
    
    //TODO: Prepare data source implementation
    func prepareDataSource(dataArray:NSArray) -> EarnDataListViewModel
}
