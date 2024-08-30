//
//  LawyerListVC+CollectionViewExtensions.swift
//  Lawyer
//
//  Created by Aman Kumar on 05/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
//MARK: - UICollectionViewDataSource extension
extension LawyerListVC:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        if collectionView == filterCollectionView{
            return (self.filterCategoryListDataVM == nil) ? 0 : self.filterCategoryListDataVM?.numberOfSections ?? 0
        }else{
            return 1
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == filterCollectionView{
            return self.filterCategoryListDataVM?.numberOfItemsInSection(section) ?? 0
        }else{
            return self.filters.count
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == filterCollectionView{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.className, for: indexPath) as? FilterCollectionViewCell else{
                fatalError(ConstantTexts.unexpectedIndexPath)
            }
            
            guard let item = self.filterCategoryListDataVM?.filterCategoriesAtIndex(indexPath.row) else {
                fatalError("No FilterCategoryViewModel found...")
            }
            
            cell.btnSelectRef.tag = indexPath.row
            cell.btnSelectRef.addTarget(self, action: #selector(self.btnSelectedCell(_:)), for: .touchUpInside)
            
            cell.configure(with: item)
            return cell
        }else{
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterItemCollectionViewCell.className, for: indexPath) as? FilterItemCollectionViewCell else{
                fatalError(ConstantTexts.unexpectedIndexPath)
            }
            
            cell.btnSelectRef.tag = indexPath.row
            cell.btnSelectRef.addTarget(self, action: #selector(self.btnDeleteCell(_:)), for: .touchUpInside)
            
            cell.configure(with: filters[indexPath.row])
            return cell
        }
 
    }
    
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout extension
extension LawyerListVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        if collectionView == filterCollectionView{
           
            
            guard let item = self.filterCategoryListDataVM?.filterCategoriesAtIndex(indexPath.row) else {
                fatalError("No FilterCategoryViewModel found...")
            }
            
            let width = self.estimatedFrame(text: item.title, font: AppFont.Semibold.size(AppFontName.OpenSans, size: 14)).width + 65
            
            return CGSize(width: width, height: collectionView.frame.size.height)
            
        }else{
            let width = self.estimatedFrame(text: self.filters[indexPath.row].title, font: AppFont.Semibold.size(AppFontName.OpenSans, size: 12)).width + 65
            return CGSize(width: width, height: collectionView.frame.size.height)
            
        }
        
    }
    
    func estimatedFrame(text: String, font: UIFont) -> CGRect {
        let size = CGSize(width: 1000, height: 1000) // temporary size
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size,
                                                   options: options,
                                                   attributes: [NSAttributedString.Key.font: font],
                                                   context: nil)
    }
    
}
