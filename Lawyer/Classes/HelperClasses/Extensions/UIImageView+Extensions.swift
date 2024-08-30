//
//  UIImageView+Extensions.swift
//  Lawyer
//
//  Created by Aman Kumar on 23/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
//MARK: - Extension UIImageView
extension UIImageView{
    //TODO: Set image color
    func setImageTintColor(_ color:UIColor){
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
    }
}
