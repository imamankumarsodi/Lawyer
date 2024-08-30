//
//  QueryListVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 12/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import ViewAnimator

class QueryListVC: SBaseViewController {
    
    
    //MARK: - IBOutlets
      @IBOutlet weak var orderListTableView: UITableView!
    
    //MARK: - Variables
    
    internal var queryList:QueryDataViewNewListModel?
     internal var queryVM: QueryDataViewNewModeling?
    
    
  /*  internal var faqView: FAQView!
    internal var faqVM: FAQ_DataModeling?
    internal var faqList: [FAQItem] = [FAQItem]() */
    
    
    internal var customMethodManager:CustomMethodProtocol?
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
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SCREEN_NAME = ConstantTexts.empty
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
    //TODO: Selectors
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.isPagination = false
        self.offset = Int()
        self.getQuerisLisService(isRefresh: true)
        refreshControl.endRefreshing()
        
    }
    
    
    @objc func reloadApiData(_ notification:Notification) {
        // Do something now
        self.isPagination = false
        self.offset = Int()
        self.getQuerisLisService(isRefresh: true)
        //   NOTIFICATION_CENTER.removeObserver(self)
        
    }
    
    
    
    
    
    
  /*  @objc func btnExpendTapped(_ sender: UIButton) {
        
        if let orders = self.queryList?.queries{
            for index in 0..<orders.count{
                if index == sender.tag{
                    orders[index].isOpen = !orders[index].isOpen
                }else{
                    orders[index].isOpen = Bool()
                }
            }
        }
        
        DispatchQueue.main.async {
            self.orderListTableView.reloadData()
        }
        
    } */
    
}
