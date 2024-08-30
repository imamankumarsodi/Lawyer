//
//  AppFonts.swift
//  Lawyer
//
//  Created by Aman Kumar on 18/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit


//MARK: - Creating fonts
enum AppFontName: String {
  
    case OpenSans           =        "OpenSans"
    case OpenSansLight      =        "OpenSansLight"
    case Tahoma             =        "Tahoma"
    case Verdana            =        "Verdana"
}

enum AppFont: String {
   
    case Italic             =        "Italic"
    case Bold               =        "Bold"
    case SemiboldItalic     =        "SemiboldItalic"
    case ExtraboldItalic    =        "ExtraboldItalic"
    case BoldItalic         =        "BoldItalic"
    case Light              =        "Light"
    case Semibold           =        "Semibold"
    case Extrabold          =        "Extrabold"
    case Regular            =        ""
   
    func size(_ name: AppFontName,size: CGFloat) -> UIFont {
        
        if let font = UIFont(name: self.fullFontName(name.rawValue), size: size + 1.0) {
            return font
        }
        fatalError("Font '\(String(describing: fullFontName))' does not exist.")
    }
    
    fileprivate func fullFontName(_ fontName:String) -> String {
        
            return rawValue.isEmpty ? fontName : fontName + "-" + rawValue
       
        
    }
}



//MARK: - Constant fonts
struct ConstantFonts{
    static let  mainBottomButtonFont           =      AppFont.Bold.size(AppFontName.OpenSans, size: 16)
}

