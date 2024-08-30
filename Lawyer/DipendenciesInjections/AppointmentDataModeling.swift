//
//  AppointmentDataModeling.swift
//  Lawyer
//
//  Created by Aman Kumar on 29/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
protocol AppointmentDataModeling {
    
    //TODO: Prepare data source implementation
    func prepareDataSource(data:NSDictionary) -> AppointmentTimeDataViewModelList
}
