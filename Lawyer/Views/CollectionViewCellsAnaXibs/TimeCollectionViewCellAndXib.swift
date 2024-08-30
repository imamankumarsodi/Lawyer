//
//  TimeCollectionViewCellAndXib.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class TimeCollectionViewCellAndXib: UICollectionViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var btnSelectRef: UIButton!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var buttonCallBack:((Int)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCell()
    }
    
    
    
    //MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    public func configure(with info: AppointmentTimeDataModel) {
           self.title.text = info.title
           if info.isSelected{
               self.title.textColor = AppColor.whiteColor
               self.title.backgroundColor = AppColor.app_gradient_color1
           }else{
               self.title.textColor = AppColor.darkGrayColor
               self.title.backgroundColor = AppColor.whiteColor
           }
           
       }
    
    
    
    //TODO: Setup cell implementation
    private func setUpCell(){
        
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        self.customMethodManager?.provideCornerRadiusTo(self, 4, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.customMethodManager?.provideCornerBorderTo(self, 1, AppColor.placeholderColor)
        
       
        
        self.title.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 10)
        self.title.textAlignment = .center
        self.title.numberOfLines = 0
        
        
     
    }
    
    @IBAction func btnSelectTapped(_ sender: UIButton) {
        self.buttonCallBack?(sender.tag)
    }
    

}
