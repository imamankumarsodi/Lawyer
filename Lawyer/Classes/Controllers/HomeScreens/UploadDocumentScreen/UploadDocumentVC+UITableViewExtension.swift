//
//  UploadDocumentVC+UITableViewExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 03/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import SwipeCellKit
//MARK: - UITableViewDataSource extension
extension UploadDocumentVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.docDataList == nil) ? 1 : self.docDataList?.numberOfSections ?? 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.docDataList?.numberOfRowsInSection(section) else {
            fatalError("No docDataList found...")
        }
        return count
    }
    
    
    /* override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
        cell.delegate = self
        return cell
    } */
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let count = self.docDataList?.numberOfRowsInSection(indexPath.section) else {
            fatalError("No docDataList found...")
        }
        if count == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyWithAlertTableViewCell.className, for: indexPath) as? EmptyWithAlertTableViewCell else {
                fatalError(ConstantTexts.unexpectedIndexPath)
            }
            if let animationDetail = self.customMethodManager?.getAnimationNameAndMessage(errorCode: 1){
                cell.lblValue.backgroundColor = AppColor.clearColor
                cell.lblValue.font = AppFont.Bold.size(AppFontName.OpenSans, size: 16)
                cell.lblValue.textColor = AppColor.app_gradient_color1
                cell.lblValue.textAlignment = .center
                cell.lblValue.numberOfLines = 0
                cell.lblValue.text = animationDetail.1
                self.customMethodManager?.showLottieAnimation(cell.viewBG, animationDetail.0, .loop)
            }
            return cell
        }else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UploadDocTableViewCellAndXib.className, for: indexPath) as? UploadDocTableViewCellAndXib else {
                fatalError(ConstantTexts.unexpectedIndexPath)
            }
            
            cell.viewBG.backgroundColor = indexPath.row%2 == 0 ? AppColor.tableBGColor : AppColor.whiteColor
            
            if let docItem = self.docDataList?.documentAtIndex(indexPath.row){
                cell.configure(with: docItem)
                cell.btnDeleteRef.tag = indexPath.row
                cell.btnDeleteRef.addTarget(self, action: #selector(btnDeleteTapped), for: .touchUpInside)
                
                cell.btnPlayPauseRef.tag = indexPath.row
                cell.btnPlayPauseRef.addTarget(self, action: #selector(btnPlayTapped), for: .touchUpInside)
                
                cell.delegate = self
            }
            return cell
        }
    }
}




//MARK: - UITableViewDelegate extension
extension UploadDocumentVC:UITableViewDelegate,SwipeTableViewCellDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
         guard let count = self.docDataList?.numberOfRowsInSection(section) else {
         fatalError("No docDataList found...")
         }
         
       //  self.changeHeader(count: count)
         return self.header
         
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let count = self.docDataList?.numberOfRowsInSection(indexPath.section) else {
            fatalError("No docDataList found...")
        }
        
        return count == 0 ? 150 : 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard let count = self.docDataList?.numberOfRowsInSection(indexPath.section) else {
            fatalError("No docDataList found...")
        }
        
        return count == 0 ? 150 : 60
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 430
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 430
        
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: ConstantTexts.Delete_LT) { action, indexPath in
            // handle action by updating model with deletion
            self.deleteRow(index:indexPath.row)
        }

        // customize the action appearance
        // deleteAction.image = UIImage(named: "bin")

        return [deleteAction]
    }
    
    
}

