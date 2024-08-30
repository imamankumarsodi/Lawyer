//
//  AppTourVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 14/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import paper_onboarding
class AppTourVC: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var buttonProceedRef: UIButton!
    @IBOutlet weak var tourCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var tourArray:[OnboardingItemInfo] = [OnboardingItemInfo(informationImage:#imageLiteral(resourceName: "first-screen"),
                                                                      title: ConstantTexts.ChooseLT,
                                                                      description: ConstantTexts.ChooseDecLT,
                                                                      pageIcon: #imageLiteral(resourceName: "one"),
                                                                      color: AppColor.bgColorOne,
                                                                      titleColor: AppColor.app_gradient_color1,
                                                                      descriptionColor: AppColor.darkGrayColor,
                                                                      titleFont: ConstantFonts.mainBottomButtonFont,
                                                                      descriptionFont: AppFont.Semibold.size(AppFontName.OpenSans, size: 16)),
                                                   OnboardingItemInfo(informationImage:#imageLiteral(resourceName: "second"),
                                                                      title: ConstantTexts.CompareLT,
                                                                      description: ConstantTexts.CompareDecLT,
                                                                      pageIcon: #imageLiteral(resourceName: "two"),
                                                                      color: AppColor.bgColorTwo,
                                                                      titleColor: AppColor.app_gradient_color1,
                                                                      descriptionColor: AppColor.darkGrayColor,
                                                                      titleFont: ConstantFonts.mainBottomButtonFont,
                                                                      descriptionFont: AppFont.Semibold.size(AppFontName.OpenSans, size: 16)),
                                                   OnboardingItemInfo(informationImage:#imageLiteral(resourceName: "three-1"),
                                                                      title: ConstantTexts.BookLT,
                                                                      description: "\(ConstantTexts.BookDec1LT) \(ConstantTexts.AppName) \(ConstantTexts.BookDec2LT)",
                                                                      pageIcon: #imageLiteral(resourceName: "three"),
                                                                      color: AppColor.bgColorThree,
                                                                      titleColor: AppColor.app_gradient_color1,
                                                                      descriptionColor: AppColor.darkGrayColor,
                                                                      titleFont: ConstantFonts.mainBottomButtonFont,
                                                                      descriptionFont: AppFont.Semibold.size(AppFontName.OpenSans, size: 16))]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initialSetup()
    }
    
    //TODO: Implementation viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navSetup()
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    //MARK: - Actions, Gestures, Selectors
    //TODO: Actions
    @IBAction func btnProceedTapped(_ sender: UIButton) {
        USER_DEFAULTS.set(true, forKey: ConstantTexts.tourOverUDK)
         super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
    }
    
    /*
     @IBAction func btnProceedTapped(_ sender: UIButton) {
     UIView.animate(withDuration: 0.1,
     animations: {
     self.customMethodManager?.provideShadowAndCornerRadius(self.buttonProceedRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
     self.buttonProceedRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
     },
     completion: { _ in
     UIView.animate(withDuration: 0.1) {
     self.customMethodManager?.provideShadowAndCornerRadius(self.buttonProceedRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
     self.buttonProceedRef.transform = CGAffineTransform.identity
     
     USER_DEFAULTS.set(true, forKey: ConstantTexts.tourOverUDK)
     super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
     }
     })
     
     }
     
     */
    
}
