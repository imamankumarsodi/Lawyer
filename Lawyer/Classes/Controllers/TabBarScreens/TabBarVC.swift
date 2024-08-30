//
//  TabBarVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 20/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
class TabBarVC: UITabBarController {
    
    //MARK: - Variables
    
    private let images = [#imageLiteral(resourceName: "home") ,#imageLiteral(resourceName: "icons-1")  , #imageLiteral(resourceName: "christmasgift"),  #imageLiteral(resourceName: "menu")]
    private let titles = [ConstantTexts.HomeLT ,ConstantTexts.OrdersLT, ConstantTexts.ReferAndEarnHT, ConstantTexts.MoreLT]
    
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    
    //TODO: Implementation viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.extendedLayoutIncludesOpaqueBars = false
    }
    
    
    @objc func onDidReceiveData(_ notification:Notification) {
        // Do something now
        self.selectedIndex = 1
       // NOTIFICATION_CENTER.removeObserver(self)
    }
    
    
}

//MARK: - Extension custom methods
extension TabBarVC{
    //TODO: Implementation setUpView
    private func setUpView() {
        
        
        
        NOTIFICATION_CENTER.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: NSNotification.Name(rawValue: ConstantTexts.paymentDone), object: nil)
        
        self.tabBar.isTranslucent = true
        
        self.selectedIndex = 0
        self.delegate = self
        
        self.tabBar.unselectedItemTintColor = AppColor.tabUnselectTintColor
        
        if let tabBarItems = tabBar.items{
            for index in 0..<tabBarItems.count {
                
                tabBarItems[index].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColor.app_gradient_color1], for: .selected)
                tabBarItems[index].imageInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
                
                let image = images[index].withRenderingMode(.alwaysOriginal).withTintColor(AppColor.app_gradient_color1)
                
                tabBarItems[index].selectedImage = image
                tabBarItems[index].image = images[index]
                tabBarItems[index].title = titles[index]
            }
        }
    }
}


//MARK: - Tab Bar Delegate Method
extension TabBarVC: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool{
        return true
    }
    
    /*  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController){
     } */
}


//MARK: - Tab bar show hide
extension TabBarVC {
    
}
