//
//  HomeVC+UISearchDelegate.swift
//  Lawyer
//
//  Created by Aman Kumar on 09/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension HomeVC:UISearchBarDelegate{
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = self.validationMethodManager!.checkEmptyField(self.searchBar.text!.trimmingCharacters(in: .whitespaces))
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchActive = false
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false
        self.dismissKeyboard()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //TODO: Remove all previous searched elements
        if self.expertiseVM?.categories.count ?? Int() > 0{
            self.expertiseVM?.categories.removeAll()
        }
        
        
        if !self.validationMethodManager!.checkEmptyField(self.searchBar.text!.trimmingCharacters(in: .whitespaces)) {
            self.searchActive = false
        }else{
            self.searchActive = true
            if self.categoryListVM?.categories.count ?? Int() >= 1 {
                if let filters = self.categoryListVM?.categories{
                    for index in 0..<filters.count{
                        if (filters[index].title.lowercased().range(of: searchText.lowercased()) != nil) {
                            self.expertiseVM?.categories.append(filters[index])
                        }
                    }
                }
            }
        }
        
        DispatchQueue.main.async {
            self.categoryTableView.reloadData()
        }
    }
}


