//
//  LawyerDataModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 19/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol LawyerDataModeling {
    
    //TODO: init data source
    func initDataSource() -> Lawyer_List_View_Model
    
    //TODO: Prepare data source implementation
    func prepareDataSource(dataArray:NSArray) -> Lawyer_List_View_Model
}
