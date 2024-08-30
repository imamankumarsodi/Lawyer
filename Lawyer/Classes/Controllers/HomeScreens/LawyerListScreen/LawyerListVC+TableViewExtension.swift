//
//  LawyerListVC+TableViewExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 21/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITableViewDataSource extension
extension LawyerListVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.lawyerListVM == nil) ? 0 : self.lawyerListVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.lawyerListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LawyerNewTableViewCell.className, for: indexPath) as? LawyerNewTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        
        cell.buttonCallRef.tag = indexPath.row
        cell.buttonCallRef.addTarget(self, action: #selector(self.btnCallTapped(_:)), for: .touchUpInside)
        
        cell.buttonMeetRef.tag = indexPath.row
        cell.buttonMeetRef.addTarget(self, action: #selector(self.btnMeetTapped(_:)), for: .touchUpInside)
        
        cell.btnLawyerSelectedRef.tag = indexPath.row
        cell.btnLawyerSelectedRef.addTarget(self, action: #selector(self.btnLawyerSelectedRef(_:)), for: .touchUpInside)
        
        
        
        guard let item = self.lawyerListVM?.lawyerAtIndex(indexPath.row) else {
            fatalError("No FilterCategoryViewModel found...")
        }
        cell.configure(with: item)
        return cell
    }
}




//MARK: - UITableViewDelegate extension
extension LawyerListVC:UITableViewDelegate{
    
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
extension LawyerListVC:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        if self.lawyerTableView.contentOffset.y != 0{
            
            if ((lawyerTableView.contentOffset.y + lawyerTableView.frame.size.height) >= lawyerTableView.contentSize.height){
                
                print(self.isPagination)
                if self.isPagination == false{
                   // self.offset += 10
                    self.lawyerListService(serviceURL:service_url, keyword: self.txtSearch.text!.trimmingCharacters(in: .whitespaces), offset: self.offset, isRefresh: Bool(), isFilterApplied: Bool(), isSearchActive: Bool())
                }
            }
        }
        
    }
}
