//
//  AppointmentVC+TableViewExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import ViewAnimator
//MARK: - UITableViewDataSource extension
extension AppointmentVC:UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (self.appointMentListVM == nil) ? 0 : self.appointMentListVM?.numberOfSections ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appointMentListVM?.numberOfRowsInSection(section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppointMentTableViewCellAndXib.className, for: indexPath) as? AppointMentTableViewCellAndXib else {
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        if let appointMentItem = self.appointMentListVM?.appointmentAtIndex(indexPath.section){
            print(appointMentItem.list.count)
            cell.arrayTiming = appointMentItem.list
            cell.cellCollectionCallBack = { (row) in
                print(indexPath.section)
                print(row)
                
                if let appointments = self.appointMentListVM?.appointments{
                    print(appointments.count)
                    
                    for i in 0..<appointments.count{
                        for j in 0..<appointments[i].list.count{
                            
                            if (i == indexPath.section && j == row){
                                appointments[i].list[j].isSelected = !appointments[i].list[j].isSelected
                                self.selectedSlot = appointments[i].list[j].isSelected ? appointments[i].list[j].title : String()
                            }else{
                                appointments[i].list[j].isSelected = Bool()
                            }
                            
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.tblAppointment.reloadData()
                    }
                    
                }
                
                
                
            }
            
            DispatchQueue.main.async {
                cell.timeCollectionView.reloadData()
            }
            
        }
        return cell
    }
    
}




//MARK: - UITableViewDelegate extension
extension AppointmentVC:UITableViewDelegate{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header: AppointmentHeaderView  = Bundle.main.loadNibNamed(AppointmentHeaderView.className, owner: self, options: nil)?.first as! AppointmentHeaderView
        header.backgroundColor = AppColor.image_bg_color
        header.labelName.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        header.labelName.textColor = AppColor.darkGrayColor
        header.labelName.numberOfLines = 0
        header.imageView.setImageTintColor(AppColor.darkGrayColor)
        
        if let appointMentItem = self.appointMentListVM?.appointmentAtIndex(section){
            header.labelName.text = appointMentItem.headerTitle
            header.imageView.image = appointMentItem.image
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let appointMentItem = self.appointMentListVM?.appointmentAtIndex(indexPath.section){
            if appointMentItem.list.count <= 3{
                return 100
            }else if appointMentItem.list.count > 3 && appointMentItem.list.count <= 6{
                return 160
            }else if appointMentItem.list.count > 6 && appointMentItem.list.count <= 9{
                return 220
            }else if appointMentItem.list.count > 9 && appointMentItem.list.count <= 12{
                return 280
            }else if appointMentItem.list.count > 12 && appointMentItem.list.count <= 15{
                return 340
            }else{
                return 400
            }
            
        }else{
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let appointMentItem = self.appointMentListVM?.appointmentAtIndex(indexPath.section){
            if appointMentItem.list.count <= 3{
                return 100
            }else if appointMentItem.list.count > 3 && appointMentItem.list.count <= 6{
                return 160
            }else if appointMentItem.list.count > 6 && appointMentItem.list.count <= 9{
                return 220
            }else if appointMentItem.list.count > 9 && appointMentItem.list.count <= 12{
                return 280
            }else if appointMentItem.list.count > 12 && appointMentItem.list.count <= 15{
                return 340
            }else{
                return 400
            }
            
        }else{
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if let sections = self.appointMentListVM?.numberOfSections{
            if section == (sections - 1){
                self.customMethodManager?.provideShadowAndCornerRadius(self.footer.btnBookConsultaionRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                
                self.footer.btnBookConsultaionRef.setTitle(ConstantTexts.BookConsul_BT, for: .normal)
                self.footer.btnBookConsultaionRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
                
                self.footer.btnBookConsultaionRef.setTitleColor(AppColor.whiteColor, for: .normal)
                self.footer.btnBookConsultaionRef.backgroundColor = AppColor.app_gradient_color1
                self.footer.btnBookConsultaionRef.addTarget(self, action: #selector(btnBookConsultationTapped), for: .touchUpInside)
               /* self.footer.imgHammer.setImageTintColor(AppColor.darkGrayColor)
                self.footer.imgDD.setImageTintColor(AppColor.darkGrayColor)
                
                self.footer.viewBG.backgroundColor = AppColor.tableBGColor
                
                // *** Create instance of `NSMutableParagraphStyle`
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .left
                // *** set LineSpacing property in points ***
                paragraphStyle.lineSpacing = 2 // Whatever line spacing you want in points
                
                
                let myMutableString = NSMutableAttributedString()
                myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: ConstantTexts.CaseTypeLT, font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
                myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: " \(ConstantTexts.StarLT)", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14), color: AppColor.errorColor) ?? NSMutableAttributedString())
                // *** Apply attribute to string ***
                myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, myMutableString.length))
                // *** Set Attributed String to your label ***
                self.footer.lblHeading.attributedText = myMutableString
                
                self.footer.lblValue.font = AppFont.Regular.size(AppFontName.OpenSans, size: 14)
                self.footer.lblValue.textColor = AppColor.darkGrayColor
                self.footer.lblValue.numberOfLines = 0
                
                self.footer.lblValue.text = self.expName == String() ? ConstantTexts.SelectLT : self.expName
                self.footer.viewLine.backgroundColor = AppColor.placeholderColor
                
                self.footer.btnDropDown.addTarget(self, action: #selector(btnDropDownTapped), for: .touchUpInside) */
                
                return UIView()
            }else{
                return UIView()
            }
        }else{
            return UIView()
        }
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
         if let sections = self.appointMentListVM?.numberOfSections{
             return section == (sections - 1) ? 0 : 0
         }else{
             return 0
         }
        
       /* if let sections = self.appointMentListVM?.numberOfSections{
            return section == (sections - 1) ? 270 : 0
        }else{
            return 0
        } */
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        
        if let sections = self.appointMentListVM?.numberOfSections{
            return section == (sections - 1) ? 0 : 0
        }else{
            return 0
        }
       
      /* if let sections = self.appointMentListVM?.numberOfSections{
           return section == (sections - 1) ? 270 : 0
       }else{
           return 0
       } */
   }
}

