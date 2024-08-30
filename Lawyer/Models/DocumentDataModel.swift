//
//  DocumentDataModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//


import Foundation
import UIKit
class DocumentDataModel{
    var data:Data = Data()
    var type:String = String()
    var withName:String = String()
    var fileName:String = String()
    var mimeType:String = String()
    var isSelected:Bool = Bool()
    
    
    var Id:String = String()
    var ConsultationId:String = String()
    var DocumentUrl:String = String()
    var FileType:String = String()
    var FileName:String = String()
    
    var isAudioFile:Bool = Bool()
    var localSoundPath:String = String()
    var serverSoundPath:String = String()
    var OrderId:String = String()
    
    init(data:Data, type:String, withName:String,fileName:String,mimeType:String,isSelected:Bool, isAudioFile:Bool,localSoundPath:String,serverSoundPath:String, Id:String,ConsultationId:String,DocumentUrl:String,FileType:String,FileName:String,OrderId:String){
        self.data = data
        self.type = type
        self.withName = withName
        self.fileName = fileName
        self.mimeType = mimeType
        self.isSelected = isSelected
        
        self.isAudioFile = isAudioFile
        self.localSoundPath = localSoundPath
        self.serverSoundPath = serverSoundPath
        
        self.Id = Id
        self.ConsultationId = ConsultationId
        self.DocumentUrl = DocumentUrl
        self.FileType = FileType
        self.FileName = FileName
        self.OrderId = OrderId
    }
}
