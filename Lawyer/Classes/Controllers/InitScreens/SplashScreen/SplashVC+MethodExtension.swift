//
//  SplashVC+MethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 18/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import Foundation

extension SplashVC{
    
    //TODO: Init values
    internal func initValues(){
        if soundManager == nil {
            soundManager = SoundClass.shared
        }
        
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        initialSetup()
        
    }
    
    
    //TODO: IntialSetup
    private func initialSetup(){
        self.view.backgroundColor = AppColor.whiteColor
        
       /* for family in UIFont.familyNames {
            print("\(family)")

            for name in UIFont.fontNames(forFamilyName: family) {
                print("\(name)")
            }
        }
        */
        runAnimationLogo()
    }
    
    
    //TODO: Run logo animation
    private func runAnimationLogo(){
        UIView.animate(withDuration: 0, delay: 0, options: [.curveEaseIn], animations: {
            // self.soundManager?.playSound("Judges_Gavel.mp3")
            self.logo_splash.alpha = 1
            self.logo_splash.transform = CGAffineTransform(scaleX: 1, y: 1)
            
        }) { (done) in
            if done{
                //Move Forward
                
                if (USER_DEFAULTS.value(forKey: ConstantTexts.tourOverUDK) as? Bool) != nil{
                    
                    if let isEmpty = self.customMethodManager?.entityIsEmpty(entity: "User_Data"){
                        if isEmpty{
                            super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                        }else{
                            
                            guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
                                print("No user found...")
                                return
                            }
                            
                            if user.type == "0"{
                                let vc = AppStoryboard.tabBarSB.instantiateViewController(withIdentifier: TabBarVC.className) as! TabBarVC
                                UIApplication.shared.windows.first?.rootViewController = vc
                                UIApplication.shared.windows.first?.makeKeyAndVisible()
                            }else{
                               // Lawyer wala flow
                            }
                            
                            
                            
                        }
                    }else{
                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                    }
                    
                    
                }else{
                    super.moveToNextViewCViaRoot(name: ConstantTexts.LaunchSBT, withIdentifier: AppTourVC.className)
                }
                
            }
        }
        
    }
    
    
}
