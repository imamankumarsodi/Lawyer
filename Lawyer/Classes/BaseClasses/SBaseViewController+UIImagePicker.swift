//
//  SBaseViewController+UIImagePicker.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices
import Photos
extension SBaseViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate  {
    
    
    //TODO: Open camera
    internal func openCamera() {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            myPickerController.sourceType = UIImagePickerController.SourceType.camera
            myPickerController.delegate = self
            self .present(myPickerController, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: APP_NAME, message:ConstantTexts.cameraAlert, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: ConstantTexts.OkBT, style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //TODO: Open gallery
    internal func openGallery() {
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        myPickerController.delegate = self
        myPickerController.mediaTypes = ["public.image"]
        self.present(myPickerController, animated: true, completion: nil)
        
        
        
    }
    
    //TODO: Implementation getDocumentsDirectory for getting image name
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    
    //MARK: - Image picker delegates
    //TODO: Implementation imagePickerControllerDidCancel
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: false, completion: nil)
    }
    
    //TODO: Implementation imagePickerController
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let choosen_image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            let item = DocumentDataModel(data: Data(), type: ".png", withName: "OtherDocs", fileName: String(), mimeType: "image/png", isSelected: Bool(),isAudioFile: Bool(),localSoundPath: String(),serverSoundPath: String(),Id:String(), ConsultationId:String(), DocumentUrl:String(), FileType:String(), FileName:String(), OrderId: String())
            
            if let data = choosen_image.jpegData(compressionQuality:0.5){
                item.data = data
            }
            let imageName = UUID().uuidString
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            item.fileName = "\(imagePath.lastPathComponent).png"
            
            self.getDocCallBack?(item)
            
        }

        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    
}

