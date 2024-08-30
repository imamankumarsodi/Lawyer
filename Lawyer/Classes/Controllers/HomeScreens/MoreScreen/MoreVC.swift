//
//  MoreVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import ViewAnimator
import Cosmos
class MoreVC: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tblMore: UITableView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var imgPopUP: UIImageView!
    @IBOutlet weak var lblPopUPInstruction: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var btnSubmitRef: UIButton!
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var categoryListVM:CategoryListViewModel?
    internal var moreVM: CategoryListModeling?
    
    
    // For Collection view
    internal let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
    
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initValues()
    }
    
    //TODO: Implementation viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navSetup()
    }
    
    //TODO: Implementation viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // animateView()
    }
    
    //TODO: Implementation viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        initalHideBlurView()
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
    
    @IBAction func hideRatingAction(_ sender: Any) {
        
        self.hideBlurView()
    }
    
    
    @IBAction func submitTapped(_ sender: Any) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.btnSubmitRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnSubmitRef.transform = CGAffineTransform.identity
                            //TODO: Temp code need to remove
                            self.hideSuccessfullyBlurView()
                        }
        })
    }
    
}
