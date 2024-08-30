//
//  LawyerList_VM.swift
//  Lawyer
//
//  Created by Aman Kumar on 19/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class LawyerList_VM: LawyerDataModeling {
    
    static let shared = LawyerList_VM()
    private init() {}
    
    //TODO: init data source
    func initDataSource() -> Lawyer_List_View_Model{
        return Lawyer_List_View_Model(lawyers: [Lawyer_Model]())
    }
    
    //TODO: Prepare data source implementation
    func prepareDataSource(dataArray: NSArray) -> Lawyer_List_View_Model {
        var lawyerList:[Lawyer_Model] =  [Lawyer_Model]()
            for item in dataArray{
                if let lawyerDict = item as? NSDictionary{
                    var modelItem = Lawyer_Model(CityName: String(), ConsulationType_Call_Fee: ConstantTexts.DefaultFeeValueLT, ConsulationType_Meet_Fee: ConstantTexts.DefaultFeeValueLT, ConsulationType_Video_Call_Fee: ConstantTexts.DefaultFeeValueLT, Experience_Name: String(), Expertise_String: String(), FullName: String(), Id: String(), Language_String: String(), ProfilePhoto: String(), Uuid: String())
                    
                    if let CityName = lawyerDict.value(forKey: "CityName") as? String{
                        modelItem.CityName = CityName
                    }
                    
                    if let Consulation = lawyerDict.value(forKey: "Consulation") as? NSArray{
                        for c_item in Consulation{
                            if let c_item_dict = c_item as? NSDictionary{
                                if let ConsulationType = c_item_dict.value(forKey: "ConsulationType") as? Int{
                                    
                                    let Fee = c_item_dict.value(forKey: "Fee") as? String ?? ConstantTexts.DefaultFeeValueLT
                                    
                                    if ConsulationType == 0{
                                        modelItem.ConsulationType_Call_Fee = Fee
                                    }else if ConsulationType == 1{
                                        modelItem.ConsulationType_Meet_Fee = Fee
                                    }else{
                                        modelItem.ConsulationType_Video_Call_Fee = Fee
                                    }
                                }
                                
                                if let ConsulationType = c_item_dict.value(forKey: "ConsulationType") as? String{
                                    
                                    let Fee = c_item_dict.value(forKey: "Fee") as? String ?? ConstantTexts.DefaultFeeValueLT
                                    
                                    if ConsulationType == "0"{
                                        modelItem.ConsulationType_Call_Fee = Fee
                                    }else if ConsulationType == "1"{
                                        modelItem.ConsulationType_Meet_Fee = Fee
                                    }else{
                                        modelItem.ConsulationType_Video_Call_Fee = Fee
                                    }
                                }
                            }
                        }
                    }
                    
                    if let ExperienceName = lawyerDict.value(forKey: "ExperienceName") as? String{
                        modelItem.Experience_Name = ExperienceName
                    }
                    
                    
                    if let Expertise = lawyerDict.value(forKey: "Expertise") as? NSArray{
                        var tempArray = [String]()
                        for e_item in Expertise{
                            if let e_item_dict = e_item as? NSDictionary{
                                if let ExpertiseName = e_item_dict.value(forKey: "ExpertiseName") as? String{
                                    tempArray.append(ExpertiseName)
                                }
                            }
                            
                            modelItem.Expertise_String = tempArray.joined(separator: ", ")
                        }
                    }
                    
                    if let FullName = lawyerDict.value(forKey: "FullName") as? String{
                        modelItem.FullName = FullName
                    }
                    
                    
                    if let Id = lawyerDict.value(forKey: "Id") as? String{
                        modelItem.Id = Id
                    }
                    
                    if let Id = lawyerDict.value(forKey: "Id") as? Int{
                        modelItem.Id = "\(Id)"
                    }
                    
                    if let Language = lawyerDict.value(forKey: "Language") as? NSArray{
                        var tempArray = [String]()
                        for l_item in Language{
                            if let l_item_dict = l_item as? NSDictionary{
                                if let LanguageName = l_item_dict.value(forKey: "LanguageName") as? String{
                                    tempArray.append(LanguageName)
                                }
                            }
                            
                            modelItem.Language_String = tempArray.joined(separator: ", ")
                        }
                    }
                    
                    if let ProfilePhoto = lawyerDict.value(forKey: "ProfilePhoto") as? String{
                        modelItem.ProfilePhoto = ProfilePhoto
                    }
                    
                    if let Uuid = lawyerDict.value(forKey: "Uuid") as? String{
                        modelItem.Uuid = Uuid
                    }
                    lawyerList.append(modelItem)
                }
            }
            
        
        
        return Lawyer_List_View_Model(lawyers: lawyerList)
    }
}
