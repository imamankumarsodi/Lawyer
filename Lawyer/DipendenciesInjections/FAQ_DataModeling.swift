//
//  FAQ_DataModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 09/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol FAQ_DataModeling {
    //TODO: Prepare data source implementation
    func prepareDataSource() -> [FAQItem]
    
    func prepareDataSourceWith(json:NSArray) -> [FAQItem]
}

extension FAQ_DataModeling{
    func prepareDataSourceWith(json:NSArray) -> [FAQItem]{
        return [FAQItem]()
    }
}
