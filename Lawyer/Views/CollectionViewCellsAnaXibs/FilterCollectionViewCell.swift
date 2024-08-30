//
//  FilterCollectionViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 04/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var imageDD: UIImageView!
    @IBOutlet weak var titleFilter: UILabel!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var btnSelectRef: UIButton!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCell()
    }
    
    
    
    //TODO: Setup cell implementation
    private func setUpCell(){
        
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self, (self.viewBG.frame.height/2) - 4, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, 2, 2, 2, 2, 0, AppColor.clearColor)
        
        self.customMethodManager?.provideCornerBorderTo(self, 1, AppColor.textColor)
        
        self.viewBG.backgroundColor = AppColor.app_gradient_color1
        
        self.backgroundColor = AppColor.app_gradient_color1
        self.titleFilter.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.titleFilter.textColor = AppColor.whiteColor
        self.titleFilter.textAlignment = .center
        self.titleFilter.numberOfLines = 0
        
        self.imageDD.setImageTintColor(AppColor.whiteColor)
        
    }
    
    
    //TODO: Configure with info
    public func configure(with info: FilterCategoryViewModel){
        self.titleFilter.text = info.title
    }
    
    public func configure(with info: Filter){
        self.titleFilter.text = info.title
    }
    

}
