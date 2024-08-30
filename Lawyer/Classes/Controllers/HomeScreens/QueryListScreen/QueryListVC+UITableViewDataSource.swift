//
//  QueryListVC+UITableViewDataSource.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITableViewDataSource extension
extension QueryListVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.queryList == nil) ? 0 : self.queryList?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.queryList?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        guard let item = self.queryList?.QueryAtIndex(indexPath.row) else {
            fatalError("No FilterCategoryViewModel found...")
        }
        
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QueryTableViewCellAndXib.className, for: indexPath) as? QueryTableViewCellAndXib else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.configureNew(with: item)
        
        
        return cell
        
    }
}





//MARK: - UITableViewDelegate extension
extension QueryListVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        if let cell = tableView.cellForRow(at: indexPath) as? QueryTableViewCellAndXib {
                            cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
                            cell.contentView.backgroundColor = AppColor.whiteColor
                        }
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.05) {
                            if let cell = tableView.cellForRow(at: indexPath) as? QueryTableViewCellAndXib {
                                cell.viewBG.transform = .identity
                                cell.contentView.backgroundColor = .clear
                                
                                
                                if let status =  self.queryList?.QueryAtIndex(indexPath.row).Status{
                                    if status == ConstantTexts.OpenLT{
                                        print("Do nothing")
                                    }else{
                                        UIView.animate(views: tableView.visibleCells,
                                                       animations: self.animations, reversed: true,
                                                       initialAlpha: 1.0,
                                                       finalAlpha: 0.0,
                                                       completion: {
                                                        print("Bahas...")
                                                        let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: QueryDetailVC.className) as! QueryDetailVC
                                                        
                                                        if let order = self.queryList?.QueryAtIndex(indexPath.row){
                                                            vc.order = order
                                                        }
                                                        self.navigationController?.pushViewController(vc, animated: true)
                                                        DispatchQueue.main.async {
                                                            self.orderListTableView.reloadData()
                                                        }
                                                       })
                                    }
                                }
                            }
                        }
                       })
    }
    
    
    /* func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
     let animation = currentTableAnimation.getAnimation()
     let animator = TableViewAnimator(animation: animation)
     animator.animate(cell: cell, at: indexPath, in: tableView)
     } */
    
    
}

//MARK: - UIScrollView Delegate
extension QueryListVC:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        if self.orderListTableView.contentOffset.y != 0{
            
            if ((self.orderListTableView.contentOffset.y + self.orderListTableView.frame.size.height) >= self.orderListTableView.contentSize.height){
                
                print(self.isPagination)
                if self.isPagination == false{
                    // self.offset += 10
                    self.getQuerisLisService(isRefresh: Bool())
                }
            }
        }
        
    }
}

