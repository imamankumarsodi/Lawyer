//
//  UploadDocumentVC+MethodExtension.swift
//  Lawyer
//
//  Created by Aman Kumar on 03/09/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
extension UploadDocumentVC{
    //TODO: Navigation setup implenemtation
    internal func navSetup(){
        self.tabBarController?.tabBar.isHidden = true
        super.setupNavigationBarTitle(AppColor.header_color,ConstantTexts.UploadDocumentHT, leftBarButtonsType: [.back], rightBarButtonsType: [])
    }
    
    
    //TODO: Init values
    internal func initValues(){
        if self.customMethodManager == nil {
            self.customMethodManager = CustomMethodClass.shared
        }
        
        if self.validationMethodManager == nil {
            self.validationMethodManager = ValidationClass.shared
        }
        
        if self.docDataModeling == nil{
            self.docDataModeling = UploadDocumentVM.shared
        }
        
        if self.docDataList == nil{
            self.docDataList = docDataModeling?.prepareDataSource()
        }
        
        /*  let item = DocumentDataModel(Data(), String(), String(), "String", String(), Bool())
         
         self.docDataList?.documentDataItems.append(item)
         
         DispatchQueue.main.async {
         self.tblDocuments.reloadData()
         }
         */
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.stopRecordingAndPlaying(_:)), name: NSNotification.Name(rawValue: "STOP_RECORDING_AND_PLAYING"), object: nil)
        
        
        //  self.customMethodManager?.provideShadowAndCornerRadius(self.header.viewBG, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
        /*   self.header.viewBG.cornerRadius = 10
         self.header.viewBG.dashColor = AppColor.placeholderColor
         self.header.viewBG.dashWidth = 1.5
         self.header.viewBG.dashLength = 6.0
         self.header.viewBG.betweenDashesSpace = 2.0
         
         self.customMethodManager?.showLottieAnimation(self.header.imgLottie, ConstantTexts.Upload_filesHeader, .loop)
         self.header.lblInstruction1.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
         self.header.lblInstruction1.textColor = AppColor.darkGrayColor
         self.header.lblInstruction1.numberOfLines = 0
         self.header.lblInstruction1.textAlignment = .center */
        
        self.header.lblInstruction2.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.header.lblInstruction2.textColor = AppColor.app_gradient_color1
        self.header.lblInstruction2.numberOfLines = 0
        self.header.lblInstruction2.textAlignment = .left
        self.header.lblInstruction2.text = ConstantTexts.AdditionalInfoLT
        
        self.header.txtView.font = AppFont.Italic.size(AppFontName.OpenSans, size: 12)
        self.header.txtView.text = ConstantTexts.WriteCommentPH
        self.header.txtView.textColor = AppColor.darkGrayColor
        self.header.txtView.delegate = self
        
        self.customMethodManager?.provideCornerRadiusTo(self.header.viewBG, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.header.viewBG.backgroundColor = AppColor.tableBGColor
        self.header.txtView.backgroundColor = AppColor.tableBGColor
        
        self.header.btnUpladDocRef.backgroundColor = AppColor.clearColor
        self.customMethodManager?.provideCornerRadiusTo(self.header.btnUpladDocRef, 2.5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.header.viewUpload, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        // self.customMethodManager?.provideCornerRadiusTo(self.header.viewUpload, 2.5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        self.header.viewUpload.backgroundColor = AppColor.image_bg_color
        self.header.imgUploadRef.setImageTintColor(AppColor.app_gradient_color1)
        
        
        self.header.lblUpload.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.header.lblUpload.textColor = AppColor.app_gradient_color1
        self.header.lblUpload.numberOfLines = 0
        self.header.lblUpload.textAlignment = .center
        self.header.lblUpload.text = ConstantTexts.UploadLT
        
        
        
        self.header.btnRecordVoice.backgroundColor = AppColor.clearColor
        self.customMethodManager?.provideCornerRadiusTo(self.header.btnRecordVoice, 2.5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.header.viewRecord, 10, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.placeholderColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
       // self.customMethodManager?.provideCornerRadiusTo(self.header.viewRecord, 2.5, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner])
        
        self.header.viewRecord.backgroundColor = AppColor.image_bg_color
        self.header.imgRecordRef.setImageTintColor(AppColor.app_gradient_color1)
        
        
        self.header.lblRecord.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 14)
        self.header.lblRecord.textColor = AppColor.app_gradient_color1
        self.header.lblRecord.numberOfLines = 0
        self.header.lblRecord.textAlignment = .center
        self.header.lblRecord.text = ConstantTexts.RecordLT
        
        self.header.btnUpladDocRef.addTarget(self, action: #selector(btnChooseTapped), for: .touchUpInside)
        self.header.btnRecordVoice.addTarget(self, action: #selector(btnRecordTapped), for: .touchUpInside)
        
        self.tblDocuments.tableHeaderView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        self.tblDocuments.tableFooterView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 0.0, height: Double.leastNormalMagnitude))
        
        self.tblDocuments.sectionHeaderHeight = 0.0;
        self.tblDocuments.sectionFooterHeight = 0.0;
        
        self.tblDocuments.hideEmptyCells()
        self.tblDocuments.isScrollEnabled = true
        self.tblDocuments.backgroundColor = AppColor.whiteColor
        registerNib()
        
        
        
        self.customMethodManager?.provideShadowAndCornerRadius(self.btnSubmitRef, 2, [.layerMinXMinYCorner, .layerMaxXMaxYCorner,.layerMaxXMinYCorner, .layerMinXMaxYCorner], AppColor.darkGrayColor, -1, 1, 1, 3, 0, AppColor.clearColor)
        
        self.btnSubmitRef.setTitle(ConstantTexts.Submit_BT, for: .normal)
        self.btnSubmitRef.titleLabel?.font = ConstantFonts.mainBottomButtonFont
        
        self.btnSubmitRef.setTitleColor(AppColor.whiteColor, for: .normal)
        self.btnSubmitRef.backgroundColor = AppColor.app_gradient_color1
        
        
         self.header.lblTimer.font = AppFont.Regular.size(AppFontName.OpenSans, size: 10)
         self.header.lblTimer.textColor = AppColor.errorColor
         self.header.lblTimer.numberOfLines = 0
         self.header.lblTimer.textAlignment = .right
         self.header.lblTimer.text = ConstantTexts.DefaultTimeLT
         
        self.header.viewAnimation.backgroundColor = AppColor.image_bg_color
        self.header.viewAnimation.isHidden = true
        self.header.imgRecordRef.isHidden = false
        self.header.lblTimer.isHidden = false
        
        
        initialSetup()
        
    }
    
    
    //TODO: Intial setup implementation
    internal func initialSetup(){
        
        self.check_record_permission()
        
        
    }
    
    
    /*  //TODO: Change header implementation
     internal func changeHeader(count:Int){
     if count == 0{
     self.header.lblInstruction1.text = ConstantTexts.UploadDocumentLT
     
     }else{
     self.header.lblInstruction1.text = ConstantTexts.DocumentUploadLT
     }
     
     } */
    
    
    //TODO: register nib file
    private func registerNib(){
        self.tblDocuments.registerMultiple(nibs: [EmptyWithAlertTableViewCell.className,UploadDocTableViewCellAndXib.className])
        
    }
    
    //TODO: Delete row form index
    internal func deleteRow(index:Int){
        
        self.customMethodManager?.showAlertWithCancel(title: ConstantTexts.AppName, message: ConstantTexts.WantToDeleteDocuALERT, btnOkTitle: ConstantTexts.OkBT, btnCancelTitle: ConstantTexts.CancelBT, callBack: { (status) in
            if status{
                self.docDataList?.documentDataItems.remove(at: index)
                DispatchQueue.main.async {
                    self.tblDocuments.reloadData()
                }
                
            }else{
                DispatchQueue.main.async {
                    self.tblDocuments.reloadData()
                }
            }
        })
    }
    
    
    
    //TODO: Methods for picker (Image picker and document picker)
    public func openActionSheet() {
        
        let alert = UIAlertController(title: APP_NAME, message: ConstantTexts.SelectYourOptionLT, preferredStyle: .actionSheet)
        
        let cameraAction = UIAlertAction(title: ConstantTexts.CameraLT, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            super.openCamera()
        }
        let gallaryAction = UIAlertAction(title: ConstantTexts.GalleryLT, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            super.openGallery()
        }
        
        
        let document = UIAlertAction(title: ConstantTexts.DocumetsLT, style: UIAlertAction.Style.default)
        {
            UIAlertAction in
            super.openDocuments()
        }
        
        let cancelAction = UIAlertAction(title: ConstantTexts.CancelBT, style: UIAlertAction.Style.cancel)
        {
            UIAlertAction in
        }
        
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(document)
        alert.addAction(cancelAction)
        super.present(alert, animated: true, completion: nil)
        
        super.getDocCallBack = { item in
            /* if let count = self.docDataList?.numberOfRowsInSection(0){
             if count > 0 {
             self.docDataList?.documentDataItems.removeAll()
             }
             
             } */
            
            
            self.docDataList?.documentDataItems.append(item)
            self.hitMultiple_docV2(item: item)
            
        }
        
    }
    
    
    //TODO: Validate fields implementation
    internal func validateFields(validHandler: @escaping ( String, Bool) -> Void){
        
        /*  if !validationMethodManager!.checkEmptyField(self.footer.txtView.text.trimmingCharacters(in: .whitespacesAndNewlines)){
         validHandler( ConstantTexts.EnterDescriptionALERT, Bool())
         return
         
         }
         
         
         if self.footer.txtView.text.trimmingCharacters(in: .whitespacesAndNewlines) == ConstantTexts.WriteCommentPH{
         validHandler( ConstantTexts.EnterDescriptionALERT, Bool())
         return
         }
         
         validHandler(ConstantTexts.empty,  true) */
        
        
    }
    
    //MARK: - Methods for recording
    //TODO: Check record permission
    private func check_record_permission()
    {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            isAudioRecordingGranted = true
            break
        case AVAudioSessionRecordPermission.denied:
            isAudioRecordingGranted = false
            break
        case AVAudioSessionRecordPermission.undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission({ (allowed) in
                if allowed {
                    self.isAudioRecordingGranted = true
                } else {
                    self.isAudioRecordingGranted = false
                }
            })
            break
        default:
            break
        }
        
        if self.isComingFromOrder{
            self.get_OrderDetail_Service()
        }
        
    }
    
    //TODO: Start and stop recording
    internal func startAndStopRecording(){
        if isRecording{
            isRecording = Bool()
            self.header.viewAnimation.isHidden = true
            self.header.imgRecordRef.isHidden = false
            self.header.lblTimer.isHidden = false
            //stop animation
            self.header.lblRecord.text = ConstantTexts.RecordLT
            finishAudioRecording(success: true)
        }else{
            self.header.lblRecord.text = ConstantTexts.StopRecordLT
            isRecording = true
            self.header.viewAnimation.isHidden = false
            self.header.imgRecordRef.isHidden = true
            self.header.lblTimer.isHidden = false
            //Start animation
            self.customMethodManager?.showLottieAnimationFill(self.header.viewAnimation, ConstantTexts.Halo, .loop)
            self.setup_recorder()
            self.audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:#selector(self.updateAudioMeter(timer:)), userInfo:nil, repeats:true)
            
            
        }
    }
    
    //TODO: Stop recording forcely when goto background or back tapped
    internal func stopRecording(){
        if isRecording
        {
            self.header.lblRecord.text = ConstantTexts.RecordLT
            self.header.viewAnimation.isHidden = true
            self.header.imgRecordRef.isHidden = false
            self.header.lblTimer.isHidden = false
            
            //stop animation
            
            isRecording = false
            audioRecorder.stop()
            audioRecorder = nil
        }
        
    }
    
    
    //TODO: Setup recorder
    private func setup_recorder()
    {
        if isAudioRecordingGranted
        {
            let session = AVAudioSession.sharedInstance()
            do
            {
                try session.setCategory(AVAudioSession.Category.playAndRecord, options: .defaultToSpeaker)
                try session.setActive(true)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey:AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileUrl(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            }
            catch let error {
                display_alert(msg_title: ConstantTexts.AppName, msg_desc: error.localizedDescription, action_title: ConstantTexts.OkBT)
            }
        }
        else
        {
            display_alert(msg_title: ConstantTexts.AppName, msg_desc: ConstantTexts.DontHaveMicrophoneALERT, action_title: ConstantTexts.OkBT)
        }
    }
    
    
    //TODO: Update audio meter
    @objc func updateAudioMeter(timer: Timer)
    {
        if self.isRecording
        {
            self.hr = Int((audioRecorder.currentTime / 60) / 60)
            self.min = Int(audioRecorder.currentTime / 60)
            self.sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", self.hr, self.min, self.sec)
            self.header.lblTimer.text = totalTimeString
            audioRecorder.updateMeters()
        }
    }
    
    
    
    //TODO: Finish audio recording
    internal func finishAudioRecording(success: Bool)
    {
        if success
        {
            audioRecorder.stop()
            audioRecorder = nil
            let urlString: String = getFileUrl().absoluteString
            self.recordingPath = urlString
            let item = DocumentDataModel(data: self.getAudioData(localUrl: getFileUrl()), type: String(), withName: "Audio", fileName: urlString, mimeType: "audio/mp3", isSelected: Bool(),isAudioFile: true,localSoundPath: urlString,serverSoundPath: String(),Id:String(), ConsultationId:String(), DocumentUrl:String(), FileType:String(), FileName:String(), OrderId: String())
            
            //            self.docDataList?.documentDataItems.insert(item, at: 0)
            //            DispatchQueue.main.async {
            //                self.tblDocuments.reloadData()
            //            }
            
            self.hitBooking_FormV2(item: item)
            
        }
        else
        {
            display_alert(msg_title: ConstantTexts.AppName, msg_desc: ConstantTexts.recordingFailALERT, action_title: ConstantTexts.OkBT)
        }
    }
    
    //TODO: Get audio data
    private func getAudioData(localUrl:URL)->Data{
        var audioData: Data = Data()
        do {
            
            audioData = try Data(contentsOf: localUrl)
            return audioData
            
        } catch {
            
            print("Unable to load data: \(error)")
            
        }
        return audioData
    }
    
    
    //TODO: Get file url
    private func getFileUrl() -> URL
    {
        let filename = ConstantTexts.MyRecording_LT
        let filePath = getDocumentsDirectory().appendingPathComponent(filename)
        return filePath
    }
    
    
    //TODO: Show display alert
    internal func display_alert(msg_title : String , msg_desc : String ,action_title : String)
    {
        let ac = UIAlertController(title: msg_title, message: msg_desc, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: action_title, style: .default)
        {
            (result : UIAlertAction) -> Void in
            //  _ = self.navigationController?.popViewController(animated: true)
        })
        present(ac, animated: true)
    }
    
    
    //MARK: - Play the recording
    //TODO: Prepare play
    internal func prepare_play()
    {
        do
        {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileUrl())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        }
        catch{
            print("Error")
        }
    }
    
    //TODO: Stop player
    internal func stopAudioPlayer()
    {
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
    }
    
    
    
    
    //MARK: - Web services
    //TODO: check-bookingslot Service
    internal func hitCheckBookingSlotService(){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        guard  let docArray = self.docDataList?.documentDataItems  else {
            print("No docArray found...")
            return
        }
        
        
        
        let parameters = [Api_keys_model.Date:self.date,
                          Api_keys_model.LawyerId:self.Uuid,
                          Api_keys_model.SelectedSlot:self.selectedSlot] as [String:AnyObject]
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        
        ServiceClass.shared.multipartImageServiceWithArrayObject(url: SCustomerApi.check_bookingslot, docArray, header: header, parameters: parameters, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        if let dataDict = result_Dict.value(forKey: "data") as? NSDictionary{
                            
                            if let count = self.docDataList?.numberOfRowsInSection(0){
                                if count > 0 {
                                    self.docDataList?.documentDataItems[0].fileName = self.docDataModeling?.getUrl(data: dataDict) ?? String()
                                    DispatchQueue.main.async {
                                        self.tblDocuments.reloadData()
                                        
                                      
                                        
                                        
                                        if let message = result_Dict.value(forKey: "message") as? String{
                                            
                                            let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: PaymentVC.className) as! PaymentVC
                                            vc.Uuid = self.Uuid
                                            vc.date = self.date
                                            vc.selectedSlot = self.selectedSlot
                                            vc.price = self.price
                                            vc.type = self.type
                                            vc.expID = self.expID
                                            vc.expName = self.expName
                                            vc.desc = self.descriptionTxtView
                                            if let count = self.docDataList?.numberOfRowsInSection(0){
                                                if count > 0{
                                                    if let fileName = self.docDataList?.documentAtIndex(0).fileName{
                                                        vc.Docs = fileName
                                                    }
                                                }
                                            }
                                            self.navigationController?.pushViewController(vc, animated: true)
                                            
                                            
                                          /*  _ = SweetAlert().showAlert(ConstantTexts.AppName, subTitle: message, style: .success, buttonTitle: ConstantTexts.OkBT, action: { (status) in
                                                if status{
                                                    let vc = AppStoryboard.homeSB.instantiateViewController(withIdentifier: PaymentVC.className) as! PaymentVC
                                                    vc.Uuid = self.Uuid
                                                    vc.date = self.date
                                                    vc.selectedSlot = self.selectedSlot
                                                    vc.price = self.price
                                                    vc.type = self.type
                                                    vc.expID = self.expID
                                                    vc.expName = self.expName
                                                    vc.desc = self.descriptionTxtView
                                                    if let count = self.docDataList?.numberOfRowsInSection(0){
                                                        if count > 0{
                                                            if let fileName = self.docDataList?.documentAtIndex(0).fileName{
                                                                vc.Docs = fileName
                                                            }
                                                        }
                                                    }
                                                    self.navigationController?.pushViewController(vc, animated: true)         }
                                            }) */
                                        }
                                        
                                        
                                        
                                    }
                                }
                            }
                            
                        }
                    }else if code == 404{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.navigationController?.popViewController(animated: true)                            }
                            })
                        }
                        
                    }else if code == 401{
                        
                        if let count = self.docDataList?.numberOfRowsInSection(0){
                            if count > 0 {
                                self.docDataList?.documentDataItems.removeAll()
                            }
                            
                        }
                        DispatchQueue.main.async {
                            self.tblDocuments.reloadData()
                        }
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.customMethodManager?.deleteAllData(entity: "User_Data", success: {
                                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                                    })
                                }
                            })
                            
                        }
                    }
                }
            }
            
        }) { (error) in
            print(error)
            self.customMethodManager?.stopLoader(view:self.view)
            
            if let count = self.docDataList?.numberOfRowsInSection(0){
                if count > 0 {
                    self.docDataList?.documentDataItems.removeAll()
                }
                
            }
            DispatchQueue.main.async {
                self.tblDocuments.reloadData()
            }
            
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }else{
                
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)

                
            }
            
        }
    }
    
    
    
    
    //MARK: - V2 Web Services
    //TODO: Multiple_doc Service
    internal func hitMultiple_docV2(item:DocumentDataModel){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        guard  let docArray = self.docDataList?.documentDataItems  else {
            print("No docArray found...")
            return
        }
        
        
        
        let parameters = [Api_keys_model.OrderId:self.orderId] as [String:AnyObject]
        
        /* let parameters = [Api_keys_model.OrderId:"ed08cc49-ffdd-11ea-bbc6-000c29951e01",
         Api_keys_model.SelectedSlot:"07:00 PM",
         Api_keys_model.Date:"09-Sep-2020",
         Api_keys_model.LawyerId:"a73a7544-e841-11ea-896b-000c29951e01"] as [String:AnyObject] */
        
        
        let header = ["Authorization":user.token,
                      "Content-Type":"application/json",
                      "Accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        
        ServiceClass.shared.multipartImageServiceWithArrayObject(url: SCustomerApi.multiple_doc_V2_iOS, docArray, header: header, parameters: parameters, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        if let dataDict = result_Dict.value(forKey: "data") as? NSDictionary{
                            // item.fileName = self.docDataModeling?.getUrl(data: dataDict) ?? String()
                            
                            if let Id = dataDict.value(forKey: "Id") as? String{
                                item.Id = Id
                            }
                            
                            if let Id = dataDict.value(forKey: "Id") as? Int{
                                item.Id = "\(Id)"
                            }
                            
                            if let ConsultationId = dataDict.value(forKey: "ConsultationId") as? String{
                                item.ConsultationId = ConsultationId
                            }
                            
                            if let ConsultationId = dataDict.value(forKey: "ConsultationId") as? Int{
                                item.ConsultationId = "\(ConsultationId)"
                            }
                            
                            if let DocumentUrl = dataDict.value(forKey: "DocumentUrl") as? String{
                                item.DocumentUrl = DocumentUrl
                            }
                            
                            if let FileType = dataDict.value(forKey: "FileType") as? String{
                                item.FileType = FileType
                            }
                            
                            if let FileName = dataDict.value(forKey: "FileName") as? String{
                                item.FileName = FileName
                                item.fileName = item.FileName
                            }
                            
                            
                            DispatchQueue.main.async {
                                self.tblDocuments.reloadData()
                            }
                            
                        }
                    }else if code == 404{
                        self.recordingPath = String()
                        do {
                            if let url = URL(string: item.localSoundPath){
                                try FileManager.default.removeItem(at:url)
                            }
                            
                        } catch let error as NSError {
                            print("Error: \(error.domain)")
                        }
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.navigationController?.popViewController(animated: true)                            }
                            })
                            
                          
                        }
                        
                    }else if code == 401{
                        self.recordingPath = String()
                        do {
                            if let url = URL(string: item.localSoundPath){
                                try FileManager.default.removeItem(at:url)
                            }
                            
                        } catch let error as NSError {
                            print("Error: \(error.domain)")
                        }
                        if let count = self.docDataList?.numberOfRowsInSection(0){
                            if count > 0 {
                                self.docDataList?.documentDataItems.removeAll()
                            }
                            
                        }
                        DispatchQueue.main.async {
                            self.tblDocuments.reloadData()
                        }
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.customMethodManager?.deleteAllData(entity: "User_Data", success: {
                                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                                    })
                                }
                            })
                            
                        }
                    }else if code == 400{
                        self.recordingPath = String()
                        do {
                            if let url = URL(string: item.localSoundPath){
                                try FileManager.default.removeItem(at:url)
                            }
                            
                        } catch let error as NSError {
                            print("Error: \(error.domain)")
                        }
                        self.docDataList?.documentDataItems.removeLast()
                        DispatchQueue.main.async {
                            self.tblDocuments.reloadData()
                        }
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                            
                        }
                    }
                }
            }
            
        }) { (error) in
            print(error)
            self.customMethodManager?.stopLoader(view:self.view)
            self.recordingPath = String()
            do {
                if let url = URL(string: item.localSoundPath){
                    try FileManager.default.removeItem(at:url)
                }
                
            } catch let error as NSError {
                print("Error: \(error.domain)")
            }
            if let count = self.docDataList?.numberOfRowsInSection(0){
                if count > 0 {
                    self.docDataList?.documentDataItems.removeAll()
                }
                
            }
            DispatchQueue.main.async {
                self.tblDocuments.reloadData()
            }
            
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }else{
                
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)

                
            }
            
        }
    }
    
    
    //TODO: Booking-form Service
    internal func hitBooking_FormV2(item:DocumentDataModel){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        
        let parameters = [Api_keys_model.OrderId:self.orderId,
                          Api_keys_model.Query:self.descriptionTxtView] as [String:AnyObject]
        
        let header = ["Authorization":user.token,
                      "Content-Type":"multipart/form-data; boundary=<calculated when request is sent>",
                      "Accept":"*/*"]
        
        //eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJJZCI6IjY2IiwiVXVpZCI6IjNjMzczY2Y5LWUyZDEtMTFlYS04OTZiLTAwMGMyOTk1MWUwMSIsIkZ1bGxuYW1lIjoidmlrYXMgc2Vtd2FsIiwiRW1haWwiOiJ2aWthcy5zZW13YWwxOTk0QGdtYWlsLmNvbSIsIk1vYmlsZSI6Ijk2NDM0NTIwMTAiLCJUeXBlIjoiMCIsIkRldmljZVR5cGUiOiIxIiwiSXBBZGRyZXNzIjoiYXNkZmdoamtsIiwiRGV2aWNlSWQiOiJzZGhzZ2hzZ2oiLCJ0aW1lIjoxNjAxNTU4ODgxfQ.-yb4mwMcIftDammmodAQhO21xfcNhFQmtF7WSCpAFFU
        
        self.customMethodManager?.startLoader(view:self.view)
        
        ServiceClass.shared.multipartImageServiceWithArrayObject(url: SCustomerApi.booking_form_V2_iOS, [item], header: header, parameters: parameters, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        if let dataDict = result_Dict.value(forKey: "data") as? NSDictionary{
                            if let Id = dataDict.value(forKey: "Id") as? String{
                                item.Id = Id
                            }
                            
                            if let Id = dataDict.value(forKey: "Id") as? Int{
                                item.Id = "\(Id)"
                            }
                            
                            if let Audio = dataDict.value(forKey: "Audio") as? String{
                                item.DocumentUrl = Audio
                            }
                            
                            
                        }
                        
                        self.docDataList?.documentDataItems.insert(item, at: 0)
                        
                        DispatchQueue.main.async {
                            self.tblDocuments.reloadData()
                        }
                        
                        
                        /* if let dataDict = result_Dict.value(forKey: "data") as? NSDictionary{
                         item.fileName = self.docDataModeling?.getUrl(data: dataDict) ?? String()
                         DispatchQueue.main.async {
                         self.tblDocuments.reloadData()
                         }
                         
                         } */
                    }else if code == 404{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.navigationController?.popViewController(animated: true)                            }
                            })
                            
                           
                        }
                        
                    }else if code == 401{
                        
                        if let count = self.docDataList?.numberOfRowsInSection(0){
                            if count > 0 {
                                self.docDataList?.documentDataItems.removeAll()
                            }
                            
                        }
                        DispatchQueue.main.async {
                            self.tblDocuments.reloadData()
                        }
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.customMethodManager?.deleteAllData(entity: "User_Data", success: {
                                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                                    })
                                }
                            })

                            
                        }
                    }else if code == 400{
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)
                            
                            self.header.lblTimer.text = ConstantTexts.DefaultTimeLT
                        }
                    }
                }
            }
            
        }) { (error) in
            print(error)
            self.customMethodManager?.stopLoader(view:self.view)
            
            if let count = self.docDataList?.numberOfRowsInSection(0){
                if count > 0 {
                    self.docDataList?.documentDataItems.removeAll()
                }
                
            }
            DispatchQueue.main.async {
                self.tblDocuments.reloadData()
            }
            
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
                
            }else{
                
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)

                
            }
            
        }
    }
    
    
    //TODO: check-bookingslot Service
    internal func hitDeleteDocService(DocumentId:String,index:Int){
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        guard  let docArray = self.docDataList?.documentDataItems  else {
            print("No docArray found...")
            return
        }
        
        
        
        let parameters = [Api_keys_model.DocumentId:DocumentId] as [String:AnyObject]
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        self.customMethodManager?.startLoader(view:self.view)
        
        ServiceClass.shared.multipartImageServiceWithArrayObject(url: SCustomerApi.delete_document, docArray, header: header, parameters: parameters, success: { (result) in
            self.customMethodManager?.stopLoader(view:self.view)
            print(result)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        
                        if index == 0{
                            self.header.lblTimer.text = ConstantTexts.DefaultTimeLT
                        }
                        self.docDataList?.documentDataItems.remove(at: index)
                        DispatchQueue.main.async {
                            self.tblDocuments.reloadData()
                        }
                    }else if code == 404{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.navigationController?.popViewController(animated: true)                            }
                            })
                            
                        }
                        
                    }else if code == 401{
                        
                        if let count = self.docDataList?.numberOfRowsInSection(0){
                            if count > 0 {
                                self.docDataList?.documentDataItems.removeAll()
                            }
                            
                        }
                        DispatchQueue.main.async {
                            self.tblDocuments.reloadData()
                        }
                        
                        if let message = result_Dict.value(forKey: "message") as? String{
                            
                            self.customMethodManager?.showAlertWithOK(title: ConstantTexts.AppName, message: message, btnOkTitle: ConstantTexts.OkBT, callBack: { (status) in
                                if status{
                                    self.customMethodManager?.deleteAllData(entity: "User_Data", success: {
                                        super.moveToNextViewCViaRoot(name: ConstantTexts.AuthSBT, withIdentifier: LoginVC.className)
                                    })
                                }
                            })
                            
                            
                        }
                    }
                }
            }
            
        }) { (error) in
            print(error)
            self.customMethodManager?.stopLoader(view:self.view)
            
            if let count = self.docDataList?.numberOfRowsInSection(0){
                if count > 0 {
                    self.docDataList?.documentDataItems.removeAll()
                }
                
            }
            DispatchQueue.main.async {
                self.tblDocuments.reloadData()
            }
            
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
            }else{
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)
            }
            
        }
    }
    
    
    
    
    //TODO: get_packages web service
    internal func get_packages_Service(){
        
        //        self.setExperise()
        
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]
        
        
        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: SCustomerApi.get_packages, method: .get, parameters: nil, header: header, success: { (result) in
            print(result)
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            if let package = data.value(forKey: "package") as? NSArray{
                                for item in package{
                                    if let itemDict = item as? NSDictionary{
                                        if let Uuid = itemDict.value(forKey: "Uuid") as? String{
                                            self.lawyer.Uuid = Uuid
                                            self.Uuid = Uuid
                                        }
                                        
                                        if let PackageName = itemDict.value(forKey: "PackageName") as? String{
                                            self.lawyer.Expertise_String = PackageName
                                        }
                                        
                                        /*  if let PackageName = itemDict.value(forKey: "PackageName") as? String{
                                         }
                                         
                                         if let PackageDescription = itemDict.value(forKey: "PackageDescription") as? String{
                                         } */
                                        
                                        if let Amount = itemDict.value(forKey: "Amount") as? String{
                                            self.lawyer.ConsulationType_Call_Fee = Amount
                                            self.price = Amount
                                        }
                                       
                                        self.lawyer.FullName = "\(ConstantTexts.AppName)"
                                        
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
                                        vc.OrderId = self.orderId
                                        
                                       
                                        if let wallet = data.value(forKey: "wallet") as? String{
                                            vc.wallet = Int(wallet) ?? 0
                                        }
                                        
                                        if let wallet = data.value(forKey: "wallet") as? Int{
                                            vc.wallet = Int(wallet) ?? 0
                                        }
                                        
                                        
                                        
                                        self.navigationController?.pushViewController(vc, animated: true)
                                        
                                    }
                                }
                            }
                            
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
            self.customMethodManager?.stopLoader(view:self.view)
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)

            }else{
                
                self.customMethodManager?.showAlert(ConstantTexts.errorMessage, okButtonTitle: ConstantTexts.OkBT, target: self)

                
            }
            
            
            
        }
        
        
    }
    
    
    
    //TODO: get_packages web service
    internal func get_OrderDetail_Service(){
        
        //        self.setExperise()
        
        
        guard let user = self.customMethodManager?.getUser(entity: "User_Data") else{
            print("No user found...")
            return
        }
        
        
        let header = ["authorization":user.token,
                      "Content-Type":"application/json",
                      "accept":"application/json"]

        self.customMethodManager?.startLoader(view:self.view)
        ServiceClass.shared.webServiceBasicMethod(url: "\(SCustomerApi.order_files_V2)\(self.orderId)", method: .get, parameters: nil, header: header, success: { (result) in
            print(result)
            self.customMethodManager?.stopLoader(view:self.view)
            if let result_Dict = result as? NSDictionary{
                if let code = result_Dict.value(forKey: "code") as? Int{
                    if code == 200{
                        if let data = result_Dict.value(forKey: "data") as? NSDictionary{
                            if let audio = data.value(forKey: "audio") as? NSArray{
                                
                                let item = DocumentDataModel(data: Data(), type: String(), withName: "Audio", fileName: String(), mimeType: "audio/mp3", isSelected: Bool(),isAudioFile: true,localSoundPath: String(),serverSoundPath: String(),Id:String(), ConsultationId:String(), DocumentUrl:String(), FileType:String(), FileName:String(), OrderId: String())
                                
                                for itemDic in audio{
                                    if let audioDict = itemDic as? NSDictionary{
                                        
                                        if let Id = audioDict.value(forKey: "Id") as? String{
                                            
                                            item.Id = Id
                                        }
                                        
                                        if let Id = audioDict.value(forKey: "Id") as? Int{
                                            
                                            item.Id = "\(Id)"
                                        }
                                        
                                        if let OrderId = audioDict.value(forKey: "OrderId") as? String{
                                            
                                            item.OrderId = OrderId
                                        }
                                        
                                        if let OrderId = audioDict.value(forKey: "OrderId") as? Int{
                                            
                                            item.OrderId = "\(OrderId)"
                                        }
                                        
                                        
                                        
                                        if let AudioUrl = audioDict.value(forKey: "AudioUrl") as? String{
                                            item.fileName = AudioUrl
                                            item.localSoundPath = item.fileName
                                            
                                            do {
                                                let data = try Data(contentsOf: URL(fileURLWithPath: item.fileName) as URL)
                                                item.data = data
                                            } catch {
                                                print("Unable to load data: \(error)")
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                }
                                
                                
                                
                                self.docDataList?.documentDataItems.insert(item, at: 0)
                                
                                
                                
                                
                                
                            }
                            
                            if let order = data.value(forKey: "order") as? NSArray{
                                
                                let item = DocumentDataModel(data: Data(), type: ".png", withName: "uploads", fileName: String(), mimeType: "image/png", isSelected: Bool(),isAudioFile: Bool(),localSoundPath: String(),serverSoundPath: String(),Id:String(), ConsultationId:String(), DocumentUrl:String(), FileType:String(), FileName:String(), OrderId: String())
                                
                                
                                for itemDic in order{
                                    if let orderDict = itemDic as? NSDictionary{
                                        if let DocumentUrl = orderDict.value(forKey: "DocumentUrl") as? String{
                                            item.DocumentUrl = DocumentUrl
                                            item.fileName = DocumentUrl
                                            do {
                                                let data = try Data(contentsOf: URL(fileURLWithPath: item.DocumentUrl) as URL)
                                                item.data = data
                                            } catch {
                                                print("Unable to load data: \(error)")
                                            }
                                            
                                        }
                                        
                                        if let Id = orderDict.value(forKey: "Id") as? String{
                                            
                                            item.Id = Id
                                        }
                                        
                                        if let Id = orderDict.value(forKey: "Id") as? Int{
                                            
                                            item.Id = "\(Id)"
                                        }
                                        
                                        if let OrderId = orderDict.value(forKey: "OrderId") as? String{
                                            
                                            item.OrderId = OrderId
                                        }
                                        
                                        if let OrderId = orderDict.value(forKey: "OrderId") as? Int{
                                            
                                            item.OrderId = "\(OrderId)"
                                        }
                                        
                                        self.docDataList?.documentDataItems.append(item)
                                        
                                    }
                                    
                                }
                                
                            }
                            
                            DispatchQueue.main.async {
                                self.tblDocuments.reloadData()
                            }
                            
                        }
                    }else{
                        if let message = result_Dict.value(forKey: "message") as? String{
                            print(message)
                           // self.customMethodManager?.showAlert(message, okButtonTitle: ConstantTexts.OkBT, target: self)

                        }
                        
                    }
                }
            }
            
            
        }) { (error) in
            print(error)
            self.customMethodManager?.stopLoader(view:self.view)
            if let errorString = (error as NSError).userInfo[ConstantTexts.errorMessage_Key] as? String{
                self.customMethodManager?.showAlert(errorString, okButtonTitle: ConstantTexts.OkBT, target: self)
            }else{
                self.customMethodManager?.showAlert(ConstantTexts.AppName, okButtonTitle: ConstantTexts.OkBT, target: self)
            }
            
            
            
        }
        
        
    }
    
    
    
}
