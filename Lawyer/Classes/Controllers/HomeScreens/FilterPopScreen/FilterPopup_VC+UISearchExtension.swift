//
//  FilterPopup_VC+UISearchExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension FilterPopup_VC:UISearchBarDelegate{
    
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
        if self.search_filterList?.filters.count ?? Int() > 0{
            self.search_filterList?.filters.removeAll()
        }
        
        
        if !self.validationMethodManager!.checkEmptyField(self.searchBar.text!.trimmingCharacters(in: .whitespaces)) {
            self.searchActive = false
        }else{
            self.searchActive = true
            if self.filterList?.filters.count ?? Int() >= 1 {
                if let filters = self.filterList?.filters{
                    for index in 0..<filters.count{
                        if (filters[index].title.lowercased().range(of: searchText.lowercased()) != nil) {
                            self.search_filterList?.filters.append(filters[index])
                        }
                    }
                }
            }
        }
        DispatchQueue.main.async {
            self.filterTableView.reloadData()
        }
        
    }
}


