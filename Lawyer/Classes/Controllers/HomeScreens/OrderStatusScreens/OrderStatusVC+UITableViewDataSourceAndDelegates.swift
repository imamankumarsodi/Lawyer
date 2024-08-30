//
//  OrderStatusVC+UITableViewDataSourceAndDelegates.swift
//  Lawyer
//
//  Created by Aman Kumar on 28/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITableViewDataSource extension
extension OrderStatusVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.orderModel == nil) ? 0 : self.orderModel?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.orderModel?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let item = self.orderModel?.orderAtIndex(indexPath.section) else {
            fatalError("No FilterCategoryViewModel found...")
        }
        
        
        if item.isExpended{
            
            if indexPath.section == 0{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderStatusNewTableViewCell.className, for: indexPath) as? OrderStatusNewTableViewCell else {
                    fatalError(ConstantTexts.unexpectedIndexPath)
                }
                cell.configureNew(with: item.values[indexPath.row])
                return cell
            }else if indexPath.section == 1{
                guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderStatusTableViewCell.className, for: indexPath) as? OrderStatusTableViewCell else {
                    fatalError(ConstantTexts.unexpectedIndexPath)
                }
                cell.configureNew(with: item.values[indexPath.row])
                return cell
            }else if indexPath.section == 2 && self.rate == "0" && self.Review == String() && self.Id == "3"{
                
                  
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: RateLawyer_UITableViewCell.className, for: indexPath) as? RateLawyer_UITableViewCell else {
                        fatalError(ConstantTexts.unexpectedIndexPath)
                    }
                    
                    
                    cell.btnRatingRef.tag = indexPath.section
                    cell.btnRatingRef.addTarget(self, action: #selector(btnCellRateTapped), for: .touchUpInside)
                    
                    return cell
                
                
                
            }else{
               
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AfterRateTableViewCell.className, for: indexPath) as? AfterRateTableViewCell else {
                    fatalError(ConstantTexts.unexpectedIndexPath)
                }
                
                cell.configureNew(with: item.values[indexPath.row])
                
                return cell
            }
            
           
            
        }else{
            return UITableViewCell()
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: OrderStatusHeaderView  = Bundle.main.loadNibNamed(OrderStatusHeaderView.className, owner: self, options: nil)?.first as! OrderStatusHeaderView
        customMethodManager?.provideCornerRadiusTo(header.imgCat, header.imgCat.frame.size.height/2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        if let info = self.orderModel?.orderAtIndex(section){
            header.lblTitle.text = info.title
            if info.isCompleted{
                header.upperView.backgroundColor = AppColor.app_gradient_color1
                header.lowerView.backgroundColor = AppColor.app_gradient_color1
                header.imgCat.setImageTintColor(AppColor.app_gradient_color1)
                header.imgCat.backgroundColor = AppColor.app_gradient_color1
                header.imgCat.image = #imageLiteral(resourceName: "icons8-verified_account")
                
            }else{
                header.upperView.backgroundColor = AppColor.placeholderColor
                header.lowerView.backgroundColor = AppColor.placeholderColor
                header.imgCat.setImageTintColor(AppColor.placeholderColor)
                header.imgCat.backgroundColor = AppColor.placeholderColor
                header.imgCat.image = UIImage()
                
            }
            
                
                if (self.orderModel?.numberOfRowsInSection(section) ?? 0) > 0{
                    if info.isExpended{
                        header.lblTitle.textColor = AppColor.textColor
                        header.lblTitle.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
                    }else{
                        header.lblTitle.textColor = AppColor.darkGrayColor
                        header.lblTitle.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
                    }
                }else{
                    header.lblTitle.textColor = AppColor.darkGrayColor
                    header.lblTitle.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
                }

            if section == 0{
                header.upperView.isHidden = true
                header.lowerView.isHidden = false
            }else if section == ((self.orderModel?.numberOfSections ?? 0) - 1){
                header.upperView.isHidden = false
                header.lowerView.isHidden = true
            }else{
                header.upperView.isHidden = false
                header.lowerView.isHidden = false
            }
            
            
        }
        header.btnHeaderRef.tag = section
        header.btnHeaderRef.addTarget(self, action: #selector(self.btnExpendHeader(_:)), for: .touchUpInside)
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}




//MARK: - UITableViewDelegate extension
extension OrderStatusVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = self.orderModel?.orderAtIndex(indexPath.section) else {
            fatalError("No FilterCategoryViewModel found...")
        }
        
        if item.isExpended{
            return UITableView.automaticDimension
        }else{
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let item = self.orderModel?.orderAtIndex(indexPath.section) else {
            fatalError("No FilterCategoryViewModel found...")
        }
        
        if item.isExpended{
            return UITableView.automaticDimension
        }else{
            return 0
        }
        
        
    }
    
    
    
    /* func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
     let animation = currentTableAnimation.getAnimation()
     let animator = TableViewAnimator(animation: animation)
     animator.animate(cell: cell, at: indexPath, in: tableView)
     } */
    
    
}


