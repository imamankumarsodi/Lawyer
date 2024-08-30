//
//  QueryListVM.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
/*class QueryListVM: QueryDataModeling {
    
    
    static let shared = QueryListVM()
    private init() {}
  
    
    func initDataSource() -> QueryDataViewListModel {
        return QueryDataViewListModel([QueryDataModel]())
    }
    
    func prepareDataSource(data: NSArray) -> QueryDataViewListModel {
        var queries:[QueryDataModel] = [QueryDataModel]()
        for item in data{
            if let itemDict = item as? NSDictionary{
                let query:QueryDataModel = QueryDataModel(Answer: [String](), Email: String(), FullName: String(), MobileNo: String(), Query: String(), Status: String(), isOpen: Bool())
                
                let Answer = itemDict.value(forKey: "Answer") as? String ?? ConstantTexts.QueryReso_LT
                query.Answer.append(Answer)
                
                if let Email = itemDict.value(forKey: "Email") as? String{
                    query.Email = Email
                }
                
                if let FullName = itemDict.value(forKey: "FullName") as? String{
                    query.FullName = FullName
                }
                
                if let MobileNo = itemDict.value(forKey: "MobileNo") as? String{
                    query.MobileNo = "\(MobileNo)"
                }
                
                if let MobileNo = itemDict.value(forKey: "MobileNo") as? Int{
                    query.MobileNo = "\(MobileNo)"
                }
                
                if let Query = itemDict.value(forKey: "Query") as? String{
                    query.Query = Query
                }
                
                if let Status = itemDict.value(forKey: "Status") as? String{
                    query.Status = Status
                }
                
                
                
                queries.append(query)
            }
        }
        
        return QueryDataViewListModel(queries)
    }
    
} */


class QueryListVM: QueryDataViewNewModeling {
    
    
    static let shared = QueryListVM()
    private init() {}
  
    
    func initDataSource() -> QueryDataViewNewListModel {
        return QueryDataViewNewListModel([QueryDataModelNew]())
    }
    
    func prepareDataSource(data: NSArray) -> QueryDataViewNewListModel {
        var queries:[QueryDataModelNew] = [QueryDataModelNew]()
        for item in data{
            if let itemDict = item as? NSDictionary{
                var query:QueryDataModelNew = QueryDataModelNew(Answer: String(), CategoryId: String(), CategoryName: String(), Email: String(), FullName: String(), Id: String(), MobileNo: String(), Query: String(), Status: String(), answerBy: String(), Date: String(), AnswerByName: String())
                
               
                if let Answer = itemDict.value(forKey: "Answer") as? String{
                    query.Answer = Answer
                }
                
                if let CategoryId = itemDict.value(forKey: "CategoryId") as? String{
                    query.CategoryId = "\(CategoryId)"
                }
                
                if let CategoryId = itemDict.value(forKey: "CategoryId") as? Int{
                    query.CategoryId = "\(CategoryId)"
                }
                
                if let CategoryName = itemDict.value(forKey: "CategoryName") as? String{
                    query.CategoryName = "\(CategoryName)"
                }

                if let Email = itemDict.value(forKey: "Email") as? String{
                    query.Email = Email
                }
                
                if let FullName = itemDict.value(forKey: "FullName") as? String{
                    query.FullName = FullName
                }
                
                
                if let Id = itemDict.value(forKey: "Id") as? String{
                    query.Id = "\(Id)"
                }
                
                if let Id = itemDict.value(forKey: "Id") as? Int{
                    query.Id = "\(Id)"
                }
                
                
                if let MobileNo = itemDict.value(forKey: "MobileNo") as? String{
                    query.MobileNo = "\(MobileNo)"
                }
                
                if let MobileNo = itemDict.value(forKey: "MobileNo") as? Int{
                    query.MobileNo = "\(MobileNo)"
                }
                
                if let Query = itemDict.value(forKey: "Query") as? String{
                    query.Query = Query
                }
                
                if let Status = itemDict.value(forKey: "Status") as? String{
                    query.Status = Status
                }
                
                
                
                if let answerBy = itemDict.value(forKey: "answerBy") as? String{
                    query.answerBy = answerBy
                }
                
                
                
                if let Date = itemDict.value(forKey: "Date") as? String{
                    query.Date = Date
                }
                
                
                
                if let AnswerByName = itemDict.value(forKey: "AnswerByName") as? String{
                    query.AnswerByName = AnswerByName
                }
                
                
                
                queries.append(query)
            }
        }
        
        return QueryDataViewNewListModel(queries)
        
    }
    
    
    
}
