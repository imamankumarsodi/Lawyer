//
//  OrderListVC+UITableViewDataSource+UITableViewDelegate.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITableViewDataSource extension
extension OrderListVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.orderList == nil) ? 0 : self.orderList?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.orderList?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: OrderTableViewCell.className, for: indexPath) as? OrderTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
     
        guard let item = self.orderList?.orderAtIndex(indexPath.row) else {
            fatalError("No FilterCategoryViewModel found...")
        }
        cell.configureNew(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                       
                        if let cell = tableView.cellForRow(at: indexPath) as? OrderTableViewCell {
                            cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
                            cell.contentView.backgroundColor = AppColor.whiteColor
                        }
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.05) {
                            if let cell = tableView.cellForRow(at: indexPath) as? OrderTableViewCell {
                                cell.viewBG.transform = .identity
                                cell.contentView.backgroundColor = .clear
                                UIView.animate(views: tableView.visibleCells,
                                               animations: self.animations, reversed: true,
                                               initialAlpha: 1.0,
                                               finalAlpha: 0.0,
                                               completion: {
                                                print("Bahas...")
                                                
                                                if let status =  self.orderList?.orderAtIndex(indexPath.row).Status{
                                                    if status == "0"{
                                                        
                                                        let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: AppointmentVC.className) as! AppointmentVC
                                                        
                                                        
                                                        if let order = self.orderList?.orderAtIndex(indexPath.row){
                                                            vc.BookingId = order.Id
                                                            vc.expID = order.CategoryId
                                                            vc.expName = order.CategoryName
                                                            vc.cityName = order.CityName
                                                            vc.OrderId = order.Id
                                                            vc.isComingFromOrder = true
                                                        }
                                                        
                                                        self.navigationController?.pushViewController(vc, animated: true)
                                                        
                                                        
                                                    }else{
                                                        
                                                        let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: OrderStatusVC.className) as! OrderStatusVC
                                                        
                                                        
                                                        if let order = self.orderList?.orderAtIndex(indexPath.row){
                                                            vc.order = order
                                                        }
                                                        
                                                        self.navigationController?.pushViewController(vc, animated: true)
                                                        
                                                        
                                                    }
                                                    
                                                }
                                                
                                                
                                                
                                               })
                            }
                        }
                       })
        
        
        
       
        
        
    }
}




//MARK: - UITableViewDelegate extension
extension OrderListVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
   
    
   /* func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    } */
    
    
}



//MARK: - UIScrollView Delegate
extension OrderListVC:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        if self.orderListTableView.contentOffset.y != 0{
            
            if ((orderListTableView.contentOffset.y + orderListTableView.frame.size.height) >= orderListTableView.contentSize.height){
                
                print(self.isPagination)
                if self.isPagination == false{
                   // self.offset += 10
                    self.getCustomersOrdersService(isRefresh: Bool())
                }
            }
        }
        
    }
}
