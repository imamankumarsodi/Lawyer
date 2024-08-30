//
//  ProfileDataModelModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 02/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol ProfileDataModelModeling {
    
    //TODO: Prepare data source implementation
    func prepareDataSource(data:NSDictionary) -> ProfileDataViewModelList
}
