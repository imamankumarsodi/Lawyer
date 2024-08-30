//
//  DataStoreStructListModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 01/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol DataStoreStructListModeling {
    
    //TODO: Init values implementation
    func initValue()
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DataStoreStruct_List_ViewModel
    
    //TODO: Validate fields implementation
    func validateFields(dataStore: DataStoreStruct_List_ViewModel, validHandler: @escaping ( String, Bool,Int,Int) -> Void)
 
}
