//
//  FilterPopup_VC+UITableViewExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UITableViewDataSource extension
extension FilterPopup_VC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return self.searchActive ? ((self.search_filterList == nil) ? 0 : self.search_filterList?.numberOfSections ?? 0) : ((self.filterList == nil) ? 0 : self.filterList?.numberOfSections ?? 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchActive ? (self.search_filterList?.numberOfRowsInSection(section) ?? 0) : (self.filterList?.numberOfRowsInSection(section) ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilterTableViewCellAndXib.className, for: indexPath) as? FilterTableViewCellAndXib else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        if self.searchActive{
            guard let item = self.search_filterList?.filterAtIndex(indexPath.row) else {
                fatalError("No Filter found...")
            }
            
            cell.configure(with: item)
            
        }else{
            guard let item = self.filterList?.filterAtIndex(indexPath.row) else {
                fatalError("No Filter found...")
            }
            
            cell.configure(with: item)
            
        }
        
        cell.btnSelectRef.tag = indexPath.row
        cell.btnSelectRef.addTarget(self, action: #selector(self.btnSelectedCell(_:)), for: .touchUpInside)
        
        
        return cell
    }
}

//MARK: - UITableViewDelegate extension
extension FilterPopup_VC:UITableViewDelegate{
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
