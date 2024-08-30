//
//  CategoryViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 21/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit


//TODO: Parent view model for showing list of category
struct CategoryListViewModel {
    
    var categories:[Category]
    
}

extension CategoryListViewModel{
    init(_ categories:[Category]) {
        self.categories = categories
    }
}

extension CategoryListViewModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.categories.count
    }
    
    
    public func categoryAtIndex(_ index:Int) -> CategoryViewModel{
        return CategoryViewModel(self.categories[index])
    }
    
}


//TODO: Child view model for showing a single category
struct CategoryViewModel {
    private let category:Category
}

extension CategoryViewModel{
    init(_ category:Category) {
        self.category = category
    }
}


extension CategoryViewModel{
    var title:String{
        return self.category.title
    }
    
    var Description:String{
        return self.category.Description
    }
    
    var expertiseId:String{
        return self.category.ExpertiseId
    }
    var Url:String{
        return self.category.Url
    }
    
    var image:UIImage{
        return self.category.image
    }
    
}
