//
//  OrderAndQueryRootViewController+CustomMethod.swift
//  Lawyer
//
//  Created by Aman Kumar on 12/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension OrderAndQueryRootViewController{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = false
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.OrdersHT, leftBarButtonsType: [.empty], rightBarButtonsType: [])
        
        SCREEN_NAME = ConstantTexts.OrdersHT
        
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        self.segmentedChoice.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppColor.whiteColor], for: .selected)
        self.segmentedChoice.selectedSegmentTintColor = AppColor.app_gradient_color2
        self.segmentedChoice.setTitle(ConstantTexts.OrdersHT, forSegmentAt: 0)
        self.segmentedChoice.setTitle(ConstantTexts.QuerisHT, forSegmentAt: 1)
        
        
        self.initialSetup()
    }
    
    //TODO: Initial setup
    private func initialSetup(){
        self.setupScrollView()
    }
    
    
    //MARK: - Methods for UIScrollView
    //TODO: Scroll setup
    private func setupScrollView(){
        
     
        
       
        self.scrollView.frame = CGRect(x: 0, y: 0, width: self.scrollViewBG.frame.size.width, height: self.scrollViewBG.frame.size.height)

        
        self.scrollView.contentSize = CGSize(width: 2 * self.scrollViewBG.frame.width, height: self.scrollViewBG.frame.height)
        
      
        self.scrollView.automaticallyAdjustsScrollIndicatorInsets = false
        
        self.scrollView.delegate = self
        
        let orderListVC = AppStoryboard.homeSB.instantiateViewController(withIdentifier: OrderListVC.className) as! OrderListVC
        let queryListVC  = AppStoryboard.homeSB.instantiateViewController(withIdentifier: QueryListVC.className) as! QueryListVC
        
        self.addChild(orderListVC)
        self.addChild(queryListVC)
        self.loadScrollView()
        
        
        
    }
    
    
    //TODO: loadScrollView method
    private func loadScrollView()
    {
        print(self.children)
        for index in 0 ..< self.children.count
        {
            self.loadScrollViewWithPage(index);
        }
        
        NOTIFICATION_CENTER.addObserver(self, selector: #selector(reloadApiData(_:)), name: NSNotification.Name(rawValue: ConstantTexts.changeToQuery), object: nil)
        
    }
    
    
    //TODO: loadScrollViewWithPage method
    private func loadScrollViewWithPage(_ page : Int) -> Void
    {
        if(page < 0)
        {
            return
        }
        if page >= self.children.count
        {
            return
        }
        let viewController: UIViewController? = (self.children as NSArray).object(at: page) as? UIViewController
        if(viewController == nil)
        {
            return
        }
        if(viewController?.view.superview == nil){
            
            var frame: CGRect  = self.scrollView.frame
            frame.origin.x = self.view.frame.width*CGFloat(page)
            frame.origin.y = 0;
            viewController?.view.frame = frame;
            self.scrollView.addSubview(viewController!.view);
        }
        
        
      //  animateScrollViewHorizontally(destinationPoint: CGPoint(x: 0 * self.view.frame.width, y: 0), andScrollView: self.scrollView, andAnimationMargin: 0)
    }
    
    
    //TODO: animateScrollViewHorizontally method
    internal func animateScrollViewHorizontally(destinationPoint destination: CGPoint, andScrollView scrollView: UIScrollView, andAnimationMargin margin: CGFloat)
    {
        
        var change: Int = 0;
        let diffx: CGFloat = destination.x - scrollView.contentOffset.x;
        var _: CGFloat = destination.y - scrollView.contentOffset.y;
        
        if(diffx < 0) {
            
            change = 1
        }
        else {
            
            change = 2
            
        }
        
        
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3);
        UIView.setAnimationCurve(.easeIn);
        switch (change) {
            
        case 1:
            scrollView.contentOffset = CGPoint(x: destination.x - margin, y: destination.y);
        case 2:
            scrollView.contentOffset = CGPoint(x: destination.x + margin, y: destination.y);
        default:
            return;
        }
        
        UIView.commitAnimations();
        
        let firstDelay: Double  = 0.3;
        let startTime: DispatchTime = DispatchTime.now() + Double(Int64(firstDelay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        
        DispatchQueue.main.asyncAfter(deadline: startTime, execute: {
            
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationDuration(0.2);
            UIView.setAnimationCurve(.linear);
            switch (change) {
                
            case 1:
                scrollView.contentOffset = CGPoint(x: destination.x + margin, y: destination.y);
            case 2:
                scrollView.contentOffset = CGPoint(x: destination.x - margin, y: destination.y);
            default:
                return;
            }
            
            UIView.commitAnimations();
            let secondDelay: Double  = 0.2;
            let startTimeSecond: DispatchTime = DispatchTime.now() + Double(Int64(secondDelay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
            DispatchQueue.main.asyncAfter(deadline: startTimeSecond, execute: {
                
                UIView.beginAnimations(nil, context: nil)
                UIView.setAnimationDuration(0.1);
                UIView.setAnimationCurve(.easeInOut);
                scrollView.contentOffset = CGPoint(x: destination.x, y: destination.y);
                UIView.commitAnimations();
                
            })
        })
    }
    
    
}
