//
//  FilterListModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 05/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol FilterListModeling {
    
    //TODO: Init values implementation
    func initValue()
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> Filter_List_ViewModel
    
}
