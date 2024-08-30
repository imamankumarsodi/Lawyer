//
//  GSTIN_TableViewCellAndXib.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class GSTIN_TableViewCellAndXib: SBaseTableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var imgDD: UIImageView!
    @IBOutlet weak var btnDDSelectRef: UIButton!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUpTextField()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        setUpTextField()
    }
    
    
    //MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    public func configure(with info: DataStoreStruct_GSTIN_ViewModel) {
        self.textField.placeholder = info.placeholder
        self.textField.text = info.value
        
        switch info.type{
        case .GSTIN:
            imgDD.isHidden = true
            textField.maxLength = 15
            textField.keyboardType = .default
            textField.isSecureTextEntry = false
            textField.autocapitalizationType = .allCharacters
            btnDDSelectRef.isHidden = true
            
            
        case .CompanyName:
            imgDD.isHidden = true
            textField.maxLength = 30
            textField.keyboardType = .namePhonePad
            textField.isSecureTextEntry = false
            textField.autocapitalizationType = .words
            btnDDSelectRef.isHidden = true
            
            
        case .DropDownType:
            imgDD.isHidden = false
            textField.maxLength = 30
            textField.keyboardType = .default
            textField.isSecureTextEntry = false
            textField.autocapitalizationType = .none
            btnDDSelectRef.isHidden = false
            
            
        case .Address:
            imgDD.isHidden = true
            textField.maxLength = 60
            textField.keyboardType = .namePhonePad
            textField.isSecureTextEntry = false
            textField.autocapitalizationType = .none
            btnDDSelectRef.isHidden = true
        }
        
    }
    
    
    
    //TODO: - Setup textFieldFloating
    private func setUpTextField(){
        
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        self.backgroundColor = AppColor.tableBGColor
        customMethodManager?.provideCornerBorderTo(self.textField, 1, AppColor.placeholderColor)
        textField.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        textField.tintColor = AppColor.app_gradient_color1 // the color of the blinking cursor
        textField.textColor = AppColor.darkGrayColor
        textField.clearButtonMode = .always
        textField.addPadding(.both(10.0))
        textField.backgroundColor = AppColor.whiteColor
        imgDD.setImageTintColor(AppColor.placeholderColor)
    }
    
}
