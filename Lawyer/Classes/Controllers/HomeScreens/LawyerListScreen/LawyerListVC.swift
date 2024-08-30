//
//  LawyerListVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 21/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import ViewAnimator

class LawyerListVC: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var lawyerTableView: UITableView!
    @IBOutlet weak var viewFilterBG: UIView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearchRef: UIButton!
    @IBOutlet weak var btnFilterRef: UIButton!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    @IBOutlet weak var filterItemCollectionView: UICollectionView!
    @IBOutlet weak var heightFilterItemCollectionView: NSLayoutConstraint!
    
    //MARK: - Variables
    internal var headerTitle:String = String()
    internal var customMethodManager:CustomMethodProtocol?
    internal var filterCategoryListDataVM:FilterCategory_List_ViewModel?
    internal var filterCategoryListVM: FilterCategoryListModeling?
    internal let errorView: ErrorView  = Bundle.main.loadNibNamed(ErrorView.className, owner: self, options: nil)?.first as! ErrorView
    
    
    
    
    //TODO: Variables for manage filters
    internal var filters = [Filter]()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = AppColor.app_gradient_color1
        
        return refreshControl
    }()
    
    //MARK: - Variables for animation
    // Combined animations example
    internal let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
    internal let zoomAnimation = AnimationType.zoom(scale: 0.2)
    internal let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
    
    
    //MARK: - Variables for api
    internal var service_url:String = String()
    internal var cityName:String = String()
    internal var cityId:String = String()
    internal var offset:Int = 0
    internal var dataCount:Int = Int()
    internal var isPagination: Bool = Bool()
    internal var lawyerListVM_protocol: LawyerDataModeling?
    internal var lawyerListVM:Lawyer_List_View_Model?
    
    /*  //MARK: - variables for the animate tableview
     
     internal var animationName = String()
     
     /// an enum of type TableAnimation - determines the animation to be applied to the tableViewCells
     internal var currentTableAnimation: TableAnimation = .fadeIn(duration: 0.85, delay: 0.03) {
     didSet {
     self.animationName = currentTableAnimation.getTitle()
     }
     }
     internal var animationDuration: TimeInterval = 0.85
     internal var delay: TimeInterval = 0.05  */
    
    
    
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
        /*  animateView()
         runRotateAnimation() */
    }
    
    
    //TODO: Implementation viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissKeyboard()
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
    
    @IBAction func btnClearFilterTapped(_ sender: UIButton) {
        dismissKeyboard()
        
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        self.btnFilterRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnFilterRef.transform = CGAffineTransform.identity
                            self.actionOnClearFilter()
                        }
        })
        
    }
    
    
    @IBAction func btnSearchTapped(_ sender: UIButton) {
        dismissKeyboard()
        
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        self.btnSearchRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnSearchRef.transform = CGAffineTransform.identity
                            self.isPagination = false
                            self.offset = Int()
                            self.lawyerListService(serviceURL:self.service_url, keyword: self.txtSearch.text!.trimmingCharacters(in: .whitespaces), offset: self.offset, isRefresh: Bool(), isFilterApplied: Bool(), isSearchActive: true)
                        }
        })
        
    }
    
    
    
    
    //TODO: Selectors
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.isPagination = false
        self.offset = Int()
        self.txtSearch.text = ConstantTexts.empty
        dismissKeyboard()
        
        self.lawyerListService(serviceURL:service_url, keyword: self.txtSearch.text!.trimmingCharacters(in: .whitespaces), offset: self.offset, isRefresh: true, isFilterApplied: Bool(), isSearchActive: Bool())
        refreshControl.endRefreshing()
        
    }
    
    @objc func btnSelectedCell(_ sender: UIButton) {
        print("Button selected...")
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        if let cell = self.filterCollectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell {
                            cell.transform = .init(scaleX: 0.95, y: 0.95)
                            cell.contentView.backgroundColor = AppColor.highLightColor
                        }
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            if let cell = self.filterCollectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell {
                                cell.transform = .identity
                                cell.contentView.backgroundColor = .clear
                                
                                let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: FilterPopup_VC.className) as! FilterPopup_VC
                                
                                if let headerTitle = self.filterCategoryListDataVM?.filterCategories[sender.tag].title{
                                    vc.headerTitle = headerTitle
                                }
                                vc.index = sender.tag
                                vc.callBackFilter = {  (filter,entity) in
                                    self.setFilterArray(filter: filter, entity: entity)
                                }
                                
                                vc.callBackClearFilter = {(isClearActivated,entity) in
                                    
                                    if isClearActivated{
                                        self.filters.removeAll(where: { $0.entity == entity })
                                        self.getHeightAndIsHiddenForFilterItemCollectionViewWithAnimation(entity: entity)
                                        self.applyFilters()
                                        
                                    }
                                }
                                
                                
                                vc.modalPresentationStyle = .automatic //or .overFullScreen for transparency
                                self.present(vc, animated: true, completion: nil)
                                
                            }
                        }
        })
    }
    
    
    
    @objc func btnDeleteCell(_ sender: UIButton) {
        print("Button selected...")
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        if let cell = self.filterItemCollectionView.cellForItem(at: indexPath) as? FilterItemCollectionViewCell {
                            cell.transform = .init(scaleX: 0.95, y: 0.95)
                            cell.contentView.backgroundColor = AppColor.highLightColor
                        }
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            if let cell = self.filterItemCollectionView.cellForItem(at: indexPath) as? FilterItemCollectionViewCell {
                                cell.transform = .identity
                                cell.contentView.backgroundColor = .clear
                                self.isPagination = false
                                self.offset = Int()
                                self.customMethodManager?.updateIsSelect(entity: self.filters[sender.tag].entity, primary_key: self.customMethodManager?.getTableAndKeys(entity: self.filters[sender.tag].entity) ?? String(), primary_value: self.filters[sender.tag].id, key: "is_selected", value: Bool())
                                
                                self.filters.remove(at: sender.tag)
                                self.getHeightAndIsHiddenForFilterItemCollectionViewWithAnimation(entity: String())
                                self.applyFilters()
                                
                            }
                        }
        })
    }
    
    
    
    @objc func btnMeetTapped(_ sender: UIButton) {
        print("Button selected...")
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        if let cell = self.lawyerTableView.cellForRow(at: indexPath) as? LawyerNewTableViewCell {
                            cell.buttonMeetRef.transform = .init(scaleX: 0.95, y: 0.95)
                            
                        }
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            if let cell = self.lawyerTableView.cellForRow(at: indexPath) as? LawyerNewTableViewCell {
                                cell.buttonMeetRef.transform = .identity
                                
                                let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: AppointmentVC.className) as! AppointmentVC
                                
                                guard let item = self.lawyerListVM?.lawyerAtIndex(sender.tag) else {
                                    fatalError("No FilterCategoryViewModel found...")
                                }
                                
                                vc.Uuid = item.Uuid
                                vc.price = item.ConsulationType_Meet_Fee
                                vc.type = "1"
                                vc.lawyer = item.lawyer
                                self.navigationController?.pushViewController(vc, animated: true)
                                
                            }
                        }
        })
    }
    
    
    
    @objc func btnCallTapped(_ sender: UIButton) {
        print("Button selected...")
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        if let cell = self.lawyerTableView.cellForRow(at: indexPath) as? LawyerNewTableViewCell {
                            cell.buttonCallRef.transform = .init(scaleX: 0.95, y: 0.95)
                            
                        }
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            if let cell = self.lawyerTableView.cellForRow(at: indexPath) as? LawyerNewTableViewCell {
                                cell.buttonCallRef.transform = .identity
                                
                                let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: AppointmentVC.className) as! AppointmentVC
                                
                                guard let item = self.lawyerListVM?.lawyerAtIndex(sender.tag) else {
                                    fatalError("No FilterCategoryViewModel found...")
                                }
                                
                                vc.Uuid = item.Uuid
                                vc.price = item.ConsulationType_Call_Fee
                                vc.type = "0"
                                vc.lawyer = item.lawyer
                                self.navigationController?.pushViewController(vc, animated: true)
                                
                            }
                        }
        })
    }
    
    
    
    
    @objc func btnLawyerSelectedRef(_ sender: UIButton) {
        print("Button selected...")
        let indexPath = IndexPath(item: sender.tag, section: 0)
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        if let cell = self.lawyerTableView.cellForRow(at: indexPath) as? LawyerNewTableViewCell {
                            cell.viewBG.transform = .init(scaleX: 0.95, y: 0.95)
                            
                            self.customMethodManager?.provideShadowAndCornerRadius(cell.viewBG, 0, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.tableBGColor, 2, 2, 2, 2, 0, AppColor.clearColor)
                            
                        }
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            if let cell = self.lawyerTableView.cellForRow(at: indexPath) as? LawyerNewTableViewCell {
                                cell.viewBG.transform = .identity
                                
                               self.customMethodManager?.provideShadowAndCornerRadius(cell.viewBG, 0, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, 2, 2, 2, 2, 0, AppColor.clearColor)
                                
                                let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: LawyerProfileVC.className) as! LawyerProfileVC
                                
                                guard let item = self.lawyerListVM?.lawyerAtIndex(indexPath.row) else {
                                    fatalError("No FilterCategoryViewModel found...")
                                }
                                vc.Uuid = item.Uuid
                                vc.name_Lawyer = item.FullName
                                vc.Id = item.Id
                                vc.imageURL = item.ProfilePhoto
                                vc.callPrice = item.ConsulationType_Call_Fee
                                vc.meetPrice = item.ConsulationType_Meet_Fee
                                vc.lawyer = item.lawyer
                                self.navigationController?.pushViewController(vc, animated: true)
                            }
                        }
        })
    }
    
    
    
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
}
