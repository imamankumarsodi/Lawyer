//
//  LawyerTableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 21/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class LawyerTableViewCell: SBaseTableViewCell {

    //MARK: - IBOutlets
    @IBOutlet weak var imageCategory: UIImageView!
    @IBOutlet weak var titlelLabelCategory: UILabel!
    @IBOutlet weak var imageRightArrow: UIImageView!
    @IBOutlet weak var viewBG: UIView!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //TODO: Setup cell implementation
    private func setUpCell(){
        
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        self.imageRightArrow.isHidden = true
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 0, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, 2, 2, 2, 2, 0, AppColor.tableBGColor)
        self.viewBG.backgroundColor = AppColor.whiteColor
        
        self.backgroundColor = AppColor.tableBGColor
        self.titlelLabelCategory.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 12)
        self.titlelLabelCategory.textColor = AppColor.darkGrayColor
        self.titlelLabelCategory.numberOfLines = 4
        
        
        
       /*
        self.imageCategory.setImageTintColor(AppColor.darkGrayColor)
        self.imageRightArrow.setImageTintColor(AppColor.darkGrayColor)
         */
    }
    
    
    //TODO: Configure with info
    public func configure(with info: CategoryViewModel){
        self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url)
       /* self.imageCategory.image = info.image */
        self.imageCategory.contentMode = .scaleAspectFit
        
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyleLeft = NSMutableParagraphStyle()
        paragraphStyleLeft.alignment = .left
        
        // *** set LineSpacing property in points ***
        paragraphStyleLeft.lineSpacing = 1 // Whatever line spacing you want in points
        
       let myMutableString = NSMutableAttributedString()
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(info.title)\n", font: AppFont.Semibold.size(AppFontName.OpenSans, size: 16), color: AppColor.textColor) ?? NSMutableAttributedString())
        
        myMutableString.append(customMethodManager?.provideSimpleAttributedText(text: "\(info.Description)", font: AppFont.Regular.size(AppFontName.OpenSans, size: 10), color: AppColor.darkGrayColor) ?? NSMutableAttributedString())
       
        // *** Apply attribute to string ***
        myMutableString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyleLeft, range:NSMakeRange(0, myMutableString.length))
        self.titlelLabelCategory.attributedText = myMutableString
        
    }
    
    
    //TODO: Configure with new info
    public func configureNew(with info: CategoryViewModel){
       /* self.customMethodManager?.setImage(imageView: self.imageCategory, url: info.Url) */
        self.imageCategory.image = info.image
        self.titlelLabelCategory.text = info.title
        self.imageCategory.contentMode = .center
    }
    
}
