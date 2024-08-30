//
//  FilterCategoryViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 05/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation

//TODO: Parent view model for showing list of filter category
struct FilterCategory_List_ViewModel {
    var filterCategories:[FilterCategory]
    
}

extension FilterCategory_List_ViewModel{
    init(_ filterCategories:[FilterCategory]) {
        self.filterCategories = filterCategories
    }
}


extension FilterCategory_List_ViewModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfItemsInSection(_ section:Int) -> Int{
        return self.filterCategories.count
    }
    
    
    public func filterCategoriesAtIndex(_ index:Int) -> FilterCategoryViewModel{
        return FilterCategoryViewModel(self.filterCategories[index])
    }
    
}





//TODO: Child view model for showing a single filter category
struct FilterCategoryViewModel {
     var filterCategory:FilterCategory
}

extension FilterCategoryViewModel{
    init(_ filterCategory:FilterCategory) {
        self.filterCategory = filterCategory
    }
}

extension FilterCategoryViewModel{
    
   var title:String{
        return self.filterCategory.title
    }
    
    var filters:Filter_List_ViewModel{
        guard let filters = self.filterCategory.filters else{
            fatalError("No filters found...")
        }
        return filters
    }
    
}



