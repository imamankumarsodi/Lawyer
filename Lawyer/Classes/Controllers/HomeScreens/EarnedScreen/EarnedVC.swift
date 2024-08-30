//
//  EarnedVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 17/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import ViewAnimator

class EarnedVC: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lblCorner: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var earnTableView: UITableView!
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var earnList:EarnDataListViewModel?
    internal var earnVM: EarnDataModeling?
    
    internal var offset:Int = 0
    internal var dataCount:Int = Int()
    internal var isPagination: Bool = Bool()
    
    
    //MARK: - Variables for animation
    // Combined animations example
    internal let errorView: ErrorView  = Bundle.main.loadNibNamed(ErrorView.className, owner: self, options: nil)?.first as! ErrorView
    internal let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.app_gradient_color1
        
        return refreshControl
    }()
    
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
    
    
    //MARK: - Actions, Gestures, Selectors
    //TODO: Selectors
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.isPagination = false
        self.offset = Int()
        self.getEarnsService(isRefresh:true)
        refreshControl.endRefreshing()
        
    }
    
    @objc func reloadApiData(_ notification:Notification) {
        // Do something now
        self.isPagination = false
        self.offset = Int()
        self.getEarnsService(isRefresh:true)
        //   NOTIFICATION_CENTER.removeObserver(self)
        
    }


    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
