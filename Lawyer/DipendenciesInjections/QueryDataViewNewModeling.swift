//
//  QueryDataViewNewModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol QueryDataViewNewModeling {
    
    //TODO: init data source
    func initDataSource() -> QueryDataViewNewListModel
    
    //TODO: Prepare data source implementation
    func prepareDataSource(data:NSArray) -> QueryDataViewNewListModel
}
