//
//  QueryDetailVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 27/10/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class QueryDetailVC: SBaseViewController {

    //MARK: - IBOutlets
    @IBOutlet weak var viewHeaderBG: UIView!
    @IBOutlet weak var viewBG: UIView!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblImage: UIImageView!
    
    @IBOutlet weak var btnCallRef: UIButton!
    @IBOutlet weak var btnMsgRef: UIButton!
  
    @IBOutlet weak var textView: UITextView!
    
    //MARK: - Variables
    internal var customMethodManager:CustomMethodProtocol?
    internal var order : QueryDataModelNewViewModel = QueryDataModelNewViewModel(QueryDataModelNew(Answer: String(), CategoryId: String(), CategoryName: String(), Email: String(), FullName: String(), Id: String(), MobileNo: String(), Query: String(), Status: String(), answerBy: String(), Date: String(), AnswerByName: String()))
    
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
    
    //TODO: Actions
    @IBAction func btnMsgTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        self.btnMsgRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            
                            self.btnMsgRef.transform = CGAffineTransform.identity
                            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: AppointmentVC.className) as! AppointmentVC
                            
                            vc.type = "0"
                            vc.expID = self.order.CategoryId
                            vc.expName = self.order.CategoryName
                            
                            if let city = USER_DEFAULTS.value(forKey: ConstantTexts.selectedCity) as? String{
                                vc.cityName = city
                            }
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                       })
        
    }
    
    
    
    //TODO: Actions
    @IBAction func btnCallTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.1,
                       animations: {
                        
                        self.btnCallRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            
                            self.btnCallRef.transform = CGAffineTransform.identity
                            self.navigationController?.popViewController(animated: true)
                        }
                       })
        
    }
    

}
