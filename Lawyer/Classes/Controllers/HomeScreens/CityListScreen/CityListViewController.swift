//
//  CityListViewController.swift
//  Lawyer
//
//  Created by Aman Kumar on 08/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class CityListViewController: SBaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var txtSearch: UITextField!
  /*  @IBOutlet weak var btnClearRef: UIButton!
    @IBOutlet weak var btnDoneRef: UIButton! */
    @IBOutlet weak var cityTableView: UITableView!
    @IBOutlet weak var btnSearchRef: UIButton!
    
    //MARK: - Variables
    internal var validationMethodManager:ValidationProtocol?
    internal var customMethodManager:CustomMethodProtocol?
    internal var searchActive:Bool = Bool()
    internal var cityNameArray = [String]()
    internal var cityIdArray = [String]()
    internal var getCity:((_ cityName:String)->())?
    
    internal var cityNameArray_Filter = [String]()
    internal var cityIdArray_Filter = [String]()
    
    internal var cityId:String = String()
    internal var cityName:String = String()
    
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
    
    //TODO: Implementation viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navSetup()
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
    
    
    @IBAction func btnSearchTapped(_ sender: UIButton) {
        dismissKeyboard()
        
        
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        self.btnSearchRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnSearchRef.transform = CGAffineTransform.identity
                            self.getCitiesName_Service(cityName: self.txtSearch.text!.trimmingCharacters(in: .whitespaces))
                            
                        }
        })
        
    }
    
    
  /*  @IBAction func btnDismissTapped(_ sender: UIButton) {
        dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    } */
    
    //TODO: Selectors
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.txtSearch.text = String()
        self.getCitiesName_Service(cityName: String())
        refreshControl.endRefreshing()
        
    }

    
    @objc func btnSelectCellTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        let indexPath = IndexPath(row: sender.tag, section: 0)
                        if let cell = self.cityTableView.cellForRow(at: indexPath) as? Detail_TableViewCellAndXib{
                            cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                        }
                            
                       
        },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            
                            let indexPath = IndexPath(row: sender.tag, section: 0)
                            if let cell = self.cityTableView.cellForRow(at: indexPath) as? Detail_TableViewCellAndXib{
                                cell.transform = CGAffineTransform.identity
                                let name: String = self.searchActive ? self.cityNameArray_Filter[sender.tag] : self.cityNameArray[sender.tag]
                                USER_DEFAULTS.setValue(name, forKey: ConstantTexts.selectedCity)
                                self.getCity?(name)
                                
                                
                                
                                
                                self.navigationController?.popViewController(animated: true)
                            }
                            
                        }
        })
        
    }
    
}
