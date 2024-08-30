//
//  Auth_TextField_TableViewCell.swift
//  Lawyer
//
//  Created by Aman Kumar on 31/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class Auth_TextField_TableViewCell: SBaseTableViewCell {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var textFieldFloating: SkyFloatingLabelTextFieldWithIcon!
    
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
    
    public func configure(with info: DataStoreStruct_ViewModel) {
        self.textFieldFloating.placeholder = info.placeholder
        self.textFieldFloating.title = info.title
        textFieldFloating.iconImage = info.image
        
        switch info.type{
        case .MobileNumber:
            textFieldFloating.maxLength = 10
            textFieldFloating.keyboardType = .numberPad
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            
            
        case .FullName:
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .namePhonePad
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.iconImage = info.image
            textFieldFloating.autocapitalizationType = .words
            
            
        case .Email:
            textFieldFloating.maxLength = 30
            textFieldFloating.keyboardType = .emailAddress
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            
            
        case .OTP:
            textFieldFloating.maxLength = 4
            textFieldFloating.keyboardType = .numberPad
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.autocapitalizationType = .none
            
            
        case .Comment:
            textFieldFloating.maxLength = 200
            textFieldFloating.keyboardType = .default
            textFieldFloating.isSecureTextEntry = false
            textFieldFloating.iconImage = info.image
            textFieldFloating.autocapitalizationType = .words
            
        }
        
    }
    
    //TODO: - Setup textFieldFloating
    private func setUpTextField(){
        
        textFieldFloating.titleFormatter = { $0 }
        textFieldFloating.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        textFieldFloating.tintColor = AppColor.app_gradient_color1 // the color of the blinking cursor
        textFieldFloating.textColor = AppColor.darkGrayColor
        
        textFieldFloating.selectedTitleColor = AppColor.app_gradient_color1
        
       
        
        textFieldFloating.clearButtonMode = .always
        textFieldFloating.iconType = .image
        
        
        
        
    }
    
    
}
