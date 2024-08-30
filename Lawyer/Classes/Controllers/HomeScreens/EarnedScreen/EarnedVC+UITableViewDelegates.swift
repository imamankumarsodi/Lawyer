//
//  EarnedVC+UITableViewDelegates.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITableViewDataSource extension
extension EarnedVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.earnList == nil) ? 0 : self.earnList?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.earnList?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReferAndEarnTableViewCell.className, for: indexPath) as? ReferAndEarnTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
     
        guard let item = self.earnList?.EarnAtIndex(indexPath.row) else {
            fatalError("No FilterCategoryViewModel found...")
        }
        cell.configureNew(with: item)
        return cell
    }
    
}




//MARK: - UITableViewDelegate extension
extension EarnedVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
   
    
   /* func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    } */
    
    
}



//MARK: - UIScrollView Delegate
extension EarnedVC:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        if self.earnTableView.contentOffset.y != 0{
            
            if ((earnTableView.contentOffset.y + earnTableView.frame.size.height) >= earnTableView.contentSize.height){
                
                print(self.isPagination)
                if self.isPagination == false{
                   // self.offset += 10
                    self.getEarnsService(isRefresh: Bool())
                }
            }
        }
        
    }
}
