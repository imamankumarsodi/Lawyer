//
//  PaymentVC+TableViewExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator
//MARK: - UITableViewDataSource extension
extension PaymentVC:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return (self.dataListVM == nil) ? 0 : self.dataListVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.header.switch_Ref.isOn{
            return self.dataListVM?.numberOfRowsInSection(section) ?? 0
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.header.switch_Ref.isOn{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: GSTIN_TableViewCellAndXib.className, for: indexPath) as? GSTIN_TableViewCellAndXib else {
                fatalError(ConstantTexts.unexpectedIndexPath)
            }
            
            guard let item = self.dataListVM?.dataStoreStructAtIndex(indexPath.row) else {
                fatalError(ConstantTexts.unexpectedIndexPath)
            }
            
            if indexPath.row == 2{
                cell.btnDDSelectRef.tag = indexPath.row
                cell.btnDDSelectRef.addTarget(self, action: #selector(btnDropDownTapped), for: .touchUpInside)
            }
            
            cell.textField.delegate = self
            cell.configure(with: item)
            
            return cell
        }else{
            return UITableViewCell()
        }
        
        
    }
    
}




//MARK: - UITableViewDelegate extension
extension PaymentVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.header.switch_Ref.isOn{
            return 55
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.header.switch_Ref.isOn{
            return 55
        }else{
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.header.switch_Ref.isOn{
            return 810
        }else{
            return 770
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if self.header.switch_Ref.isOn{
            return 810
        }else{
            return 770
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        self.footer.backgroundColor = AppColor.tableBGColor
        
        self.footer.lblDetail.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        self.footer.lblDetail.textColor = AppColor.darkGrayColor
        self.footer.lblDetail.numberOfLines = 0
        self.footer.lblDetail.textAlignment = .center
        self.footer.lblDetail.text = "\(ConstantTexts.ServiceProviders_LT) \(ConstantTexts.CompanyGSTIN_LT)"
        
        if self.header.switch_Ref.isOn{
            self.footer.lblDetail.isHidden = false
        }else{
            self.footer.lblDetail.isHidden = true
        }
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.footer.btnCheckOutRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.footer.btnCheckOutRef.setTitle(ConstantTexts.CheckOut_BT, for: .normal)
        self.footer.btnCheckOutRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        
        self.footer.btnCheckOutRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.footer.btnCheckOutRef.backgroundColor = AppColor.app_gradient_color1
         self.footer.btnCheckOutRef.addTarget(self, action: #selector(btnCheckOutTapped), for: .touchUpInside)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 195
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 195
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // fetch the animation from the TableAnimation enum and initialze the TableViewAnimator class
        let animation = currentTableAnimation.getAnimation()
        let animator = TableViewAnimator(animation: animation)
        animator.animate(cell: cell, at: indexPath, in: tableView)
    }
    
}

