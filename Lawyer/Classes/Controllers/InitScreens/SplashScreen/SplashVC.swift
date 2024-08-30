//
//  SplashVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 18/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import AVFoundation
class SplashVC: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var logo_splash: UIImageView!
    //MARK: - Variables
    internal var soundManager:SoundProtocol?
    internal var customMethodManager:CustomMethodProtocol?
    
    
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initValues()
    }
   
    
}
