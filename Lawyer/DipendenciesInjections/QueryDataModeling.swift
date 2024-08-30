//
//  QueryDataModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol QueryDataModeling {
    
    //TODO: init data source
    func initDataSource() -> QueryDataViewListModel
    
    //TODO: Prepare data source implementation
    func prepareDataSource(data:NSArray) -> QueryDataViewListModel
}
