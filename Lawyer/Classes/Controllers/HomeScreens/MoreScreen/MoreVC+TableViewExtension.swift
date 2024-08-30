//
//  MoreVC+TableViewExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator

//MARK: - UITableViewDataSource extension
extension MoreVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.categoryListVM == nil) ? 0 : self.categoryListVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.categoryListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LawyerTableViewCell.className, for: indexPath) as? LawyerTableViewCell else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.configureNew(with: categoryListVM?.categoryAtIndex(indexPath.row) ?? CategoryViewModel(Category(image: UIImage(), Url: String(), title: String(), ExpertiseId: String(), Description: String())))
        return cell
    }
}




//MARK: - UITableViewDelegate extension
extension MoreVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      UIView.animate(withDuration: 0.1,
      animations: {
          if let cell = tableView.cellForRow(at: indexPath) as? LawyerTableViewCell {
              cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
             cell.contentView.backgroundColor = AppColor.highLightColor
          }
      },
      completion: { _ in
          UIView.animate(withDuration: 0.05) {
             if let cell = tableView.cellForRow(at: indexPath) as? LawyerTableViewCell {
                  cell.viewBG.transform = .identity
                  cell.contentView.backgroundColor = .clear
                UIView.animate(views: tableView.visibleCells,
                               animations: self.animations, reversed: true,
                               initialAlpha: 1.0,
                               finalAlpha: 0.0,
                               completion: {
                                
                                self.perforAction(Index:indexPath.row)
                                
                })
                
                  
                  
                  
              }
          }
      })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    

    /* For Tableview
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    } */
    
    
}
