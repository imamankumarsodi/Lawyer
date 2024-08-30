//
//  FilterViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 05/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation

//TODO: Parent view model for showing list of filter category
class Filter_List_ViewModel {
    var filters:[Filter]
    
    init(_ filters:[Filter]) {
        self.filters = filters
    }
    
}

extension Filter_List_ViewModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.filters.count
    }
    
    
    public func filterAtIndex(_ index:Int) -> FilterViewModel{
        return FilterViewModel(self.filters[index])
    }
    
}




//TODO: Child view model for showing a single filter
struct FilterViewModel {
     var filter:Filter
}

extension FilterViewModel{
    init(_ filter:Filter) {
        self.filter = filter
    }
}

extension FilterViewModel{
    
   var title:String{
        return self.filter.title
    }
    
    var isSelected:Bool{
        return self.filter.isSelected
    }
    
}
