//
//  FilterPopup_VC.swift
//  Lawyer
//
//  Created by Aman Kumar on 06/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class FilterPopup_VC: SBaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var btnDismissRef: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var btnClearRef: UIButton!
    @IBOutlet weak var btnDoneRef: UIButton!
    @IBOutlet weak var filterTableView: UITableView!
    
    
    //MARK: - Variables
    
    
    internal var callBackFilter:((_ filters:[Filter],_ headerTitle:String)->())?
    internal var callBackClearFilter:((_ isClearActivate:Bool,_ headerTitle:String)->())?
    
    internal var index:Int = Int()
    internal var headerTitle:String = String()
    internal var searchActive:Bool = Bool()
    
    internal var validationMethodManager:ValidationProtocol?
    internal var customMethodManager:CustomMethodProtocol?
    internal var filterListVM:FilterListModeling?
    internal var filterList:Filter_List_ViewModel?
    
    internal var search_filterListVM:FilterListModeling?
    internal var search_filterList:Filter_List_ViewModel?
    
    internal var isClearActivated:Bool = Bool()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.app_gradient_color1
        return refreshControl
    }()
    
    
    //MARK: - View life cycle methods
    //TODO: Implementation viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        initValues()
    }
    
    
    /*  //TODO: Implementation viewDidAppear
     override func viewDidAppear(_ animated: Bool) {
     super.viewDidAppear(animated)
     
     animateView()
     } */
    
    
    //TODO: Implementation viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissKeyboard()
        self.callBackClearFilter?(self.isClearActivated, self.headerTitle)
    }
    
    
    //MARK: - Actions, Gestures, Selectors
    //TODO: Actions
    @IBAction func btnDismissTapped(_ sender: UIButton) {
        dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func btnApplyTapped(_ sender: UIButton) {
        dismissKeyboard()
        self.searchActive = false
        self.searchBar.text = ConstantTexts.empty
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        self.btnDoneRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnDoneRef.transform = CGAffineTransform.identity
                            
                            guard let count = self.filterList?.filters.count else{
                                print("No count found...")
                                return
                            }
                            
                            var isAnySelected = Bool()
                            for index in 0..<count{
                                if let isSelected = self.filterList?.filters[index].isSelected{
                                    if isSelected{
                                        isAnySelected = true
                                        break
                                    }
                                }
                                
                            }
                            
                            
                            if isAnySelected{
                                self.dismiss(animated: true) {
                                    var filters = [Filter]()
                                    
                                    for index in 0..<count{
                                        if let isSelected = self.filterList?.filters[index].isSelected{
                                            if isSelected{
                                                if let filterItem = self.filterList?.filters[index]{
                                                    filters.append(filterItem)
                                                    self.customMethodManager?.updateIsSelect(entity: self.headerTitle, primary_key: self.customMethodManager?.getTableAndKeys(entity: self.headerTitle) ?? String(), primary_value: filterItem.id, key: "is_selected", value: isSelected)
                                                }
                                            }
                                        }
                                    }
                                    
                                    self.callBackFilter?(filters, self.headerTitle)
                                }
                            }else{
                                
                                
                                self.customMethodManager?.showAlert(ConstantTexts.SelectFilterALERT, okButtonTitle: ConstantTexts.OkBT, target: self)
                            }
                            
                        }
        })
    }
    
    @IBAction func btnClearTapped(_ sender: UIButton) {
        dismissKeyboard()
        self.searchActive = false
        self.searchBar.text = ConstantTexts.empty
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        self.btnClearRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            
                            self.btnClearRef.transform = CGAffineTransform.identity
                            self.dismiss(animated: true, completion: nil)
                            
                          /*  self.customMethodManager?.showAlertWithCancel(title: ConstantTexts.AppName, message: ConstantTexts.ClearFiltersStateBT, btnOkTitle: ConstantTexts.OkBT, btnCancelTitle: ConstantTexts.CancelBT, callBack: { (status) in
                                if status{
                                    self.resetFilters(callBack: {
                                        self.isClearActivated = true
                                        self.filterTableView.reloadData()
                                    })
                                }else{
                                    print("Do nothing...")
                                }
                            }) */
                        }
        })
    }
    
    
    //TODO: Selectors
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //TODO: Selectors
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.searchBar.text = ConstantTexts.empty
        dismissKeyboard()
        refreshControl.endRefreshing()
    }
    
    
    
    @objc func btnSelectedCell(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        if self.searchActive{
            guard let item = self.search_filterList?.filterAtIndex(sender.tag) else {
                fatalError("No Filter found...")
            }
            item.filter.isSelected = !item.filter.isSelected
            /* let dbValue = self.getTableAndKeys(entity: self.headerTitle)
             
             self.customMethodManager?.updateIsSelect(entity: headerTitle, primary_key: dbValue, primary_value: item.filter.id, key: "is_selected", value: item.filter.isSelected) */
            
            if let cell = self.filterTableView.cellForRow(at: indexPath) as? FilterTableViewCellAndXib{
                cell.configure(with: item)
            }
        }else{
            guard let item = self.filterList?.filterAtIndex(sender.tag) else {
                fatalError("No Filter found...")
            }
            item.filter.isSelected = !item.filter.isSelected
            
            /*  let dbValue = self.getTableAndKeys(entity: self.headerTitle)
             
             self.customMethodManager?.updateIsSelect(entity: headerTitle, primary_key: dbValue, primary_value: item.filter.id, key: "is_selected", value: item.filter.isSelected) */
            
            if let cell = self.filterTableView.cellForRow(at: indexPath) as? FilterTableViewCellAndXib{
                cell.configure(with: item)
            }
        }
        
        
    }
    
}
