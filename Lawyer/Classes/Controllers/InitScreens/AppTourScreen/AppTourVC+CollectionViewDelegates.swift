//
//  AppTourVC+CollectionViewDelegates.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
//MARK: - UICollectionViewDataSource extension
extension AppTourVC:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tourArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppTourCollectionViewCell.className, for: indexPath) as? AppTourCollectionViewCell else{
            fatalError(ConstantTexts.unexpectedIndexPath)
        }
        
        cell.configure(with: self.tourArray[indexPath.row])
        return cell
    }
    
    
    
}



//MARK: - UICollectionViewDelegate extension
extension AppTourVC:UICollectionViewDelegate{
   
   /* func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.pageControl.currentPage = indexPath.row
    } */
 
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = self.tourCollectionView.frame.size.width
            pageControl.currentPage = Int(self.tourCollectionView.contentOffset.x / pageWidth)
        self.buttonProceedRef.tag = Int(self.tourCollectionView.contentOffset.x / pageWidth)
        if pageControl.currentPage == 2{
            self.buttonProceedRef.isHidden = false
            self.buttonProceedRef.alpha = 1
            self.buttonProceedRef.setTitle(ConstantTexts.SKIP_BT, for: .normal)
            
        }else{
            if self.buttonProceedRef.alpha == 1{
                self.buttonProceedRef.isHidden = false
                self.buttonProceedRef.alpha = 1
                self.buttonProceedRef.setTitle(ConstantTexts.SKIP_BT, for: .normal)
                
            }
        }
    }

    
    /*  func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
     UIView.animate(withDuration: 0.5) {
     if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCellAndXib {
     cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
     cell.contentView.backgroundColor = AppColor.highLightColor
     }
     }
     }
     
     func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
     UIView.animate(withDuration: 0.5) {
     if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCellAndXib {
     cell.viewBG.transform = .identity
     cell.contentView.backgroundColor = .clear
     
     let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: LawyerListVC.className) as! LawyerListVC
     if let categoryVM = self.categoryListVM?.categoryAtIndex(indexPath.row){
     vc.headerTitle = categoryVM.title
     }
     self.navigationController?.pushViewController(vc, animated: true)
     
     }
     }
     } */
    
}

//MARK: - UICollectionViewDelegateFlowLayout extension
extension AppTourVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if MAIN_SCREEN_HEIGHT > 736{
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height + 44)
        }else{
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height + 20)
        }
        
        
    }
}
