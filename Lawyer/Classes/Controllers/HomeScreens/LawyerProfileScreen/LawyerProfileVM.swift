//
//  LawyerProfileVM.swift
//  Lawyer
//
//  Created by Aman Kumar on 02/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
class LawyerProfileVM: ProfileDataModelModeling {
    
    
    static let shared = LawyerProfileVM()
    private init() {}
    
    
    func prepareDataSource(data: NSDictionary) -> ProfileDataViewModelList {
        var profileData:[ProfileDataModel] =  [ProfileDataModel]()
        
        if let LawyerData = data.value(forKey: "LawyerData") as? NSArray{
            if LawyerData.count > 0{
                if let lawyerDetails = LawyerData.object(at: 0) as? NSDictionary{
                    
                    if let HighQualificationName = lawyerDetails.value(forKey: "HighQualificationName") as? String{
                        let item = ProfileDataModel(title: ConstantTexts.Education_LT, isSelected: Bool(), image: #imageLiteral(resourceName: "mortarboard"), items: [ConstantTexts.NotAvaila_LT])
                        item.items[0] = HighQualificationName
                        profileData.append(item)
                    }
                    
                    
                    if let ExperienceName = lawyerDetails.value(forKey: "ExperienceName") as? String{
                        let item = ProfileDataModel(title: ConstantTexts.ExperienceLT, isSelected: Bool(), image: UIImage(systemName: "briefcase") ?? UIImage(), items: [ConstantTexts.NotAvaila_LT])
                        item.items[0] = ExperienceName
                        profileData.append(item)
                    }
                }
            }
        }
        
        if let Consulation = data.value(forKey: "LawyerConsultation") as? NSArray{
            for c_item in Consulation{
                if let c_item_dict = c_item as? NSDictionary{
                    if let ConsulationType = c_item_dict.value(forKey: "ConsulationType") as? Int{
                        
                        let item = ProfileDataModel(title: String(), isSelected: Bool(), image: #imageLiteral(resourceName: "money"), items: [ConstantTexts.NotAvaila_LT])
                        
                        
                        let Fee = c_item_dict.value(forKey: "Fee") as? String ?? ConstantTexts.DefaultFeeValueLT
                        
                        
                        if ConsulationType == 0{
                            item.title = ConstantTexts.CallCharges_LT
                            item.items[0] = "\(ConstantTexts.CurLT) \(Fee)"
                            
                        }else if ConsulationType == 1{
                            item.title = ConstantTexts.ConsultationCharges_LT
                            item.items[0] = "\(ConstantTexts.CurLT) \(Fee) \(ConstantTexts.ConsultationFees_LT)"
                            
                        }else{
                            //For videos
                        }
                         profileData.append(item)
                    }
                    
                    if let ConsulationType = c_item_dict.value(forKey: "ConsulationType") as? String{
                        let item = ProfileDataModel(title: String(), isSelected: Bool(), image: #imageLiteral(resourceName: "money"), items: [ConstantTexts.NotAvaila_LT])
                        
                        let Fee = c_item_dict.value(forKey: "Fee") as? String ?? ConstantTexts.DefaultFeeValueLT
                        
                        if ConsulationType == "0"{
                            item.title = ConstantTexts.CallCharges_LT
                            item.items[0] = "\(ConstantTexts.CurLT) \(Fee)"
                            
                        }else if ConsulationType == "1"{
                            item.title = ConstantTexts.ConsultationCharges_LT
                            item.items[0] = "\(ConstantTexts.CurLT) \(Fee) \(ConstantTexts.ConsultationFees_LT)"
                            
                        }else{
                            //For videos
                        }
                        
                         profileData.append(item)
                    }
                    
                   
                    
                }
            }
        }
        
        if let LawyerExpertise = data.value(forKey: "LawyerExpertise") as? NSArray{
            
            let item = ProfileDataModel(title: ConstantTexts.ExpertiseLT, isSelected: Bool(), image: #imageLiteral(resourceName: "expert"), items: [ConstantTexts.NotAvaila_LT])
            
            if LawyerExpertise.count > 0{
                if item.items.count > 0 {
                    item.items.removeAll()
                }
                
                for exp in LawyerExpertise{
                    if let expDict = exp as? NSDictionary{
                        if let expString = expDict.value(forKey: "ExpertiseName") as? String{
                            item.items.append(expString)
                            
                        }
                    }
                }
            }
           
             profileData.append(item)
        }
        
        
        if let Language = data.value(forKey: "Language") as? NSArray{
            
            let item = ProfileDataModel(title: ConstantTexts.LanguageLT, isSelected: Bool(), image: #imageLiteral(resourceName: "languagesEmpty"), items: [ConstantTexts.NotAvaila_LT])
            
            if Language.count > 0{
                
                var tempArray:[String] = [String]()
                
                for lang in Language{
                    if let langDict = lang as? NSDictionary{
                        if let langString = langDict.value(forKey: "LanguageName") as? String{
                            tempArray.append(langString)
                        }
                    }
                }
                
                item.items[0] = tempArray.joined(separator: ", ")
            }
            
             profileData.append(item)
        }
        
        if let LawyerData = data.value(forKey: "LawyerData") as? NSArray{
                   if LawyerData.count > 0{
                       if let lawyerDetails = LawyerData.object(at: 0) as? NSDictionary{
                           let item = ProfileDataModel(title: ConstantTexts.ProfessionalHistory_LT, isSelected: Bool(), image: #imageLiteral(resourceName: "Blogs"), items: [ConstantTexts.NotAvaila_LT])
                           if let ProfessionalHistory = lawyerDetails.value(forKey: "ProfessionalHistory") as? String{
                               item.items[0] = ProfessionalHistory
                               profileData.append(item)
                           }
                       }
                   }
               }
        
        
        
        return ProfileDataViewModelList(profileItems: profileData)
    }
    
}

