//
//  PaymentVM.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
class PaymentVM: DataStoreStructListModeling_GSTIN {
    
    
    
    internal var validationMethodManager:ValidationProtocol?
    //TODO: Singleton object
    static let shared = PaymentVM()
    private init() {}
    
    //TODO: Init values implementation
    func initValue(){
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
    }
    
    
    //TODO: Prepare data source implementation
    func prepareDataSource() -> DataStoreStruct_GSTIN_List_ViewModel {
        let dataStores = [DataStoreStruct_GSTIN(title: ConstantTexts.GSTIN_PH, placeholder:ConstantTexts.GSTIN_PH, value: ConstantTexts.empty, type: GSTIN_Type.GSTIN),
                          DataStoreStruct_GSTIN(title: ConstantTexts.C_Name_PH, placeholder:ConstantTexts.C_Name_PH, value: ConstantTexts.empty, type: GSTIN_Type.CompanyName),
                          DataStoreStruct_GSTIN(title: ConstantTexts.State_PH, placeholder:ConstantTexts.State_PH, value: ConstantTexts.empty, type: GSTIN_Type.DropDownType),
                          DataStoreStruct_GSTIN(title: ConstantTexts.C_Address_PH, placeholder:ConstantTexts.C_Address_PH, value: ConstantTexts.empty, type: GSTIN_Type.Address)]
        
        return DataStoreStruct_GSTIN_List_ViewModel(dataStores)
    }
    
    
    //TODO: Validate fields implementation
    func validateFields(dataStore: DataStoreStruct_GSTIN_List_ViewModel, validHandler: @escaping (String, Bool, Int, Int) -> Void) {
        self.initValue()
        for index in 0..<dataStore.dataStoreStructs.count {
            switch dataStore.dataStoreStructAtIndex(index).type
            {
                
            case .GSTIN:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterGSTINNumberALERT, false, index, Int())
                    return
                    
                }
                
                if !validationMethodManager!.isValidGSTIN(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.EnterValidGSTINNumberALERT, false, index, Int())
                    return
                    
                }
                
            case .CompanyName:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterCorFNameALERT, false, index, Int())
                    return
                    
                }
                    
                else if !validationMethodManager!.isValidFullName(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    
                    validHandler( ConstantTexts.EnterValidCorFNameALERT, false, index, Int())
                    return
                    
                }
            case .DropDownType:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)) {
                    validHandler( ConstantTexts.SelectGSTINSTATE_DD_ALERT, false, index, Int())
                    return
                    
                }
            case .Address:
                if !validationMethodManager!.checkEmptyField(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    validHandler( ConstantTexts.EnterCorFAddressALERT, false, index, Int())
                    return
                    
                }
                    
                else if !validationMethodManager!.isValidFullName(dataStore.dataStoreStructAtIndex(index).value.trimmingCharacters(in: .whitespaces)){
                    
                    validHandler( ConstantTexts.EnterValidCorFAddressALERT, false, index, Int())
                    return
                    
                }
            }
        }
        
        validHandler(ConstantTexts.empty, true, Int(), Int())
        
    }  
}
