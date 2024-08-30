//
//  QueryDataViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation

//TODO: Parent view model for showing list of OrderStatusDataViewModel
struct QueryDataViewListModel {
    var queries:[QueryDataModel]
}

extension QueryDataViewListModel{
    init(_ queries:[QueryDataModel]) {
        self.queries = queries
    }
}

extension QueryDataViewListModel{
    var numberOfSections:Int{
        return queries.count
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.queries[section].Answer.count
    }
    
    
    public func QueryAtIndex(_ index:Int) -> QueryDataViewModel{
        return QueryDataViewModel(self.queries[index])
    }
    
}



//TODO: Child view model for showing a single OrderStatusDataViewModel
struct QueryDataViewModel {
    var query:QueryDataModel
}

extension QueryDataViewModel{
    init(_ query:QueryDataModel) {
        self.query = query
    }
}

extension QueryDataViewModel{
   
    var Answer:[String]{
        return self.query.Answer
    }
    
    var Email:String{
        return self.query.Email
    }
    
    var FullName:String{
        return self.query.FullName
    }
    
    var MobileNo:String{
        return self.query.MobileNo
    }
    
    var Query:String{
        return self.query.Query
    }
    
    var Status:String{
        return self.query.Status
    }
    
    var isOpen:Bool{
        return self.query.isOpen
    }

}
