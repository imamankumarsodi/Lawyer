//
//  ProfileDataViewModel.swift
//  Lawyer
//
//  Created by Aman Kumar on 02/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit


//TODO: Parent view model for showing list of ProfileDataViewModel
struct ProfileDataViewModelList {
    var profileItems:[ProfileDataModel]
}


extension ProfileDataViewModelList{
    var numberOfSections:Int{
        return profileItems.count
    }
    
    
    public func profileItems(_ section:Int) -> Int{
        return profileItems[section].items.count
    }
    
    
    public func appointmentAtIndex(_ index:Int) -> ProfileDataViewModel{
        return ProfileDataViewModel(self.profileItems[index])
    }
    
}




//TODO: Child view model for showing a single ProfileDataViewModel
struct ProfileDataViewModel {
     var profileDataModel:ProfileDataModel
}

extension ProfileDataViewModel{
    init(_ profileDataModel:ProfileDataModel) {
        self.profileDataModel = profileDataModel
    }
}

extension ProfileDataViewModel{
    var title:String{
        return self.profileDataModel.title
    }
    
    var isSelected:Bool{
        return self.profileDataModel.isSelected
    }
    
    var image:UIImage{
        return self.profileDataModel.image
    }
    
    var items:[String]{
        return self.profileDataModel.items
    }
    
}
