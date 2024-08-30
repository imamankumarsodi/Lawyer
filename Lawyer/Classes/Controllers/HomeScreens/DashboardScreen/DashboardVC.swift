//
//  DashboardVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 05/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import DropDown
import ViewAnimator
import FSPagerView
class DashboardVC: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewMainBG: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dash_CollectionView: UICollectionView!
    @IBOutlet weak var viewGradient: UIView!
    @IBOutlet weak var viewCollectionBG: UIView!
    @IBOutlet weak var viewMoreBG: UIView!
    
    
    @IBOutlet weak var viewHeaderBG: UIView!
    @IBOutlet weak var viewHeaderCityBG: UIView!
    @IBOutlet weak var lblHeaderTitle: UILabel!
    @IBOutlet weak var lblHeaderSelectLocationTitle: UILabel!
    @IBOutlet weak var NSLayoutConstraintHeaderHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var lblMore: UILabel!
    
    @IBOutlet weak var lblStartCons_Paid: UILabel!
    @IBOutlet weak var btnStartCons_Paid: UIButton!
    
    @IBOutlet weak var viewConsu_Free: UIView!
    @IBOutlet weak var lblStartCons_Free: UILabel!
    @IBOutlet weak var btnStartCons_Free: UIButton!
    @IBOutlet weak var bannerView: FSPagerView!
    @IBOutlet weak var imgMore: UIImageView!
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var viewPopup: UIView!
    @IBOutlet weak var lblHeaderPopupTitle: UILabel!
    @IBOutlet weak var btnCancelRef: UIButton!
    @IBOutlet weak var btnOkRef: UIButton!
    
    @IBOutlet weak var pageControl: FSPageControl!{
        didSet {
            self.pageControl.backgroundColor = AppColor.clearColor
            
            self.pageControl.contentHorizontalAlignment = .center
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
            self.pageControl.setStrokeColor(AppColor.app_gradient_color1, for: .normal)
            self.pageControl.setStrokeColor(AppColor.app_gradient_color1, for: .selected)
            self.pageControl.setFillColor(AppColor.app_gradient_color1, for: .selected)
        }
    }
    
    //MARK: - Variables
    internal var images:[String] = [String]()
    
    internal var customMethodManager:CustomMethodProtocol?
    internal var categoryListVM:CategoryListViewModel?
    internal var expertiseVM:CategoryListViewModel?
    internal var homeVM: CategoryListModeling?
    internal var cityName: String = String()
    
    // For Collection view
    internal let animations = [AnimationType.from(direction: .bottom, offset: 30.0)]
    //MARK: - Variables for animation
    // Combined animations example
    internal let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
    internal let zoomAnimation = AnimationType.zoom(scale: 0.2)
    internal let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)
    
    
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
        
        self.viewGradient.gradientBackground(from: AppColor.app_gradient_color1, to: AppColor.app_gradient_color2, direction: .topToBottom)
        
     /*
        if self.categoryListVM == nil{
            self.categoryListVM = self.homeVM?.prepareDataEmpty()
        }else{
            self.categoryListVM = self.homeVM?.prepareDataEmpty()
        }
        
        DispatchQueue.main.async {
            self.dash_CollectionView.reloadData()
        }
         */
       
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        super.isHiddenNavigationBar(false)
        self.initalHideBlurView()
    }
  
    //MARK: - Actions, Gestures, Selectors
    //TODO: Selectors
    
    //TODO: Actions
    @IBAction func btnMoreTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.viewMoreBG.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.viewMoreBG.transform = CGAffineTransform.identity
                            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: HomeVC.className) as! HomeVC
                            vc.categoryListVM = self.expertiseVM
                            
                            if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
                                vc.cityName = city
                            }else{
                                vc.cityName = String()
                            }
                            
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                       })
    }
    
    
    @IBAction func btnStartCunsPaidTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.btnStartCons_Paid.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnStartCons_Paid.transform = CGAffineTransform.identity
                            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: HomeVC.className) as! HomeVC
                            vc.categoryListVM = self.expertiseVM
                            vc.cityName = self.cityName
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                       })
    }
    
    
    @IBAction func btnStartCunsFreeTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.btnStartCons_Free.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnStartCons_Free.transform = CGAffineTransform.identity
                            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: SendQueryViewController.className) as! SendQueryViewController
                            vc.expertiseVM = self.expertiseVM
                            self.navigationController?.pushViewController(vc, animated: true)
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
                                
                                if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
                                    self.cityName = city
                                    self.lblHeaderSelectLocationTitle.text = self.cityName
                                }
                                
                               
                            }
                            self.navigationController?.pushViewController(vc, animated: true)
                            
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
