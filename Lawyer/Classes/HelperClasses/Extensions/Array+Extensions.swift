//
//  Array+Extensions.swift
//  Lawyer
//
//  Created by Aman Kumar on 31/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
 extension Array where Element: Equatable {

    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }

}
