//
//  UINavigationBarButtonType.swift
//  Lawyer
//
//  Created by Aman Kumar on 23/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
//MARK: - For UINavigationBarButtonType
enum UINavigationBarButtonType: Int {
    
    case back
    case backRoot
    case empty
    case location
    
    //TODO : Set images according to UINavigationBarButtonType
    var iconImage: UIImage? {
        switch self {
        case .backRoot: return #imageLiteral(resourceName: "leftChevron")
        case .back: return #imageLiteral(resourceName: "leftChevron")
        case .location: return #imageLiteral(resourceName: "location-pin")
        case .empty: return UIImage()
        }
    }
}


