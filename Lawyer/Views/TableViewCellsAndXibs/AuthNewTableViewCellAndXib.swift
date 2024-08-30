//
//  AuthNewTableViewCellAndXib.swift
//  Lawyer
//
//  Created by Aman Kumar on 15/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class AuthNewTableViewCellAndXib: SBaseTableViewCell {
    //MARK: - IBOutlets
    @IBOutlet weak var textFieldFloating: UITextField!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var imgView: UIImageView!
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setUpTextField()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.setUpTextField()
    }
    
    
    //MARK: - User Define Functions
    //TODO: Config TableViewCell
    
    public func configure(with info: DataStoreStruct_ViewModel) {
        self.textFieldFloating.placeholder = info.placeholder
        self.imgView.image = info.image
        self.textFieldFloating.text = info.value
        
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
            textFieldFloating.autocapitalizationType = .words
            
        }
    }
    
    
    //TODO: - Setup textFieldFloating
    private func setUpTextField(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        textFieldFloating.font = AppFont.Regular.size(AppFontName.OpenSans, size: 12)
        textFieldFloating.tintColor = AppColor.app_gradient_color1 // the color of the blinking cursor
        textFieldFloating.textColor = AppColor.darkGrayColor
        textFieldFloating.clearButtonMode = .always
        imgView.setImageTintColor(AppColor.darkGrayColor)
        
        customMethodManager?.provideShadowAndCornerRadius(self.viewBG, 5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        
    }
    
    
}
