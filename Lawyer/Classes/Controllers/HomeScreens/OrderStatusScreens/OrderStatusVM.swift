//
//  OrderStatusVM.swift
//  Lawyer
//
//  Created by Aman Kumar on 28/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class OrderStatusVM: OrderStatusDataModeling {
    
    static let shared = OrderStatusVM()
    private init() {}
    
    func initDataSource() -> OrderStatusDataListViewModel {
        return OrderStatusDataListViewModel([OrderStatusViewModel]())
    }
    
    func prepareDataSource(data: NSDictionary) -> OrderStatusDataListViewModel {
        var orderStatus:[OrderStatusViewModel] = [OrderStatusViewModel]()
        var Id:String = String()
        var nameR:String = String()
        let OrederStatusDataModelValue:OrederStatusDataModel = OrederStatusDataModel(PaymentAmount: String(), PaymentDate: String(), PaymentMethod: String(), GST: "\(ConstantTexts.Gst_ValueLT)", Query: String(), LawyerAssign: String(), LawyerName: String(), Experience: String(), ProfilePhoto: String(), Qualification: String(),SupportEmail:String(),SupportPhoneNumber:String(),title: String(),BookingDate:String(),BookingTime: String(),Review:String(), IsRating: String())
        
        OrederStatusDataModelValue.PaymentAmount = data.value(forKey: "PaymentAmount") as? String ?? String()
        OrederStatusDataModelValue.PaymentDate = data.value(forKey: "PaymentDate") as? String ?? String()
        OrederStatusDataModelValue.PaymentMethod = data.value(forKey: "PaymentMethod") as? String ?? String()
        OrederStatusDataModelValue.Query = data.value(forKey: "PaymentMethod") as? String ?? String()
        
        OrederStatusDataModelValue.LawyerAssign = data.value(forKey: "LawyerAssign") as? String ?? String()
        OrederStatusDataModelValue.LawyerName = data.value(forKey: "LawyerName") as? String ?? String()
        OrederStatusDataModelValue.Experience = data.value(forKey: "Experience") as? String ?? String()
        OrederStatusDataModelValue.ProfilePhoto = data.value(forKey: "ProfilePhoto") as? String ?? String()
        OrederStatusDataModelValue.Qualification = data.value(forKey: "Qualification") as? String ?? String()
        
        OrederStatusDataModelValue.BookingDate = data.value(forKey: "BookingDate") as? String ?? String()
        OrederStatusDataModelValue.BookingTime = data.value(forKey: "BookingTime") as? String ?? String()
        
        OrederStatusDataModelValue.Review = data.value(forKey: "Review") as? String ?? String()
        
        if let IsRating = data.value(forKey: "IsRating") as? String{
            OrederStatusDataModelValue.IsRating = "\(IsRating)"
        }
        
        if let IsRating = data.value(forKey: "IsRating") as? Int{
            OrederStatusDataModelValue.IsRating = "\(IsRating)"
        }
        
        if let IsRating = data.value(forKey: "IsRating") as? Double{
            OrederStatusDataModelValue.IsRating = "\(IsRating)"
        }
        
        
        
        OrederStatusDataModelValue.SupportEmail = data.value(forKey: "SupportEmail") as? String ?? String()
        OrederStatusDataModelValue.SupportPhoneNumber = data.value(forKey: "SupportPhoneNumber") as? String ?? String()
        
        OrederStatusDataModelValue.title = "\(ConstantTexts.YourLegalExpert_LT_1)\(OrederStatusDataModelValue.LawyerName)\(ConstantTexts.YourLegalExpert_LT_3)\(OrederStatusDataModelValue.BookingDate)\(ConstantTexts.YourLegalExpert_LT_4)\(ConstantTexts.YourLegalExpert_LT_5)(\(OrederStatusDataModelValue.BookingTime))"
        
        
        if let Status = data.value(forKey: "Status") as? NSArray{
            let or_Status: OrderStatusViewModel = OrderStatusViewModel(isExpended: Bool(), isCompleted: Bool(), title: String(), values: [OrederStatusDataModelValue])
            for item in Status{
                if let itemDict = item as? NSDictionary{
                    if let id = itemDict.value(forKey: "id") as? String{
                        Id = id
                    }
                    
                    if let id = itemDict.value(forKey: "id") as? Int{
                        Id = "\(id)"
                    }
                    
                    if let name = itemDict.value(forKey: "name") as? String{
                        nameR = name
                        
                    }
                    
                }
            }
            
            if nameR == "Payment Pending"{
                or_Status.isCompleted = Bool()
                or_Status.title = ConstantTexts.Payment_PendingLT
            }else{
                or_Status.isCompleted = true
                or_Status.title = ConstantTexts.paymentDoneLT
            }
            
            orderStatus.append(or_Status)
            
        }
        
        if let id = data.value(forKey: "LawyerAssign") as? String{
            let or_Status: OrderStatusViewModel = OrderStatusViewModel(isExpended: Bool(), isCompleted: Bool(), title: ConstantTexts.Expert_AssignedLT, values: [OrederStatusDataModelValue])
            if id != "0"{
                or_Status.isCompleted = true
            }
           
            if OrederStatusDataModelValue.LawyerName == ConstantTexts.empty{
                if or_Status.values.count > 0{
                    or_Status.values.removeAll()
                }
            }
            orderStatus.append(or_Status)
             
         }
         
         if let id = data.value(forKey: "LawyerAssign") as? Int{
            let or_Status: OrderStatusViewModel = OrderStatusViewModel(isExpended: Bool(), isCompleted: Bool(), title: ConstantTexts.Expert_AssignedLT, values: [OrederStatusDataModelValue])
            if id != 0{
                or_Status.isCompleted = true
            }
            
            if OrederStatusDataModelValue.LawyerName == ConstantTexts.empty{
                if or_Status.values.count > 0{
                    or_Status.values.removeAll()
                }
            }
            
            orderStatus.append(or_Status)
            
            
         }
        
        if Id == "3"{
            
            orderStatus.append(OrderStatusViewModel(isExpended: Bool(), isCompleted: true, title: ConstantTexts.OrderCompletedLT, values: [OrederStatusDataModelValue]))
        }else{
            orderStatus.append(OrderStatusViewModel(isExpended: Bool(), isCompleted: Bool(), title: ConstantTexts.OrderCompletedLT, values: [OrederStatusDataModel]()))
        }
        
        for index in 0..<orderStatus.count{
             if Id == "1"{
                if index == 0{
                    orderStatus[index].isExpended = true
                }
            }else if Id == "2"{
                if index == 1{
                    orderStatus[index].isExpended = true
                }
            }else{
                if index == 2{
                    orderStatus[index].isExpended = true
                }
            }
        }
        
        return OrderStatusDataListViewModel(orderStatus)
    }
    
    
}
