//
//  SceneDelegate+MessagingDelegates.swift
//  Lawyer
//
//  Created by Aman Kumar on 05/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import Firebase
import UserNotifications
import Firebase
import FirebaseCore
import FirebaseMessaging
import FirebaseAnalytics
import FirebaseCrashlytics

//MARK: - Extension for get Device token
extension SceneDelegate:UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("in did recieve")
        
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        
        if let userInfo = response.notification.request.content.userInfo as? NSDictionary{
            print(userInfo)
            
            if (USER_DEFAULTS.value(forKey: ConstantTexts.tourOverUDK) as? Bool) != nil{
                
                if let isEmpty = self.customMethodManager?.entityIsEmpty(entity: "User_Data"){
                    if isEmpty{
                        
                        let viewController = AppStoryboard.authSB.instantiateViewController(withIdentifier: LoginVC.className)
                        let navigationController = UINavigationController(rootViewController: viewController)
                        navigationController.navigationBar.isHidden = false
                        self.window?.rootViewController = navigationController
                        
                        
                    }else{
                        
                        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
                            print("No user found...")
                            return
                        }
                        
                        if user.type == "0"{
                            
                            if let type = userInfo.value(forKey: "type") as? String{
                                if type == "Order"{
                                    
                                    if let OrderId = userInfo.value(forKey: "OrderId") as? String{
                                        let order: OrderDataModel = OrderDataModel(BookingDate: String(), BookingTime: String(), CategoryName: String(), CategoryId: String(), CityName: String(), CustomerEmail: String(), CustomerName: String(), CustomerPhone: String(), Id: OrderId, Query: String(), Status: String())
                                        
                                        let viewController = AppStoryboard.homeSB.instantiateViewController(withIdentifier: OrderStatusVC.className) as! OrderStatusVC
                                        viewController.order = OrderDataViewModel(order)
                                        let navigationController = UINavigationController(rootViewController: viewController)
                                        navigationController.navigationBar.isHidden = false
                                        self.window?.rootViewController = navigationController
                                    }
                                    
                                }else{
                                    
                                    
                                    
                                    let vc = AppStoryboard.tabBarSB.instantiateViewController(withIdentifier: TabBarVC.className) as! TabBarVC
                                    vc.selectedIndex = 1
                                    UIApplication.shared.windows.first?.rootViewController = vc
                                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                                    
                                    NOTIFICATION_CENTER.post(name: NSNotification.Name(rawValue: ConstantTexts.changeToQuery), object:nil)
                                    
                                }
                                
                            }
                            
                        }
                    }
                }else{
                    
                    let viewController = AppStoryboard.authSB.instantiateViewController(withIdentifier: LoginVC.className)
                    let navigationController = UINavigationController(rootViewController: viewController)
                    navigationController.navigationBar.isHidden = false
                    self.window?.rootViewController = navigationController
                    
                }
                
                
            }else{
                
                let viewController = AppStoryboard.launchSB.instantiateViewController(withIdentifier: AppTourVC.className)
                let navigationController = UINavigationController(rootViewController: viewController)
                navigationController.navigationBar.isHidden = false
                self.window?.rootViewController = navigationController
            }
            
            
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("in will present")
        
        
        if let userInfo = notification.request.content.userInfo as? NSDictionary{
            print(userInfo)
            
            if let type = userInfo.value(forKey: "type") as? String{
                
                if SCREEN_NAME == ConstantTexts.OrdersStatusHT{
                    if type == "Order"{
                        NOTIFICATION_CENTER.post(name: NSNotification.Name(rawValue: ConstantTexts.hitOrderStatusService), object:nil)
                        
                    }else{
                        completionHandler([.alert, .badge, .sound])
                    }
                }else if SCREEN_NAME == ConstantTexts.OrdersHT{
                    if type == "Order"{
                        
                        NOTIFICATION_CENTER.post(name: NSNotification.Name(rawValue: ConstantTexts.hitOrderService), object:nil)
                        
                    }else{
                        completionHandler([.alert, .badge, .sound])
                    }
                    
                }else if SCREEN_NAME == ConstantTexts.QuerisHT{
                    if type != "Order"{
                        NOTIFICATION_CENTER.post(name: NSNotification.Name(rawValue: ConstantTexts.hitQueryService), object:nil)
                        
                    }else{
                        completionHandler([.alert, .badge, .sound])
                    }
                }else{
                    completionHandler([.alert, .badge, .sound])
                }
                
                
                
            }
            
            
            
            
            
        }
        
        
    }
    
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    
    
    //MARK:- DEVICE TOKEN GET HERE
    //MARK:
    internal func registerForRemoteNotification() {
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
            if error == nil{
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }else{
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.sound, .alert, .badge], categories: nil))
                UIApplication.shared.registerForRemoteNotifications()
            }
        }
        
    }
    
}



