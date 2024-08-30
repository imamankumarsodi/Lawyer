//
//  HomeVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 21/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import DropDown
import ViewAnimator
class HomeVC: SBaseViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var viewLocationBackground: UIView!
    @IBOutlet weak var imageViewLoction: UIImageView!
    @IBOutlet weak var labelLoationTitle: UILabel!
    @IBOutlet weak var imageViewDropDown: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var viewHeaderBG: UIView!
    @IBOutlet weak var viewHeaderCityBG: UIView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblHeaderSelectLocationTitle: UILabel!
    @IBOutlet weak var NSLayoutConstraintHeaderHeight: NSLayoutConstraint!
    
    @IBOutlet weak var btnBackRef: UIButton!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var lblHeaderPopupTitle: UILabel!
    @IBOutlet weak var btnCancelRef: UIButton!
    @IBOutlet weak var btnOkRef: UIButton!
    
    /*
     For Collection view
     @IBOutlet weak var categoryCollectionView: UICollectionView! */
    
    // For Tableview
    @IBOutlet weak var categoryTableView: UITableView!
    
    //MARK: - Variables
    
    internal var isComingFromSendQuery:Bool = Bool()
    internal var sendBackSelectedCategory:((_ CategoryName:String,_ CategoryId:String)->())?
    
    internal var expertiseVM:CategoryListViewModel?
    internal var categoryListVM:CategoryListViewModel?
    
    internal var homeVM: CategoryListModeling?
    internal var customMethodManager:CustomMethodProtocol?
    internal var validationMethodManager:ValidationProtocol?

    internal let dropDown = DropDown()
    
    internal var cityNameArray = [String]()
    internal var cityIdArray = [String]()
    internal var cityId:String = String()
    internal var cityName:String = String()
    
    internal var searchActive:Bool = Bool()
    
    
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
    
    
    
    /*   //MARK: - variables for the animate tableview
     
     internal var animationName = String()
     
     /// an enum of type TableAnimation - determines the animation to be applied to the tableViewCells
     internal var currentTableAnimation: TableAnimation = .fadeIn(duration: 0.85, delay: 0.03) {
     didSet {
     self.animationName = currentTableAnimation.getTitle()
     }
     }
     internal var animationDuration: TimeInterval = 0.85
     internal var delay: TimeInterval = 0.05 */
    
    
    
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
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        super.isHiddenNavigationBar(false)
        self.initalHideBlurView()
        
    }
    
 
    //MARK: - Actions, Gestures, Selectors
    
    
    //TODO: Selectors
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.searchActive = Bool()
        self.searchBar.text = ConstantTexts.empty
        self.expertise_list()
        refreshControl.endRefreshing()
        
    }
    
    
    //TODO: Selectors
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @objc func btnSelectCellTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        let indexPath = IndexPath(row: sender.tag, section: 0)
                        if let cell = self.categoryTableView.cellForRow(at: indexPath) as? CategoryTableViewCellAndXib {
                            cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
                            cell.contentView.backgroundColor = AppColor.highLightColor
                        }
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.05) {
                            let indexPath = IndexPath(row: sender.tag, section: 0)
                            if let cell = self.categoryTableView.cellForRow(at: indexPath) as? CategoryTableViewCellAndXib {
                                cell.viewBG.transform = .identity
                                cell.contentView.backgroundColor = AppColor.clearColor
                                
                                
                                if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
                                    self.cityName = city
                                }else{
                                    self.cityName = String()
                                }
                                
                                
                                if self.cityName == String(){
                                    
                                    
                                 /*   self.customMethodManager?.showAlertWithCancel(title: ConstantTexts.AppName, message: ConstantTexts.SelectCityALERT, btnOkTitle: ConstantTexts.SelectCityBT, btnCancelTitle: ConstantTexts.CancelBT, callBack: { (status) in
                                          if status{
                                                self.searchActive = Bool()
                                                self.searchBar.text = ConstantTexts.empty
                                                let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: CityListViewController.className) as! CityListViewController
                                                vc.getCity = { item in
                                                    if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
                                                        self.cityName = city
                                                        self.lblHeaderSelectLocationTitle.text = self.cityName
                                                    }
                                                }
                                                self.navigationController?.pushViewController(vc, animated: true)
                                          }
                                      }) */
                                    
                                    self.showAlert()
                                   
                                }else{
                                    
                                    UIView.animate(views: self.categoryTableView.visibleCells,
                                                   animations: self.animations, reversed: true,
                                                   initialAlpha: 1.0,
                                                   finalAlpha: 0.0,
                                                   completion: {
                                                    self.animateView()
                                                    if self.isComingFromSendQuery{
                                                        var CategoryName:String = String()
                                                        var CategoryId:String = String()
                                                        if self.searchActive{
                                                            if let categoryVM = self.expertiseVM?.categoryAtIndex(indexPath.row){
                                                                
                                                                CategoryId = categoryVM.expertiseId
                                                                CategoryName = categoryVM.title
                                                               
                                                            }
                                                        }else{
                                                            if let categoryVM = self.categoryListVM?.categoryAtIndex(indexPath.row){
                                                                CategoryId = categoryVM.expertiseId
                                                                CategoryName = categoryVM.title
                                                                
                                                            }
                                                        }
                                                        
                                                        self.sendBackSelectedCategory!(CategoryName, CategoryId)
                                                        
                                                        self.navigationController?.popViewController(animated: true)
                                                    }else{
                                                        
                                                        
                                                        
                                                        let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: AppointmentVC.className) as! AppointmentVC
                                                        
                                                        if self.searchActive{
                                                            if let categoryVM = self.expertiseVM?.categoryAtIndex(indexPath.row){
                                                                vc.type = "0"
                                                                vc.expID = categoryVM.expertiseId
                                                                vc.expName = categoryVM.title
                                                                vc.cityName = self.cityName
                                                                
                                                            }
                                                        }else{
                                                            if let categoryVM = self.categoryListVM?.categoryAtIndex(indexPath.row){
                                                                vc.type = "0"
                                                                vc.expID = categoryVM.expertiseId
                                                                vc.expName = categoryVM.title
                                                                vc.cityName = self.cityName
                                                                
                                                            }
                                                        }

                                                        self.navigationController?.pushViewController(vc, animated: true)
                                                        
                                                        
                                                    }
                                               
                                                    
                                                    //TODO: When lawyer list applied
                                                    
                                                    /*  let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: LawyerListVC.className) as! LawyerListVC
                                                    if let categoryVM = self.categoryListVM?.categoryAtIndex(indexPath.row){
                                                    vc.headerTitle = categoryVM.title
                                                    
                                                    self.customMethodManager?.updateIsSelect(entity: ConstantTexts.ExpertiseLT, primary_key: self.customMethodManager?.getTableAndKeys(entity: ConstantTexts.ExpertiseLT) ?? String(), primary_value: categoryVM.expertiseId, key: "is_selected", value: true)
                                                    
                                                    vc.filters.append(Filter(entity: ConstantTexts.ExpertiseLT, title: categoryVM.title, id: categoryVM.expertiseId, isSelected: true))
                                                    
                                                    }
                                                    if self.cityIdArray.count > 0{
                                                    
                                                    if self.cityId == String(){
                                                    // yaha name wala code karna hai
                                                    }else{
                                                    self.customMethodManager?.updateIsSelect(entity: ConstantTexts.CityLT, primary_key: self.customMethodManager?.getTableAndKeys(entity: ConstantTexts.CityLT) ?? String(), primary_value: self.cityId, key: "is_selected", value: true)
                                                    
                                                    vc.filters.append(Filter(entity: ConstantTexts.CityLT, title: self.cityName, id: self.cityId, isSelected: true))
                                                    }
                                                    }
                                                    vc.cityId = self.cityId
                                                    print(self.cityId)
                                                    self.navigationController?.pushViewController(vc, animated: true) */
                                                   })
                                }
                                
                                
                                
                            }
                        }
                       })
        
        
    }
    
    
    //TODO: Actions
    
    @IBAction func btnCountryTapped(_ sender: UIButton) {
        
        /* fatalError() */
        
        self.customMethodManager?.openDownOnView(dropDown: self.dropDown, array: cityNameArray, anchor: self.viewLocationBackground, callBack: { (dropDown) in
            
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                print("Selected item: \(item) at index: \(index)")
                
                if item == ConstantTexts.SelectCityLT{
                    self.cityName = String()
                    self.cityId = String()
                    self.labelLoationTitle.text = ConstantTexts.SelectCityLT
                }else{
                    self.cityName = item
                    self.cityId = self.cityIdArray[index]
                    self.labelLoationTitle.text = "\(ConstantTexts.YouAreInLT) \(item)"
                }
            }
            
            
        })
        
    }
    
    
    @IBAction func btnSelectCityTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.viewHeaderCityBG.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.viewHeaderCityBG.transform = CGAffineTransform.identity
                                let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: CityListViewController.className) as! CityListViewController
                                vc.getCity = { item in
                                    self.cityName = item
                                    self.lblHeaderSelectLocationTitle.text = self.cityName
                                    print(item)
                                }
                                self.navigationController?.pushViewController(vc, animated: true)
                            
                        }
                       })
    }
    
    
    
    @IBAction func btnBackTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.btnBackRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnBackRef.transform = CGAffineTransform.identity
                               
                                self.navigationController?.popViewController(animated: true)
                            
                        }
                       })
    }
    
    
    @IBAction func hideRatingAction(_ sender: Any) {
        self.hideBlurView()
    }
    
    
    @IBAction func btnCancelAction(_ sender: Any) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.btnCancelRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnCancelRef.transform = CGAffineTransform.identity
                            self.hideBlurView()
                            
                        }
                       })
    }
    
    @IBAction func btnOkAction(_ sender: Any) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.btnOkRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnOkRef.transform = CGAffineTransform.identity
                            self.hideBlurView()
                            
                            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: CityListViewController.className) as! CityListViewController
                            vc.getCity = { item in
                                if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
                                    self.cityName = city
                                    self.lblHeaderSelectLocationTitle.text = self.cityName
                                }
                                
                            }
                            self.navigationController?.pushViewController(vc, animated: true)

                            
                        }
                       })
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
