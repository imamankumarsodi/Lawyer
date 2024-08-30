//
//  DashboardVC+CollectionViewDelegates.swift
//  Lawyer
//
//  Created by Aman Kumar on 05/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator

//MARK: - UICollectionViewDataSource extension
extension DashboardVC:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return (self.categoryListVM == nil) ? 0 : self.categoryListVM?.numberOfSections ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.categoryListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCellAndXib.className, for: indexPath) as? CategoryCollectionViewCellAndXib else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.configure(with: categoryListVM?.categoryAtIndex(indexPath.row) ?? CategoryViewModel(Category(image: UIImage(), Url: String(), title: String(), ExpertiseId: String(), Description: String())))
        
        
        
        return cell
    }
    
    
    
}



//MARK: - UICollectionViewDelegate extension
extension DashboardVC:UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCellAndXib {
                            cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
                            cell.contentView.backgroundColor = AppColor.highLightColor
                        }
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.05) {
                            if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCellAndXib {
                                cell.viewBG.transform = .identity
                                cell.contentView.backgroundColor = .clear
                                
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
                                          }else{
                                              print("Do nothing...")
                                          }
                                      }) */
                                    
                                    
                                    self.showAlert()
                                    
                                    
                                    
                                   
                                }else{
                                    
                                    UIView.animate(views: collectionView.orderedVisibleCells,
                                                   animations: self.animations, reversed: true,
                                                   initialAlpha: 1.0,
                                                   finalAlpha: 0.0,
                                                   completion: {
                                                    
                                                    let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: AppointmentVC.className) as! AppointmentVC
                                                    
                                                    
                                                    if let categoryVM = self.categoryListVM?.categoryAtIndex(indexPath.row){
                                                        vc.type = "0"
                                                        vc.expID = categoryVM.expertiseId
                                                        vc.expName = categoryVM.title
                                                        vc.cityName = self.cityName
                                                        
                                                    }
                                                    
                                                    self.navigationController?.pushViewController(vc, animated: true)
                                                    
                                                   })
                                    
                                }
                                
                                
                                
                                
                            }
                        }
                       })
    }
    
    /*  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
     UIView.animate(withDuration: 0.5) {
     if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCellAndXib {
     cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
     cell.contentView.backgroundColor = AppColor.highLightColor
     }
     }
     }
     
     func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
     UIView.animate(withDuration: 0.5) {
     if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCellAndXib {
     cell.viewBG.transform = .identity
     cell.contentView.backgroundColor = .clear
     
     let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: LawyerListVC.className) as! LawyerListVC
     if let categoryVM = self.categoryListVM?.categoryAtIndex(indexPath.row){
     vc.headerTitle = categoryVM.title
     }
     self.navigationController?.pushViewController(vc, animated: true)
     
     }
     }
     } */
    
}

//MARK: - UICollectionViewDelegateFlowLayout extension
extension DashboardVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width / 3, height: collectionView.frame.size.height / 3)
    }
}
