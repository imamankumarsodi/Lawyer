//
//  QueryDataModelNewViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation

//TODO: Parent view model for showing list of OrderStatusDataViewModel
struct QueryDataViewNewListModel {
    var queries:[QueryDataModelNew]
}

extension QueryDataViewNewListModel{
    init(_ queries:[QueryDataModelNew]) {
        self.queries = queries
    }
}

extension QueryDataViewNewListModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.queries.count
    }
    
    
    public func QueryAtIndex(_ index:Int) -> QueryDataModelNewViewModel{
        return QueryDataModelNewViewModel(self.queries[index])
    }
    
}






struct QueryDataModelNewViewModel {
    var query:QueryDataModelNew
}

extension QueryDataModelNewViewModel{
    init(_ query:QueryDataModelNew) {
        self.query = query
    }
}

extension QueryDataModelNewViewModel{
  
    var Answer:String{
        return self.query.Answer
    }
    
    var CategoryId:String{
        return self.query.CategoryId
    }
    
    var CategoryName:String{
        return self.query.CategoryName
    }
    
    
    var Email:String{
        return self.query.Email
    }
    
    var FullName:String{
        return self.query.FullName
    }
    
    var Id:String{
        return self.query.Id
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
    
    var answerBy:String{
        return self.query.answerBy
    }
    
    var Date:String{
        return self.query.Date
    }
    
    var AnswerByName:String{
        return self.query.AnswerByName
    }

    
}
