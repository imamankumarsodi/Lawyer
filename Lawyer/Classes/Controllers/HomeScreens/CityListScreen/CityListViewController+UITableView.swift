//
//  CityListViewController+UITableView.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITableViewDataSource extension
extension CityListViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchActive ? self.cityNameArray_Filter.count : self.cityNameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Detail_TableViewCellAndXib.className, for: indexPath) as? Detail_TableViewCellAndXib else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.viewBG.isHidden = false
        cell.tagListView.isHidden = true
        cell.btnSelectRef.isHidden = false
        cell.btnSelectRef.tag = indexPath.row
        cell.btnSelectRef.addTarget(self, action: #selector(self.btnSelectCellTapped), for: .touchUpInside)
        
        if self.searchActive{
            cell.lblValue.text = cityNameArray_Filter[indexPath.row]
        }else{
            cell.lblValue.text = cityNameArray[indexPath.row]

        }
        
        return cell
    }
    
  
}

//MARK: - UITableViewDelegate extension
extension CityListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    /* func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
     // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
     let animation = currentTableAnimation.getAnimation()
     let animator = TableViewAnimator(animation: animation)
     animator.animate(cell: cell, at: indexPath, in: tableView)
     } */
    
    
}
