//
//  QueryDataModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class QueryDataModel{
    var Answer:[String] = [String]()
    var Email:String = String()
    var FullName:String = String()
    var MobileNo:String = String()
    var Query:String = String()
    var Status:String = String()
    var isOpen:Bool = Bool()
    init(Answer:[String],Email:String,FullName:String,MobileNo:String,Query:String,Status:String,isOpen:Bool){
        self.Answer = Answer
        self.Email = Email
        self.FullName = FullName
        self.MobileNo = MobileNo
        self.Query = Query
        self.Status = Status
        self.isOpen = isOpen
    }
}

