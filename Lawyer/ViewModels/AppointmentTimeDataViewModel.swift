//
//  AppointmentTimeDataViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 29/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit


//TODO: Parent view model for showing list of lawyers
struct AppointmentTimeDataViewModelList {
    var appointments:[AppointmentViewWithSectionModel]
}

extension AppointmentTimeDataViewModelList{
    init(_ appointments:[AppointmentViewWithSectionModel]) {
        self.appointments = appointments
    }
}

extension AppointmentTimeDataViewModelList{
    var numberOfSections:Int{
        return appointments.count
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return 1
    }
    
    
    public func appointmentAtIndex(_ index:Int) -> AppointmentTimeDataViewModel{
        return AppointmentTimeDataViewModel(self.appointments[index])
    }
    
}




//TODO: Child view model for showing a single AppointmentTimeDataViewModel
struct AppointmentTimeDataViewModel {
     var appointmentViewModel:AppointmentViewWithSectionModel
}

extension AppointmentTimeDataViewModel{
    init(_ appointmentViewModel:AppointmentViewWithSectionModel) {
        self.appointmentViewModel = appointmentViewModel
    }
}

extension AppointmentTimeDataViewModel{
    var headerApiTitle:String{
        return self.appointmentViewModel.headerApiTitle
    }
    
    var headerTitle:String{
        return self.appointmentViewModel.headerTitle
    }
    
    var image:UIImage{
        return self.appointmentViewModel.image
    }
    
    var list:[AppointmentTimeDataModel]{
        return self.appointmentViewModel.list
    }
    
}
