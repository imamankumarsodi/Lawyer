//
//  HomeVC+TableViewExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 21/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator

//MARK: - UITableViewDataSource extension
extension HomeVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return self.searchActive ? (self.expertiseVM == nil) ? 0 : self.expertiseVM?.numberOfSections ?? 0 : (self.categoryListVM == nil) ? 0 : self.categoryListVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchActive ? self.expertiseVM?.numberOfRowsInSection(section) ?? 0 : self.categoryListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCellAndXib.className, for: indexPath) as? CategoryTableViewCellAndXib else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        if self.searchActive{
            cell.configureNew(with: expertiseVM?.categoryAtIndex(indexPath.row) ?? CategoryViewModel(Category(image: UIImage(), Url: String(), title: String(), ExpertiseId: String(), Description: String())))
        }else{
            cell.configureNew(with: categoryListVM?.categoryAtIndex(indexPath.row) ?? CategoryViewModel(Category(image: UIImage(), Url: String(), title: String(), ExpertiseId: String(), Description: String())))
        }
        
        cell.btnCellSelectedRef.tag = indexPath.row
        cell.btnCellSelectedRef.addTarget(self, action: #selector(self.btnSelectCellTapped), for: .touchUpInside)

        
        return cell
    }
}




//MARK: - UITableViewDelegate extension
extension HomeVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        if let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCellAndXib {
                            cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
                            cell.contentView.backgroundColor = AppColor.highLightColor
                        }
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.05) {
                            if let cell = tableView.cellForRow(at: indexPath) as? CategoryTableViewCellAndXib {
                                cell.viewBG.transform = .identity
                                cell.contentView.backgroundColor = AppColor.clearColor
                                
                                if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
                                    self.cityName = city
                                }else{
                                    self.cityName = String()
                                }
                                
                                if self.cityName == String(){
                                  /*  self.customMethodManager?.showAlertWithCancel(title: ConstantTexts.AppName, message: ConstantTexts.SelectCityALERT, btnOkTitle: ConstantTexts.SelectCityBT, btnCancelTitle: ConstantTexts.CancelBT, callBack: { (status) in
                                          if status{
                                                let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: CityListViewController.className) as! CityListViewController
                                                vc.getCity = { item in
                                                    if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
                                                        self.cityName = city
                                                        self.lblHeaderSelectLocationTitle.text = self.cityName
                                                    }
                                                }
                                                self.navigationController?.pushViewController(vc, animated: true)
                                          }
                                      }) */
                                    
                                    self.showAlert()
                                    
                                }else{
                                    
                                    UIView.animate(views: tableView.visibleCells,
                                                   animations: self.animations, reversed: true,
                                                   initialAlpha: 1.0,
                                                   finalAlpha: 0.0,
                                                   completion: {
                                                    
                                                    
                                                    if self.isComingFromSendQuery{
                                                        
                                                        var CategoryName:String = String()
                                                        var CategoryId:String = String()
                                                        if self.searchActive{
                                                            if let categoryVM = self.expertiseVM?.categoryAtIndex(indexPath.row){
                                                                
                                                                CategoryId = categoryVM.expertiseId
                                                                CategoryName = categoryVM.title
                                                               
                                                            }
                                                        }else{
                                                            if let categoryVM = self.categoryListVM?.categoryAtIndex(indexPath.row){
                                                                CategoryId = categoryVM.expertiseId
                                                                CategoryName = categoryVM.title
                                                                
                                                            }
                                                        }
                                                        
                                                        self.sendBackSelectedCategory!(CategoryName, CategoryId)
                                                        
                                                        self.navigationController?.popViewController(animated: true)
                                                        
                                                    }else{
                                                        
                                                        
                                                        
                                                        let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: AppointmentVC.className) as! AppointmentVC
                                                        
                                                        if self.searchActive{
                                                            if let categoryVM = self.expertiseVM?.categoryAtIndex(indexPath.row){
                                                                vc.type = "0"
                                                                vc.expID = categoryVM.expertiseId
                                                                vc.expName = categoryVM.title
                                                                vc.cityName = self.cityName
                                                                
                                                            }
                                                        }else{
                                                            if let categoryVM = self.categoryListVM?.categoryAtIndex(indexPath.row){
                                                                vc.type = "0"
                                                                vc.expID = categoryVM.expertiseId
                                                                vc.expName = categoryVM.title
                                                                vc.cityName = self.cityName
                                                                
                                                            }
                                                        }
                                                        
                                                        
                                                        
                                                        
                                                        self.navigationController?.pushViewController(vc, animated: true)
                                                        
                                                        
                                                        
                                                    }
                                                
                                                    //TODO: When lawyer list applied
                                                    
                                                    /*  let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: LawyerListVC.className) as! LawyerListVC
                                                    if let categoryVM = self.categoryListVM?.categoryAtIndex(indexPath.row){
                                                    vc.headerTitle = categoryVM.title
                                                    
                                                    self.customMethodManager?.updateIsSelect(entity: ConstantTexts.ExpertiseLT, primary_key: self.customMethodManager?.getTableAndKeys(entity: ConstantTexts.ExpertiseLT) ?? String(), primary_value: categoryVM.expertiseId, key: "is_selected", value: true)
                                                    
                                                    vc.filters.append(Filter(entity: ConstantTexts.ExpertiseLT, title: categoryVM.title, id: categoryVM.expertiseId, isSelected: true))
                                                    
                                                    }
                                                    if self.cityIdArray.count > 0{
                                                    
                                                    if self.cityId == String(){
                                                    // yaha name wala code karna hai
                                                    }else{
                                                    self.customMethodManager?.updateIsSelect(entity: ConstantTexts.CityLT, primary_key: self.customMethodManager?.getTableAndKeys(entity: ConstantTexts.CityLT) ?? String(), primary_value: self.cityId, key: "is_selected", value: true)
                                                    
                                                    vc.filters.append(Filter(entity: ConstantTexts.CityLT, title: self.cityName, id: self.cityId, isSelected: true))
                                                    }
                                                    }
                                                    vc.cityId = self.cityId
                                                    print(self.cityId)
                                                    self.navigationController?.pushViewController(vc, animated: true) */
                                                   })
                                }
                                
                                
                                
                            }
                        }
                       })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    /* For Tableview
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
     let animation = currentTableAnimation.getAnimation()
     let animator = TableViewAnimator(animation: animation)
     animator.animate(cell: cell, at: indexPath, in: tableView)
     } */
    
    
}
