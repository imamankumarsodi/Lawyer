//
//  SBaseViewController.swift
//  Lawyer
//
//  Created by Aman Kumar on 23/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class SBaseViewController: UIViewController {
    //MARK: - Variables
    internal let myPickerController = UIImagePickerController()
    internal var getDocCallBack:((_ item : DocumentDataModel)->())?
    internal var goToCity:(()->())?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    //MARK: - Actions, Selectors, Gestures
    //TODO:  selectors
    
    @objc func navigationButtonTapped(_ sender: AnyObject) {
        guard let buttonType = UINavigationBarButtonType(rawValue: sender.tag) else {
            return }
        
        switch buttonType {
        case .backRoot:
            let vc = AppStoryboard.tabBarSB.instantiateViewController(withIdentifier: TabBarVC.className) as! TabBarVC
            vc.selectedIndex = 1
            UIApplication.shared.windows.first?.rootViewController = vc
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        case .back: self.navigationBarButtonDidTapped(buttonType)
        case .location: self.goToCity?()
        case .empty: print("do nothing...")
            
        }
    }
    
    
    
}
