//
//  ReferAndEarnRooViewController.swift
//  Lawyer
//
//  Created by Aman Kumar on 16/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class ReferAndEarnRooViewController: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentedChoice: UISegmentedControl!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        initValues()
        // Do any additional setup after loading the view.
        
    }
    
    //TODO: Implementation viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navSetup()
    }
    
    //TODO: Implementation viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    @IBAction func segmentChoiceTapped(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0{
            animateScrollViewHorizontally(destinationPoint: CGPoint(x: 0 * self.view.frame.width, y: 0), andScrollView: self.scrollView, andAnimationMargin: 0)
            
            
            
        }else{
            
            
            
            animateScrollViewHorizontally(destinationPoint: CGPoint(x: 1 * self.view.frame.width, y: 0), andScrollView: self.scrollView, andAnimationMargin: 0)
            
            NOTIFICATION_CENTER.post(name: NSNotification.Name(rawValue: ConstantTexts.hitEarnedService), object:nil)
            
        }
    }
    
    
}
