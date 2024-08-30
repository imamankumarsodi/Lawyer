//
//  DocumentViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

//TODO: Parent view model for showing list of DocumentDataModel
struct DocumentViewModelList {
    var documentDataItems:[DocumentDataModel]
}

extension DocumentViewModelList{
    init(_ documentDataItems:[DocumentDataModel]) {
        self.documentDataItems = documentDataItems
    }
}


extension DocumentViewModelList{
    var numberOfSections:Int{
        return 1
    }
    
    
    public func numberOfRowsInSection(_ section:Int) -> Int{
        return self.documentDataItems.count
    }
    
    
    public func documentAtIndex(_ index:Int) -> DocumentViewModel{
        return DocumentViewModel(self.documentDataItems[index])
    }
    
}




//TODO: Child view model for showing a single DocumentDataModel
struct DocumentViewModel {
    var documentDataModel:DocumentDataModel
}

extension DocumentViewModel{
    init(_ documentDataModel:DocumentDataModel) {
        self.documentDataModel = documentDataModel
    }
}

extension DocumentViewModel{
    var data:Data{
        return self.documentDataModel.data
    }
    
    var type:String{
        return self.documentDataModel.type
    }
    
    var withName:String{
        return self.documentDataModel.withName
    }
    
    var fileName:String{
        return self.documentDataModel.fileName
    }
    
    var mimeType:String{
        return self.documentDataModel.mimeType
    }
    
    
    var isSelected:Bool{
        return self.documentDataModel.isSelected
    }
    
    var isAudioFile:Bool{
        return self.documentDataModel.isAudioFile
    }
    
    var Id:String{
        return self.documentDataModel.Id
    }
    
    var ConsultationId:String{
        return self.documentDataModel.ConsultationId
    }
    
    var DocumentUrl:String{
        return self.documentDataModel.DocumentUrl
    }
    
    var FileType:String{
        return self.documentDataModel.FileType
    }
    
    var FileName:String{
        return self.documentDataModel.FileName
    }
    
    var localSoundPath:String{
        return self.documentDataModel.localSoundPath
    }
    
    var serverSoundPath:String{
        return self.documentDataModel.serverSoundPath
    }
    
   
    
}
