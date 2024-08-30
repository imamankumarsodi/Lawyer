//
//  CityListViewController+CustomMethods.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension CityListViewController{
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.ChooseCityHT, leftBarButtonsType: [.back], rightBarButtonsType: [])
        
    }
    
    //TODO: Init values
    internal func initValues(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
        initialSetup()
        
    }
    
    //TODO: IntialSetup
    private func initialSetup(){
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
       
        self.txtSearch.addBorders(edges: [.top,.bottom,.left], color: AppColor.placeholderColor, inset: 0.0, thickness: 1.0)
        self.txtSearch.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.txtSearch.placeholder = "\(ConstantTexts.Search_PH) \(ConstantTexts.CityLT)"
        self.txtSearch.textColor = AppColor.textColor
        self.txtSearch.addPadding(.both(10.0))
        
        self.txtSearch.maxLength = 50
        self.txtSearch.keyboardType = .default
        self.txtSearch.isSecureTextEntry = false
        self.txtSearch.autocapitalizationType = .none
        self.txtSearch.delegate = self
        
        
        
        self.btnSearchRef.addBorders(edges: [.top,.bottom,.left,.right], color: AppColor.placeholderColor, inset: 0.0, thickness: 1.0)
        self.btnSearchRef.tintColor = AppColor.whiteColor
        self.btnSearchRef.backgroundColor = AppColor.app_gradient_color1
        
        self.cityTableView.separatorStyle = .singleLine
        self.cityTableView.hideEmptyCells()
        self.cityTableView.isHidden = false
        self.cityTableView.isScrollEnabled = true
        self.cityTableView.backgroundColor = AppColor.whiteColor
        self.cityTableView.addSubview(self.refreshControl)
        
        self.registerNib()
    }
    
    //TODO: register nib file
    private func registerNib(){
        self.cityTableView.register(nib: Detail_TableViewCellAndXib.className)
        getCitiesName_Service(cityName: String())
    
    }
    
    
    //TODO: Get cities name
    internal func getCitiesName_Service(cityName:String){
        
        //        self.setExperise()
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.get_city_V2)\(cityName)", method: .get, parameters: nil, header: nil, success: { (result) in
            print(result)
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            print(data)
                            
                            //TODO: City data
                            if let City = data.value(forKey: "city") as? NSArray{
                                
                                if self.cityNameArray.count > 0{
                                    self.cityNameArray.removeAll()
                                }
                                
                                if self.cityIdArray.count > 0{
                                    self.cityIdArray.removeAll()
                                }
                                
                                self.customMethodManager?.deleteAllDataFilters(entity: "City")
                                
                               /* self.cityNameArray.append(ConstantTexts.SelectCityLT)
                                self.cityIdArray.append(ConstantTexts.empty) */
                                
                                let context = kAppDelegate.persistentContainer.viewContext
                                let entity = NSEntityDescription.entity(forEntityName: "City", in: context)
                                
                                for city in City{
                                    if let cityDict = city as? NSDictionary{
                                        
                                        let cityItem = Filter(entity: ConstantTexts.CityLT, title: String(),id: String(), isSelected: Bool())
                                        
                                        if let CityName = cityDict.value(forKey: "CityName") as? String{
                                            self.cityNameArray.append(CityName)
                                            cityItem.title = CityName
                                        }
                                        
                                        if let CityId = cityDict.value(forKey: "CityName") as? String{
                                            self.cityIdArray.append(CityId)
                                            cityItem.id = CityId
                                        }
                                        
                                        if let CityId = cityDict.value(forKey: "CityName") as? Int{
                                            self.cityIdArray.append("\(CityId)")
                                            cityItem.id = "\(CityId)"
                                        }
                                        
                                        let city = NSManagedObject(entity: entity!, insertInto: context)
                                        city.setValue(cityItem.title, forKey: "city_name")
                                        city.setValue(cityItem.id, forKey: "city_id")
                                        city.setValue(cityItem.isSelected, forKey: "is_selected")
                                        do {
                                            try context.save()
                                        } catch {
                                            print("Failed saving: - \(error)")
                                        }
                                    }
                                }
                                
                                DispatchQueue.main.async {
                                    self.cityTableView.reloadData()
                                }
                                
                            }
                        }
                    }else{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                            
                        }
                        
                    }
                }
            }
            
            
        }) { (error) in
            print(error)
            self.customMethodManager?.stopLoader(view:self.view)
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }else{
                
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }
            
            
            
        }
        
        
    }
}
