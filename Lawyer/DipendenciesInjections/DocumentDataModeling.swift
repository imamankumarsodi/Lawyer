//
//  DocumentDataModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol DocumentDataModeling {
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DocumentViewModelList
    
    //TODO: Get url implementation
    func getUrl(data: NSDictionary) -> String
}
