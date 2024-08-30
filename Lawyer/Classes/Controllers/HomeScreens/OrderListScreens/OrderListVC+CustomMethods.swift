//
//  OrderListVC+CustomMethods.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import ViewAnimator
extension OrderListVC{
    
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.OrdersHT, leftBarButtonsType: [.empty], rightBarButtonsType: [])
        
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if customMethodManager == nil {
            customMethodManager = CustomMethodClass.shared
        }
        
        if self.orderListVM == nil {
            self.orderListVM = OrderList_VM.shared
        }
        
        if self.orderList == nil {
            self.orderList = orderListVM?.initDataSource()
        }
        
       
        initialSetup()
        
        
    }
    
    //TODO: Intial setup implementation
    internal func initialSetup(){
        NOTIFICATION_CENTER.addObserver(self, selector: #selector(reloadApiData(_:)), name: NSNotification.Name(rawValue: ConstantTexts.hitOrderService), object: nil)
        
        self.orderListTableView.separatorStyle = .none
        self.orderListTableView.hideEmptyCells()
        self.orderListTableView.isScrollEnabled = true
        self.orderListTableView.backgroundColor = AppColor.whiteColor
        self.orderListTableView.addSubview(self.refreshControl)
        self.orderListTableView.dataSource = self
        self.orderListTableView.delegate = self
        DispatchQueue.main.async {
            self.orderListTableView.reloadData()
        }
        
        recheckDataModels()
        
    }
    
    //TODO: Recheck data models implenemtation
    private func recheckDataModels(){
        registerNib()
        
        
        /* DispatchQueue.main.asyncAfter(deadline: .now()) {
         self.lawyerTableView.isHidden = false
         
         self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 260,duration: self.animationDuration, delay: self.delay)
         
         self.lawyerTableView.reloadData()
         } */
        
        
    }
    
    //TODO: register nib file
    private func registerNib(){
        /* For Tableview
         self.categoryTableView.register(nib: LawyerTableViewCell.className)
         
         DispatchQueue.main.asyncAfter(deadline: .now()) {
         self.categoryTableView.isHidden = false
         
         self.currentTableAnimation =  TableAnimation.fadeIn(duration: self.animationDuration, delay: self.delay)
         
         /* self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 60,duration: self.animationDuration, delay: self.delay) */
         
         self.categoryTableView.reloadData()
         } */
        
        
        self.orderListTableView.register(nib: OrderTableViewCell.className)
        self.getCustomersOrdersService(isRefresh: Bool())

    }
    
    
    //TODO: Animate rotate collection view
    internal func animateView(){
        UIView.animate(views: orderListTableView.visibleCells,
                       animations: [fromAnimation], delay: 0.5)
    }
    
    
    
    
    
    
    
    //MARK: - Web services methods
    //TODO: Get customer's orders web service
    internal func  getCustomersOrdersService(isRefresh:Bool){
        
        
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        print(header)
        
        
        self.customMethodManager?.startLoader(view:self.view)
        
        DispatchQueue.main.async {
            if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.orderListTableView, childView: self.errorView){
                if isAddedSubview{
                    self.customMethodManager?.removeSubView(childView: self.errorView)
                }
            }
        }
        
        ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.get_customer_orders_V2)\(self.offset)", method: .get, parameters: nil, header: header, success: { (result) in
            print(result)
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            
                            print(data)
                          /*  DispatchQueue.main.async {
                                if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.orderListTableView, childView: self.errorView){
                                    if isAddedSubview{
                                        self.customMethodManager?.removeSubView(childView: self.errorView)
                                    }
                                }
                            } */
                            
                            if let count = data.value(forKey: "count") as? Int{
                                self.dataCount = count
                            }
                            
                            if let count = data.value(forKey: "count") as? String{
                                self.dataCount = Int(count) ?? 0
                            }
                            
                            if let order = data.value(forKey: "order") as? NSArray{
                                //For table refresh
                                if isRefresh{
                                    /*  self.resetFilters() */
                                    if let count = self.orderList?.orders.count{
                                        if count > 0{
                                            self.orderList?.orders.removeAll()
                                        }
                                    }
                                }
                                
                                
                                //For checking pagination and append data
                                if let count = self.orderList?.orders.count{
                                    if count == 0{
                                        
                                        self.isPagination = false
                                        if let orders = self.orderListVM?.prepareDataSource(dataArray: order).orders{
                                            self.orderList?.orders.append(contentsOf: orders)
                                        }
                                    }else{
                                        if count >= self.dataCount{
                                            self.isPagination = true
                                            
                                        }else{
                                            
                                            self.isPagination = false
                                            if let orders = self.orderListVM?.prepareDataSource(dataArray: order).orders{
                                                self.orderList?.orders.append(contentsOf: orders)
                                            }
                                        }
                                        
                                    }
                                }
                                
                                
                                //For checking pagination...
                                if let count = self.orderList?.orders.count{
                                    self.offset = count
                                    
                                    if count == 0{
                                        self.isPagination = false
                                        
                                        DispatchQueue.main.async {
                                            if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.orderListTableView, childView: self.errorView){
                                                if isAddedSubview{
                                                    
                                                }else{
                                                    self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.NoOrdersFoundALERT, callback: {
                                                        self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.EmptyBoxNew, .loop)
                                                    })
                                                    
                                                    self.customMethodManager?.addSubView(parentView: self.orderListTableView, childView: self.errorView)
                                                }
                                            }
                                        }
                                        
                                        
                                    }else{
                                        if count >= self.dataCount{
                                            self.isPagination = true
                                            
                                        }else{
                                            self.isPagination = false
                                        }
                                    }
                                }
                                
                                
                                
                            }
                            
                        }
                        
                        // self.animateView()
                        DispatchQueue.main.async {
                            self.orderListTableView.reloadData()
                        }
                        
                        
                    }else{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)

                        }
                        
                    }
                }
            }
            
            
        }) { (error) in
            print(error)
            
            if let count = self.orderList?.orders.count{
                if count > 0{
                    self.orderList?.orders.removeAll()
                }
            }
            
            DispatchQueue.main.async {
                self.orderListTableView.reloadData()
            }
            
            self.customMethodManager?.stopLoader(view:self.view)
            if let _ = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                
                let errorCode = (error as NSError).code
                if let animationDetail = self.customMethodManager?.getAnimationNameAndMessage(errorCode: errorCode){
                    DispatchQueue.main.async {
                        if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.orderListTableView, childView: self.errorView){
                            if isAddedSubview{
                                
                                self.customMethodManager?.setupError(chidView: self.errorView, message: animationDetail.1,callback: {
                                    self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, animationDetail.0, .loop)
                                })
                                
                            }else{
                                self.customMethodManager?.setupError(chidView: self.errorView, message: animationDetail.1,callback: {
                                    self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, animationDetail.0, .loop)
                                })
                                
                                self.customMethodManager?.addSubView(parentView: self.orderListTableView, childView: self.errorView)
                            }
                        }
                    }
                    
                    
                }
                
            }else{
                DispatchQueue.main.async {
                    if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.orderListTableView, childView: self.errorView){
                        if isAddedSubview{
                            
                            self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.errorMessage, callback: {
                                self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.SomeThingWentWrong, .loop)
                            })
                            
                        }else{
                            self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.errorMessage, callback: {
                                self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.SomeThingWentWrong, .loop)
                            })
                            
                            self.customMethodManager?.addSubView(parentView: self.orderListTableView, childView: self.errorView)
                        }
                    }
                }
            }
        }
    }
    
    
    
}
