//
//  EarnDataViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
//TODO: Child view model for showing a single EarnDataViewModel
struct EarnDataListViewModel {
    var earns:[EarnDataModel]
}

extension EarnDataListViewModel{
    init(_ earns:[EarnDataModel]) {
        self.earns = earns
    }
}

extension EarnDataListViewModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.earns.count
    }
    
    
    public func EarnAtIndex(_ index:Int) -> EarnDataViewModel{
        return EarnDataViewModel(self.earns[index])
    }
    
}


//TODO: Child view model for showing a single EarnDataViewModel
struct EarnDataViewModel {
    var earn:EarnDataModel
}

extension EarnDataViewModel{
    init(_ earn:EarnDataModel) {
        self.earn = earn
    }
}


extension EarnDataViewModel{
   
    
    var name:String{
        return self.earn.name
    }
    
    var date:String{
        return self.earn.date
    }
    
    var price:String{
        return self.earn.price
    }
    
    var Id:String{
        return self.earn.Id
    }
    
}
