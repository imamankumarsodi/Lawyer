//
//  Lawyer_View_Model.swift
//  Lawyer
//
//  Created by Aman Kumar on 19/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation


//TODO: Parent view model for showing list of lawyers
struct Lawyer_List_View_Model {
    var lawyers:[Lawyer_Model]
}

extension Lawyer_List_View_Model{
    init(_ lawyers:[Lawyer_Model]) {
        self.lawyers = lawyers
    }
}

extension Lawyer_List_View_Model{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.lawyers.count
    }
    
    
    public func lawyerAtIndex(_ index:Int) -> Lawyer_View_Model{
        return Lawyer_View_Model(self.lawyers[index])
    }
    
}




//TODO: Child view model for showing a single Lawyer
struct Lawyer_View_Model {
     var lawyer:Lawyer_Model
}

extension Lawyer_View_Model{
    init(_ lawyer:Lawyer_Model) {
        self.lawyer = lawyer
    }
}

extension Lawyer_View_Model{
    
   var CityName:String{
        return self.lawyer.CityName
    }
    
    var ConsulationType_Call_Fee:String{
        return self.lawyer.ConsulationType_Call_Fee
    }
    
    var ConsulationType_Meet_Fee:String{
        return self.lawyer.ConsulationType_Meet_Fee
    }
    
    var ConsulationType_Video_Call_Fee:String{
        return self.lawyer.ConsulationType_Video_Call_Fee
    }
    
    var Experience_Name:String{
        return self.lawyer.Experience_Name
    }
    
    var Expertise_String:String{
        return self.lawyer.Expertise_String
    }
    
    var FullName:String{
        return self.lawyer.FullName
    }
    
    var Id:String{
        return self.lawyer.Id
    }
    
    var Language_String:String{
        return self.lawyer.Language_String
    }
    
    var ProfilePhoto:String{
        return self.lawyer.ProfilePhoto
    }
    
    var Uuid:String{
        return self.lawyer.Uuid
    }
    
}

