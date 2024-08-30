//
//  NSObject+Extensions.swift
//  Lawyer
//
//  Created by Aman Kumar on 23/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//
import Foundation
//MARK: - NSObject extension
extension NSObject {
    //TODO: Get class name
    class var className: String {
        return String(describing: self)
    }
}
