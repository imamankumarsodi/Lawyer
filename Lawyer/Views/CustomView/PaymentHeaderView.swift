//
//  PaymentHeaderView.swift
//  Lawyer
//
//  Created by Aman Kumar on 07/08/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit

class PaymentHeaderView: UIView {

    //MARK: - IBOutlet
    
    @IBOutlet weak var viewUser: UIView!
    @IBOutlet weak var lblUserHeading: UILabel!
    @IBOutlet weak var imgName: UIImageView!
    @IBOutlet weak var imgEmail: UIImageView!
    @IBOutlet weak var imgPhone: UIImageView!
    @IBOutlet weak var imgCoupon: UIImageView!
    @IBOutlet weak var btnChangeDateRef: UIButton!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    @IBOutlet weak var viewConsultation: UIView!
    @IBOutlet weak var lblConsultationHeader: UILabel!
    @IBOutlet weak var lblDetailLeft: UILabel!
    @IBOutlet weak var lblDetailRightt: UILabel!
    
    
    @IBOutlet weak var viewPayment: UIView!
    @IBOutlet weak var paymentSummaryTitle: UILabel!
    
    @IBOutlet weak var originalPriceTitle: UILabel!
    @IBOutlet weak var originalPriceValue: UILabel!
    
    @IBOutlet weak var gstPriceTitle: UILabel!
    @IBOutlet weak var gstPriceValue: UILabel!
    
    @IBOutlet weak var couponAppliedTitle: UILabel!
    
    @IBOutlet weak var viewBGTotal: UIView!
    @IBOutlet weak var totalPriceTitle: UILabel!
    @IBOutlet weak var totalPriceValue: UILabel!
    
    @IBOutlet weak var txtCoupon: UITextField!
    @IBOutlet weak var btnApplyRef: UIButton!
    
    @IBOutlet weak var viewSwitch: UIView!
    @IBOutlet weak var lblGSTIN: UILabel!
    @IBOutlet weak var switch_Ref: UISwitch!
    
    @IBOutlet weak var btnWalletRef: UIButton!
    @IBOutlet weak var lblWallet: UILabel!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
