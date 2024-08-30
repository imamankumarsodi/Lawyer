//
//  LawyerProfileVC+TableViewExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 02/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator
//MARK: - UITableViewDataSource extension
extension LawyerProfileVC:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.lawyerDetailsVM == nil) ? 0 : self.lawyerDetailsVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = self.lawyerDetailsVM?.profileItems(section) else {
            fatalError("No FilterCategoryViewModel found...")
        }
        
        return count > 1 ? 1 : count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Detail_TableViewCellAndXib.className, for: indexPath) as? Detail_TableViewCellAndXib else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        cell.btnSelectRef.isHidden = true
        if let detailItem = self.lawyerDetailsVM?.appointmentAtIndex(indexPath.section){
            if detailItem.title == ConstantTexts.ExpertiseLT{
                cell.viewBG.isHidden = true
                cell.tagListView.isHidden = false
                cell.configure(with: detailItem.items)
            }else{
                cell.viewBG.isHidden = false
                cell.tagListView.isHidden = true
                cell.lblValue.text = detailItem.items[indexPath.row]
            }
            
        }
        
        
        
        return cell
    }
    
}




//MARK: - UITableViewDelegate extension
extension LawyerProfileVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: ProfileHeaderView  = Bundle.main.loadNibNamed(ProfileHeaderView.className, owner: self, options: nil)?.first as! ProfileHeaderView
        header.backgroundColor = AppColor.tableBGColor
        header.labelName.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 16)
        header.labelName.textColor = AppColor.darkGrayColor
        header.labelName.numberOfLines = 0
        header.imageView.setImageTintColor(AppColor.darkGrayColor)
        
        if let detailItem = self.lawyerDetailsVM?.appointmentAtIndex(section){
            header.labelName.text = detailItem.title
            header.imageView.image = detailItem.image
        }

        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
    
}

