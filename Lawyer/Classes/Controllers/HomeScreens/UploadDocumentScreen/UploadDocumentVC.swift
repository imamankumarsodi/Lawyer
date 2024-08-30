//
//  UploadDocumentVC.swift
//  Lawyer
//
//  Created by Aman Kumar on 03/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class UploadDocumentVC: SBaseViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var btnSubmitRef: UIButton!
    @IBOutlet weak var tblDocuments: UITableView!
    
    
    //MARK: - Variables
    internal let header: UploadFooterView  = Bundle.main.loadNibNamed(UploadFooterView.className, owner: self, options: nil)?.first as! UploadFooterView
    
    
    internal var lawyer:Lawyer_Model = Lawyer_Model(CityName: String(), ConsulationType_Call_Fee: String(), ConsulationType_Meet_Fee: String(), ConsulationType_Video_Call_Fee: String(), Experience_Name: String(), Expertise_String: String(), FullName: String(), Id: String(), Language_String: String(), ProfilePhoto: String(), Uuid: String())
    internal var customMethodManager:CustomMethodProtocol?
    internal var Uuid:String = String()
    internal var descriptionTxtView: String = String()
    
    internal var selectedSlot:String = String()
    internal var date:String = String()
    
    internal var price:String = String()
    internal var type:String = String()
    internal var expID:String = String()
    internal var expName:String = String()
    internal var orderId:String = String()
    internal var isComingFromOrder:Bool = Bool()
    
    
    
    internal var docDataModeling:DocumentDataModeling?
    internal var docDataList:DocumentViewModelList?
    internal var validationMethodManager:ValidationProtocol?
    
    //MARK: - Variables for audio recording
    internal var audioRecorder: AVAudioRecorder!
    internal var isAudioRecordingGranted: Bool = Bool()
    internal var isRecording: Bool = Bool()
    internal var recordingPath:String = String()
    internal var meterTimer:Timer!
    
    internal var hr:Int = Int()
    internal var min:Int = Int()
    internal var sec:Int = Int()
    
    //MARK: - Variables for audio playing
    internal var isPlaying: Bool = Bool()
    internal var audioPlayer : AVAudioPlayer!
    internal var player:AVPlayer?
    internal var playerItem:AVPlayerItem?
    
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
    
    //TODO: Implementation viewWillDisappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopAudioPlayer()
        self.stopRecording()
        
    }
    
    //MARK: - Actions, Gestures, Selectors
    
    //TODO: Actions
    
    @IBAction func btnSubmitTapped(_ sender: UIButton) {
        
        self.dismissKeyboard()
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.btnSubmitRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.btnSubmitRef.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.btnSubmitRef.transform = .identity
                            self.customMethodManager?.provideShadowAndCornerRadius(self.btnSubmitRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.textColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.get_packages_Service()
                            /*  if let count = self.docDataList?.numberOfRowsInSection(0){
                             if count > 0 {
                             self.hitCheckBookingSlotService()
                             }else{
                             let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: PaymentVC.className) as! PaymentVC
                             vc.Uuid = self.Uuid
                             vc.date = self.date
                             vc.selectedSlot = self.selectedSlot
                             vc.price = self.price
                             vc.type = self.type
                             vc.expID = self.expID
                             vc.expName = self.expName
                             vc.desc = self.descriptionTxtView
                             vc.Docs = String()
                             vc.lawyer = self.lawyer
                             self.navigationController?.pushViewController(vc, animated: true)
                             }
                             } */
                        }
                       })
        
    }
    
    
    //MARK: - Actions, Gestures, Selectors
    //TODO: Selectors
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
  
    
    
    @objc func btnChooseTapped(_ sender: UIButton) {
        self.dismissKeyboard()
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.header.viewUpload, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.header.viewUpload.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.customMethodManager?.provideShadowAndCornerRadius(self.header.viewUpload, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            self.header.viewUpload.transform = .identity
                            
                            self.openActionSheet()
                            
                            /* if let count = self.docDataList?.numberOfRowsInSection(0){
                             if count == 0 {
                             self.openActionSheet()
                             }else{
                             _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: ConstantTexts.chooseOneALERT, style: .error)
                             }
                             
                             } */
                        }
                       })
        
    }
    
    @objc func btnRecordTapped(_ sender: UIButton) {
        self.dismissKeyboard()
        UIView.animate(withDuration: 0.1,
                       animations: {
                        self.customMethodManager?.provideShadowAndCornerRadius(self.header.viewRecord, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, 0, 0, 0, 0, 0, AppColor.clearColor)
                        self.header.btnRecordVoice.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
                       },
                       completion: { _ in
                        UIView.animate(withDuration: 0.1) {
                            self.header.btnRecordVoice.transform = .identity
                            self.customMethodManager?.provideShadowAndCornerRadius(self.header.viewRecord, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
                            if self.recordingPath == String(){
                                self.startAndStopRecording()
                            }else{
                                self.customMethodManager?.showAlert(ConstantTexts.chooseOneRecordingALERT, okButtonTitle: ConstantTexts.OkBT, target: self)
                            }
                            
                            
                            /* if let count = self.docDataList?.numberOfRowsInSection(0){
                             if count == 0 {
                             self.openActionSheet()
                             }else{
                             _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: ConstantTexts.chooseOneALERT, style: .error)
                             }
                             
                             } */
                        }
                       })
        
    }
    
    
    
    
    @objc func btnDeleteTapped(_ sender: UIButton) {
        if let item = self.docDataList?.documentAtIndex(sender.tag){
            if item.isAudioFile{
                
                
                self.customMethodManager?.showAlertWithCancel(title: ConstantTexts.AppName, message: ConstantTexts.WantToDelRecALERT, btnOkTitle: ConstantTexts.OkBT, btnCancelTitle: ConstantTexts.CancelBT, callBack: { (status) in
                    if status {
                        
                        self.header.lblRecord.textColor = AppColor.darkGrayColor
                        self.header.lblRecord.text = ConstantTexts.RecordLT
                        self.isRecording = false
                        self.recordingPath = String()
                        self.stopAudioPlayer()
                        
                        do {
                            if let url = URL(string: item.localSoundPath){
                                try FileManager.default.removeItem(at:url)
                            }
                            
                        } catch let error as NSError {
                            print("Error: \(error.domain)")
                        }
                        
                        self.docDataList?.documentDataItems.remove(at: sender.tag)
                        DispatchQueue.main.async {
                            self.tblDocuments.reloadData()
                        }
                        
                    }else{
                        DispatchQueue.main.async {
                            self.tblDocuments.reloadData()
                        }
                    }
                })
                
            }else{
                
                
                
                self.customMethodManager?.showAlertWithCancel(title: ConstantTexts.AppName, message: ConstantTexts.WantToDelRecALERT, btnOkTitle: ConstantTexts.OkBT, btnCancelTitle: ConstantTexts.CancelBT, callBack: { (status) in
                    if status {
                        self.hitDeleteDocService(DocumentId:item.Id,index:sender.tag)
                    }else{
                        DispatchQueue.main.async {
                            self.tblDocuments.reloadData()
                        }
                    }
                })
                
                
                
                
                
                
            }
        }
        
    }
    
    
    
    @objc func btnPlayTapped(_ sender: UIButton) {
        if let item = self.docDataList?.documentAtIndex(sender.tag){
            
            if item.localSoundPath != String(){
                
                if let url = URL(string: item.localSoundPath){
                    if let item = self.docDataList?.documentAtIndex(sender.tag){
                        if item.isAudioFile{
                            if(isPlaying)
                            {
                                audioPlayer.stop()
                                let indexPath = IndexPath(row: 0, section: 0)
                                if let cell = self.tblDocuments.cellForRow(at: indexPath) as? UploadDocTableViewCellAndXib{
                                    
                                    cell.btnPlayPauseRef.setImage(UIImage(systemName: "play.fill"), for: .normal)
                                    cell.viewLineBG.isHidden = false
                                    cell.viewAnimationBG.isHidden = true
                                }
                                // play_btn_ref.setTitle("Play", for: .normal)
                                isPlaying = false
                            }
                            else
                            {
                                
                                
                                if item.localSoundPath.contains("https://") {
                                    let playerItem:AVPlayerItem = AVPlayerItem(url: URL(fileURLWithPath: item.localSoundPath) as URL)
                                    player = AVPlayer(playerItem: playerItem)
                                    player!.play()
                                    
                                    let indexPath = IndexPath(row: 0, section: 0)
                                    if let cell = self.tblDocuments.cellForRow(at: indexPath) as? UploadDocTableViewCellAndXib{
                                        
                                        cell.btnPlayPauseRef.setImage(UIImage(systemName: "play.fill"), for: .normal)
                                        cell.viewLineBG.isHidden = false
                                        cell.viewAnimationBG.isHidden = true
                                    }
                                    // play_btn_ref.setTitle("Play", for: .normal)
                                    isPlaying = true
                                }else{
                                    if FileManager.default.fileExists(atPath: url.path)
                                    {
                                        let indexPath = IndexPath(row: 0, section: 0)
                                        if let cell = self.tblDocuments.cellForRow(at: indexPath) as? UploadDocTableViewCellAndXib{
                                            
                                            cell.btnPlayPauseRef.setImage(UIImage(systemName: "pause.fill"), for: .normal)
                                            cell.viewLineBG.isHidden = true
                                            cell.viewAnimationBG.isHidden = false
                                            self.customMethodManager?.showLottieAnimationFill(cell.viewAnimationBG, ConstantTexts.Wave, .loop)
                                        }
                                        // play_btn_ref.setTitle("pause", for: .normal)
                                        
                                        prepare_play()
                                        audioPlayer.play()
                                        isPlaying = true
                                    }
                                    else
                                    {
                                        display_alert(msg_title: ConstantTexts.AppName, msg_desc: ConstantTexts.audioFileMissingALERT, action_title: ConstantTexts.OkBT)
                                    }
                                    
                                }
                                
                            }
                        }
                    }
                    
                }
                
            }else{
                display_alert(msg_title: ConstantTexts.AppName, msg_desc: ConstantTexts.audioFileMissingALERT, action_title: ConstantTexts.OkBT)
            }
            
            
            
        }
        
        
        
        
        
        
    }
    
    
    @objc func stopRecordingAndPlaying(_ notification: Notification) {
        stopRecording()
        stopAudioPlayer()
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
