//
//  DataStoreStruct_GSTIN_List_ViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation


//TODO: Parent view model for showing list of dataStoreStruct
struct DataStoreStruct_GSTIN_List_ViewModel {
    var dataStoreStructs:[DataStoreStruct_GSTIN]
    
}

extension DataStoreStruct_GSTIN_List_ViewModel{
    init(_ dataStoreStructs:[DataStoreStruct_GSTIN]) {
        self.dataStoreStructs = dataStoreStructs
    }
}

extension DataStoreStruct_GSTIN_List_ViewModel{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.dataStoreStructs.count
    }
    
    
    public func dataStoreStructAtIndex(_ index:Int) -> DataStoreStruct_GSTIN_ViewModel{
        return DataStoreStruct_GSTIN_ViewModel(self.dataStoreStructs[index])
    }
    
}





//TODO: Child view model for showing a single category
struct DataStoreStruct_GSTIN_ViewModel {
     var dataStoreStruct:DataStoreStruct_GSTIN
}

extension DataStoreStruct_GSTIN_ViewModel{
    init(_ dataStoreStruct:DataStoreStruct_GSTIN) {
        self.dataStoreStruct = dataStoreStruct
    }
}


extension DataStoreStruct_GSTIN_ViewModel{
    
   var title:String{
        return self.dataStoreStruct.title
    }
    
    var placeholder:String{
        return self.dataStoreStruct.placeholder
    }
    
    var value:String{
        return self.dataStoreStruct.value
    }
    
    var type:GSTIN_Type{
        return self.dataStoreStruct.type!
    }
   
}
