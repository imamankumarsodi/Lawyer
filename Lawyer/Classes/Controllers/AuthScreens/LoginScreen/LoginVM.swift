//
//  LoginVM.swift
//  Lawyer
//
//  Created by Aman Kumar on 01/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
class LoginVM: DataStoreStructListModeling {
    
    internal var validationMethodManager:ValidationProtocol?
    //TODO: Singleton object
    static let shared = LoginVM()
    private init() {}
    
    //TODO: Init values implementation
    func initValue(){
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
    }
    
    
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DataStoreStruct_List_ViewModel{
        
        let dataStores = [DataStoreStruct(title: ConstantTexts.MobileNumberPH, placeholder: ConstantTexts.MobileNumberPH, value: ConstantTexts.empty, type: SignUpType.MobileNumber, image: UIImage(systemName: "phone") ?? UIImage())]
        
        return DataStoreStruct_List_ViewModel(dataStoreStructs: dataStores)
    }
    
    //TODO: Validate fields implementation
    func validateFields(dataStore: DataStoreStruct_List_ViewModel, validHandler: @escaping ( String, Bool,Int,Int) -> Void){
        
        self.initValue()
        
        for index in 0..<dataStore.dataStoreStructs.count {
            
            switch dataStore.dataStoreStructAtIndex(index).type
            {
            case .MobileNumber:
                
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterMobileNumberALERT, false, index, Int())
                    return
                    
                }
                else if !validationMethodManager!.isValidIndianPhoneCount(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterValidMobileNumberALERT, false, index, Int())
                    return
                }
                
            case .FullName:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterFullNameALERT, false, index, Int())
                    return
                    
                }
                    
                else if !validationMethodManager!.isValidFullName(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    
                    validHandler( ConstantTexts.EnterValidFullNameALERT, false, index, Int())
                    return
                    
                }
                
            case .Email:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterEmailALERT, false, index, Int())
                    return
                }
                else if !validationMethodManager!.isValidEmail(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterValidEmailALERT, false, index, Int())
                    return
                }
                
            case .OTP:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterOTPALERT, false, index, Int())
                    return
                } else if !validationMethodManager!.isValidOTPCount(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterValidOTPALERT, false, index, Int())
                    return
                }
                
                case .Comment:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterCommentALERT, false, index, Int())
                    return
                    
                }
                
            }
            
        }
        
        validHandler(ConstantTexts.empty, true, Int(), Int())
        
    }
    
    
    
}
