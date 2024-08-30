//
//  QueryListVC+CustomMethods.swift
//  Lawyer
//
//  Created by Aman Kumar on 12/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
extension QueryListVC{
   
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = false
        SCREEN_NAME = ConstantTexts.QuerisHT
    }
    
    //TODO: Init values
    internal func initValues(){
        
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        
      /*  if faqVM == nil {
            faqVM = FAQ_VM.shared
        } */
        
        
        
      if self.queryVM == nil {
            self.queryVM = QueryListVM.shared
        }
        
        if self.queryList == nil {
            self.queryList = queryVM?.initDataSource()
        }
        
        
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
         
        
        initialSetup()
        
    }
 
    
    //TODO: Animate rotate collection view
  /*  internal func animateView(){
        UIView.animate(views: orderListTableView.visibleCells,
                       animations: [fromAnimation], delay: 0.5)
    } */
    
    
    
    
    
    //TODO: Intial setup implementation
    private func initialSetup(){
        NOTIFICATION_CENTER.addObserver(self, selector: #selector(reloadApiData(_:)), name: NSNotification.Name(rawValue: ConstantTexts.hitQueryService), object: nil)
      
        self.view.backgroundColor = AppColor.tableBGColor
        recheckDataModels()
    }
    
    
    
    
    //TODO: Recheck data models implenemtation
    private func recheckDataModels(){
        registerNib()
       /* self.addFaqViewConstraints() */
        
        /* DispatchQueue.main.asyncAfter(deadline: .now()) {
         self.lawyerTableView.isHidden = false
         
         self.currentTableAnimation = TableAnimation.moveUpWithFade(rowHeight: 260,duration: self.animationDuration, delay: self.delay)
         
         self.lawyerTableView.reloadData()
         } */
        
        self.getQuerisLisService(isRefresh:Bool())
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
        
        
        self.orderListTableView.register(nib: QueryTableViewCellAndXib.className)

    }
    
    
  /*  private func addFaqViewConstraints() {
        
        if let faqV = faqView{
            let faqViewTrailing = NSLayoutConstraint(item: faqV, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailingMargin, multiplier: 1, constant: 17)
            let faqViewLeading = NSLayoutConstraint(item: faqV, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leadingMargin, multiplier: 1, constant: -17)
            let faqViewTop = NSLayoutConstraint(item: faqV, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
            let faqViewBottom = NSLayoutConstraint(item: self.view ?? UIView(), attribute: .bottom, relatedBy: .equal, toItem: faqView, attribute: .bottom, multiplier: 1, constant: 0)
            
            NSLayoutConstraint.activate([faqViewTop, faqViewBottom, faqViewLeading, faqViewTrailing])
        }
        
        
    } */
    
    
    //MARK: - Web services methods
    //TODO: Get customer's orders web service
   /* internal func  getQuerisLisService(isRefresh:Bool){
        
        
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        
        self.customMethodManager?.startLoader(view:self.view)
        
        ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.query_list_V2)\(self.offset)", method: .get, parameters: nil, header: header, success: { (result) in
            print(result)
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            
                            print(data)
                            
                            DispatchQueue.main.async {
                                if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.orderListTableView, childView: self.errorView){
                                    if isAddedSubview{
                                        self.customMethodManager?.removeSubView(childView: self.errorView)
                                    }
                                }
                            }
                            
                            if let count = data.value(forKey: "count") as? Int{
                                self.dataCount = count
                            }
                            
                            if let count = data.value(forKey: "count") as? String{
                                self.dataCount = Int(count) ?? 0
                            }
                            
                              if let order = data.value(forKey: "data") as? NSArray{
                                //For table refresh
                                if isRefresh{
                                    /*  self.resetFilters() */
                                    if let count = self.queryList?.queries.count{
                                        if count > 0{
                                            self.queryList?.queries.removeAll()
                                        }
                                    }
                                }
                                
                                
                                //For checking pagination and append data
                                if let count = self.queryList?.queries.count{
                                    if count == 0{
                                        
                                        self.isPagination = false
                                        if let orders = self.queryVM?.prepareDataSource(data: order).queries{
                                            self.queryList?.queries.append(contentsOf: orders)
                                        }
                                        
                                        
                                    }else{
                                        if count >= self.dataCount{
                                            self.isPagination = true
                                            
                                        }else{
                                            
                                            self.isPagination = false
                                            if let orders = self.queryVM?.prepareDataSource(data: order).queries{
                                                self.queryList?.queries.append(contentsOf: orders)
                                            }
                                        }
                                        
                                    }
                                }
                                
                                
                                //For checking pagination...
                                if let count = self.queryList?.queries.count{
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
                        
                        
                        print("aman",self.queryList?.queries.count)
                        // self.animateView()
                        DispatchQueue.main.async {
                            self.orderListTableView.reloadData()
                        }
                        
                        
                    }else{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: message, style:.error)
                        }
                        
                    }
                }
            }
            
            
        }) { (error) in
            print(error)
            
            if let count = self.queryList?.queries.count{
                if count > 0{
                    self.queryList?.queries.removeAll()
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
    } */
    
//MARK: - Web services methods
//TODO: Get customer's orders web service
/* internal func  getQuerisLisService(isRefresh:Bool){
    
    
    guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
        print("No user found...")
        return
    }
    
    let header = ["authorization":user.token,
                  "Content-Type":"application/json",
                  "accept":"application/json"]
    
    
    DispatchQueue.main.async {
                self.customMethodManager?.removeSubView(childView: self.errorView)
    }
    self.customMethodManager?.startLoader(view:self.view)
    
    ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.query_list_V2)\(self.offset)", method: .get, parameters: nil, header: header, success: { (result) in
        print(result)
        self.customMethodManager?.stopLoader(view:self.view)
        if let result_Dict = result as? NSDictionary{
            if let code = result_Dict.value(forKey: "code") as? Int{
                if code == 200{
                    
                    if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                        
                        print(data)
                        
                     /*   if self.faqView != nil{
                            DispatchQueue.main.async {
                                        self.customMethodManager?.removeSubView(childView: self.errorView)
                            }
                        }
                       */
                        
                        
                        
                        
                       
                        if self.faqList.count > 0{
                            self.faqList.removeAll()
                        }
                        
                        
                        
                        if let count = data.value(forKey: "count") as? Int{
                            self.dataCount = count
                        }
                        
                        if let count = data.value(forKey: "count") as? String{
                            self.dataCount = Int(count) ?? 0
                        }
                        
                          if let order = data.value(forKey: "data") as? NSArray{
                            //For table refresh
                            if isRefresh{
                                    if self.faqList.count > 0{
                                        self.faqList.removeAll()
                                    }
                                
                            }
                            
                            
                            //For checking pagination and append data
                            
                                if self.faqList.count == 0{
                                    
                                    self.isPagination = false
                                    
                                    if let orders = self.faqVM?.prepareDataSourceWith(json: order){
                                        self.faqList.append(contentsOf: orders)
                                         if self.faqView != nil{
                                            
                                            
                                            DispatchQueue.main.async {
                                                if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.view, childView: self.faqView){
                                                    if isAddedSubview{
                                                        print("Do nothing")
                                                        self.customMethodManager?.removeSubView(childView: self.faqView)
                                                        self.faqView = FAQView(frame: self.view.frame, items: self.faqList)
                                                        self.faqView.translatesAutoresizingMaskIntoConstraints = false
                                                        self.view.addSubview(self.faqView)
                                                        self.addFaqViewConstraints()
                                                        self.faqView.tableView.backgroundColor = AppColor.tableBGColor
                                                        self.faqView.tableView.addSubview(self.refreshControl)
                                                        self.faqView.tableView.delegate = self
                                                        
                                                        self.faqView.tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
                                                        self.faqView.tableView.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
                                                        
                                                        self.faqView.tableView.sectionHeaderHeight = 5.0;
                                                        self.faqView.tableView.sectionFooterHeight = 5.0;
                                                        
                                                        self.faqView.tableView.separatorStyle = .none
                                                        self.faqView.tableView.hideEmptyCells()
                                                        self.faqView.tableView.isHidden = false
                                                        self.faqView.tableView.isScrollEnabled = true
                                                        
                                                        self.faqView.tableView.delegate = self
                                                        
                                                    }
                                                }
                                            }

                                            
                                            
                                        }else{
                                            self.faqView = FAQView(frame: self.view.frame, items: self.faqList)
                                            self.faqView.translatesAutoresizingMaskIntoConstraints = false
                                            self.view.addSubview(self.faqView)
                                            self.addFaqViewConstraints()
                                            self.faqView.tableView.backgroundColor = AppColor.tableBGColor
                                            self.faqView.tableView.addSubview(self.refreshControl)
                                            self.faqView.tableView.delegate = self
                                            
                                            self.faqView.tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
                                            self.faqView.tableView.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
                                            
                                            self.faqView.tableView.sectionHeaderHeight = 5.0;
                                            self.faqView.tableView.sectionFooterHeight = 5.0;
                                            
                                            self.faqView.tableView.separatorStyle = .none
                                            self.faqView.tableView.hideEmptyCells()
                                            self.faqView.tableView.isHidden = false
                                            self.faqView.tableView.isScrollEnabled = true
                                            
                                            self.faqView.tableView.delegate = self
                                            
                                        }
 
                                    }
                                    
                                }else{
                                    if self.faqList.count >= self.dataCount{
                                        self.isPagination = true
                                        
                                    }else{
                                        
                                        self.isPagination = false
                                        if let orders = self.faqVM?.prepareDataSourceWith(json: order){
                                            self.faqList.append(contentsOf: orders)
                                            if self.faqView != nil{
                                                DispatchQueue.main.async {
                                                    if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.view, childView: self.faqView){
                                                        if isAddedSubview{
                                                            print("Do nothing...")
                                                            self.customMethodManager?.removeSubView(childView: self.faqView)
                                                            self.faqView = FAQView(frame: self.view.frame, items: self.faqList)
                                                            self.faqView.translatesAutoresizingMaskIntoConstraints = false
                                                            self.view.addSubview(self.faqView)
                                                            self.addFaqViewConstraints()
                                                            self.faqView.tableView.backgroundColor = AppColor.tableBGColor
                                                            self.faqView.tableView.addSubview(self.refreshControl)
                                                            self.faqView.tableView.delegate = self
                                                            
                                                            self.faqView.tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
                                                            self.faqView.tableView.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
                                                            
                                                            self.faqView.tableView.sectionHeaderHeight = 5.0;
                                                            self.faqView.tableView.sectionFooterHeight = 5.0;
                                                            
                                                            self.faqView.tableView.separatorStyle = .none
                                                            self.faqView.tableView.hideEmptyCells()
                                                            self.faqView.tableView.isHidden = false
                                                            self.faqView.tableView.isScrollEnabled = true
                                                            
                                                            self.faqView.tableView.delegate = self
                                                            
                                                            
                                                        }
                                                    }
                                                }
                                                
                                            }else{
                                                self.faqView = FAQView(frame: self.view.frame, items: self.faqList)
                                                self.faqView.translatesAutoresizingMaskIntoConstraints = false
                                                self.view.addSubview(self.faqView)
                                                self.addFaqViewConstraints()
                                                self.faqView.tableView.backgroundColor = AppColor.tableBGColor
                                                self.faqView.tableView.addSubview(self.refreshControl)
                                                self.faqView.tableView.delegate = self
                                                
                                                
                                                self.faqView.tableView.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
                                                self.faqView.tableView.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
                                                
                                                self.faqView.tableView.sectionHeaderHeight = 5.0;
                                                self.faqView.tableView.sectionFooterHeight = 5.0;
                                                
                                                self.faqView.tableView.separatorStyle = .none
                                                self.faqView.tableView.hideEmptyCells()
                                                self.faqView.tableView.isHidden = false
                                                self.faqView.tableView.isScrollEnabled = true
                                            }

                                        }
                                    }
                                    
                                }
                            
                            
                            
                            //For checking pagination...
                            if let count = self.faqList.count as? Int{
                                self.offset = count
                                
                                if count == 0{
                                    self.isPagination = false
                                    
                                    if self.faqView != nil{
                                        DispatchQueue.main.async {
                                            if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.faqView, childView: self.errorView){
                                                if isAddedSubview{
                                                    
                                                }else{
                                                    
                                                    DispatchQueue.main.async {
                                                                self.customMethodManager?.removeSubView(childView: self.errorView)
                                                    }
                                                    
                                                    self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.NoOrdersFoundALERT, callback: {
                                                        self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.EmptyBoxNew, .loop)
                                                    })
                                                    
                                                    self.customMethodManager?.addSubView(parentView: self.faqView, childView: self.errorView)
                                                }
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
                    
                    DispatchQueue.main.async {
                        self.faqView.tableView.reloadData()
                    }
                    
                    print("aman",self.faqList.count)
                    
                   
                }else{
                    if let message = result_Dict.value(forKey: "message") as? String{
                        self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                    }
                    
                }
            }
        }
        
        
    }) { (error) in
        print(error)
        
        if let count = self.faqList.count as? Int{
            if count > 0{
                self.faqList.removeAll()
                self.faqView.tableView.reloadData()
            }
        }
       
        self.customMethodManager?.stopLoader(view:self.view)
        if let _ = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
            
            let errorCode = (error as NSError).code
            if let animationDetail = self.customMethodManager?.getAnimationNameAndMessage(errorCode: errorCode){
                
                
                
                if self.faqView != nil{
                    DispatchQueue.main.async {
                        if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.faqView, childView: self.errorView){
                            if isAddedSubview{
                                
                                self.customMethodManager?.setupError(chidView: self.errorView, message: animationDetail.1,callback: {
                                    self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, animationDetail.0, .loop)
                                })
                            }else{
                                
                                DispatchQueue.main.async {
                                            self.customMethodManager?.removeSubView(childView: self.errorView)
                                }
                                
                                self.customMethodManager?.setupError(chidView: self.errorView, message: animationDetail.1,callback: {
                                    self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, animationDetail.0, .loop)
                                })

                                
                                self.customMethodManager?.addSubView(parentView: self.faqView, childView: self.errorView)
                            }
                        }
                    }
                }
   
            }
            
        }else{
            
            if self.faqView != nil{
                
              
                    DispatchQueue.main.async {
                        if let isAddedSubview = self.customMethodManager?.isSubviewAdded(parentView: self.faqView, childView: self.errorView){
                            if isAddedSubview{
                                
                                self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.errorMessage, callback: {
                                    self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.SomeThingWentWrong, .loop)
                                })
                            }else{
                                
                                DispatchQueue.main.async {
                                            self.customMethodManager?.removeSubView(childView: self.errorView)
                                }
                                
                                self.customMethodManager?.setupError(chidView: self.errorView, message: ConstantTexts.errorMessage, callback: {
                                    self.self.customMethodManager?.showLottieAnimation(self.errorView.viewLottie, ConstantTexts.SomeThingWentWrong, .loop)
                                })
                                
                                self.customMethodManager?.addSubView(parentView: self.faqView, childView: self.errorView)
                                
                            }
                        }
                    }
                
            }
            
        }
    }
}
    
