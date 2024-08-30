//
//  AppointmentVM.swift
//  Lawyer
//
//  Created by Aman Kumar on 29/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class AppointmentVM: AppointmentDataModeling {
    
    
    static let shared = AppointmentVM()
    private init() {}
   
    func prepareDataSource(data: NSDictionary) -> AppointmentTimeDataViewModelList {
        var appointments:[AppointmentViewWithSectionModel] = [AppointmentViewWithSectionModel]()
        
        if let MorningSlot = data.value(forKey: "MorningSlot") as? NSArray{
            if MorningSlot.count > 0{
                let appointment = AppointmentViewWithSectionModel(#imageLiteral(resourceName: "morning"), ConstantTexts.MorningLT, "MorningSlot", [AppointmentTimeDataModel]())
                
                for item in MorningSlot{
                    if let time = item as? String{
                        let appointmentTimeDataModel = AppointmentTimeDataModel(time, Bool())
                        appointment.list.append(appointmentTimeDataModel)
                    }
                }
                
                appointments.append(appointment)
            }
        }
        
        
        if let AfternoonSlot = data.value(forKey: "AfternoonSlot") as? NSArray{
            if AfternoonSlot.count > 0{
                let appointment = AppointmentViewWithSectionModel(#imageLiteral(resourceName: "afternoon"), ConstantTexts.AfternoonLT, "AfternoonSlot", [AppointmentTimeDataModel]())
                
                for item in AfternoonSlot{
                    if let time = item as? String{
                        let appointmentTimeDataModel = AppointmentTimeDataModel(time, Bool())
                        appointment.list.append(appointmentTimeDataModel)
                    }
                }
                
                appointments.append(appointment)
            }
        }
        
        
       
        if let EveningSlot = data.value(forKey: "EveningSlot") as? NSArray{
            if EveningSlot.count > 0{
                let appointment = AppointmentViewWithSectionModel(#imageLiteral(resourceName: "evening"), ConstantTexts.EveningLT, "EveningSlot", [AppointmentTimeDataModel]())
                
                for item in EveningSlot{
                    if let time = item as? String{
                        let appointmentTimeDataModel = AppointmentTimeDataModel(time, Bool())
                        appointment.list.append(appointmentTimeDataModel)
                    }
                }
              
                appointments.append(appointment)
            }
        }
        

        return AppointmentTimeDataViewModelList(appointments)
    }
    

}