*/
    
    
 
    
    
    //TODO: Get customer's orders web service
    internal func  getQuerisLisService(isRefresh:Bool){
        
        
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
        
        ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.query_list_V2)\(self.offset)", method: .get, parameters: nil, header: header, success: { (result) in
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
                            
                            if let order = data.value(forKey: "data") as? NSArray{
                                //For table refresh
                                if isRefresh{
                                    /*  self.resetFilters() */
                                    if let count = self.queryList?.queries.count{
                                        if count > 0{
                                            self.queryList?.queries.removeAll()
                                        }
                                    }
                                }
                                
                                
                                //For checking pagination and append data
                                if let count = self.queryList?.queries.count{
                                    if count == 0{
                                        
                                        self.isPagination = false
                                        if let orders = self.queryVM?.prepareDataSource(data: order).queries{
                                            self.queryList?.queries.append(contentsOf: orders)
                                        }
                                    }else{
                                        if count >= self.dataCount{
                                            self.isPagination = true
                                            
                                        }else{
                                            
                                            self.isPagination = false
                                            if let orders = self.queryVM?.prepareDataSource(data: order).queries{
                                                self.queryList?.queries.append(contentsOf: orders)
                                            }
                                        }
                                        
                                    }
                                }
                                
                                
                                //For checking pagination...
                                if let count = self.queryList?.queries.count{
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
            
            if let count = self.queryList?.queries.count{
                if count > 0{
                    self.queryList?.queries.removeAll()
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
