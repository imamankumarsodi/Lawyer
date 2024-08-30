//
//  CustomMethodClass.swift
//  Lawyer
//
//  Created by Aman Kumar on 18/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit
import Lottie
import DropDown
import CoreData
import SDWebImage
class CustomMethodClass: CustomMethodProtocol {
    
    //TODO: Singleton object
    static let shared = CustomMethodClass()
    private init() {}
    
    internal let animationView = AnimationView(name: ConstantTexts.Loader)
    
    //TODO: Get states from json file
    func getStates() -> ([State_DataModel],[String]) {
        var states = [State_DataModel]()
        var statesName = [String]()
        
        if let path = Bundle.main.path(forResource: "state", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? NSArray{
                    // do stuff
                    for item in jsonResult{
                        if let itemDict = item as? NSDictionary{
                            var state = State_DataModel(Id: String(), State: String(), isSelected: String())
                            if let Id = itemDict.value(forKey: "Id") as? Int{
                                state.Id = "\(Id)"
                            }
                            
                            if let Id = itemDict.value(forKey: "Id") as? String{
                                state.Id = "\(Id)"
                            }
                            
                            if let State = itemDict.value(forKey: "State") as? String{
                                state.State = State
                                statesName.append(state.State)
                            }
                            states.append(state)
                        }
                    }
                }
            } catch {
                // handle error
            }
        }
        
        return (states,statesName)
    }
    
    //TODO: Set url image on imageview
    func setImage(imageView:UIImageView,url:String){
        imageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageView.sd_setImage(with: URL(string: url))
    }
    
    //MARK: - Alert Methods
    //TODO: Show alert simple
    func showAlert(_ message: String, okButtonTitle: String? = nil, target: UIViewController? = nil) {
        let topViewController: UIViewController? = self.topMostViewController(rootViewController: self.rootViewController())
        
        if let _ = topViewController {
            let alert = UIAlertController(title:APP_NAME, message: message, preferredStyle: UIAlertController.Style.alert);
            let okBtnTitle = okButtonTitle
            let okAction = UIAlertAction(title:okBtnTitle, style: UIAlertAction.Style.default, handler: nil);
            
            alert.addAction(okAction);
            if UIApplication.shared.applicationState != .background{
                topViewController?.present(alert, animated:true, completion:nil);
            }
        }
    }
    
    
    //TODO: Show alert with cancel
    func showAlertWithCancel(title:String,message:String,btnOkTitle:String,btnCancelTitle:String,callBack:@escaping ((Bool)->())){
        
        let topViewController: UIViewController? = self.topMostViewController(rootViewController: self.rootViewController())
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: btnOkTitle, style: .default, handler: { action in
            callBack(true)
        }))
        alert.addAction(UIAlertAction(title: btnCancelTitle, style: .cancel, handler: { action in
            callBack(false)
        }))
        
        topViewController?.present(alert, animated: true)
    }
    
    //TODO: Show alert with cancel
    func showAlertWithOK(title:String,message:String,btnOkTitle:String,callBack:@escaping ((Bool)->())){
        let topViewController: UIViewController? = self.topMostViewController(rootViewController: self.rootViewController())
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: btnOkTitle, style: .default, handler: { action in
            callBack(true)
        }))
        topViewController?.present(alert, animated: true)
    }
    
    
    //TODO: Get root view controller
    func rootViewController() -> UIViewController
    {
        return UIApplication.shared.windows.first!.rootViewController ?? UIViewController()
    }
    
    
    
    //TODO - Get topmost view controller
    func topMostViewController(rootViewController: UIViewController) -> UIViewController? {
        if let navigationController = rootViewController as? UINavigationController
        {
            return topMostViewController(rootViewController: navigationController.visibleViewController!)
        }
        
        if let tabBarController = rootViewController as? UITabBarController
        {
            if let selectedTabBarController = tabBarController.selectedViewController
            {
                return topMostViewController(rootViewController: selectedTabBarController)
            }
        }
        
        if let presentedViewController = rootViewController.presentedViewController
        {
            return topMostViewController(rootViewController: presentedViewController)
        }
        return rootViewController
    }
    
    
    //TODO: Show ToolTip
    func showToolTip(msg:String,anchorView:UIView,sourceView:UIView){
        let rightBottomView = TipView()
        rightBottomView.color = AppColor.errorColor
        rightBottomView.textColor = AppColor.whiteColor
        rightBottomView.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 12)
        rightBottomView.maxWidth = anchorView.frame.size.width - 50
        rightBottomView.dismissClosure = { tipview in
            print("call back to there..")
        }
        // Dismiss after spwcified duration
        rightBottomView.show(message: msg,
                             sourceView: anchorView,
                             containerView: sourceView,
                             direction: .top, dismissAfterDuration: 2.0)
    }
    
    //TODO: Show ToolTip
    func showToolTipBottom(msg:String,anchorView:UIView,sourceView:UIView){
        let rightBottomView = TipView()
        rightBottomView.color = AppColor.errorColor
        rightBottomView.textColor = AppColor.whiteColor
        rightBottomView.font = AppFont.Semibold.size(AppFontName.OpenSans, size: 12)
        rightBottomView.maxWidth = anchorView.frame.size.width - 50
        rightBottomView.dismissClosure = { tipview in
            print("call back to there..")
        }
        // Dismiss after spwcified duration
        rightBottomView.show(message: msg,
                             sourceView: anchorView,
                             containerView: sourceView,
                             direction: .bottom, dismissAfterDuration: 2.0)
    }
    
    
    
    //TODO: Provide corner radius
    func provideCornerRadiusTo(_ view:UIView, _ radius:CGFloat, _ corners:CACornerMask){
        view.layer.cornerRadius = radius
        view.clipsToBounds = true
        view.layer.maskedCorners = corners
    }
    
    //TODO: Provide shadow, border and corner radius
    func provideShadowAndCornerRadius(_ blueView:UIView, _ cornerRadius:CGFloat,_ corners:CACornerMask,_ shadowColor: UIColor, _ shadowWidth: CGFloat, _ shadowHeight: CGFloat,_ shadowOpacity: Float, _ shadowRadius: CGFloat, _ borderWidth:CGFloat, _ borderColor: UIColor){
        // corner radius
        blueView.layer.cornerRadius = cornerRadius
        blueView.layer.maskedCorners = corners
        
        // border
        blueView.layer.borderWidth = borderWidth
        blueView.layer.borderColor = borderColor.cgColor
        
        // shadow
        blueView.layer.shadowColor = shadowColor.cgColor
        blueView.layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
        blueView.layer.shadowOpacity = shadowOpacity
        blueView.layer.shadowRadius = shadowRadius
    }
    
    //TODO: Provide border
    public func provideCornerBorderTo(_ item: UIView, _ border: CGFloat,_ borderColor: UIColor) {
        item.layer.borderColor = borderColor.cgColor
        item.layer.borderWidth = border
        item.clipsToBounds = true
    }
    
    
    //TODO: Provide AttributedText
    public func provideSimpleAttributedText( text:String, font: UIFont,  color: UIColor)->NSMutableAttributedString{
        return NSMutableAttributedString(string: "\(text)", attributes:[.font: font, .foregroundColor :color])
    }
    
    
    //TODO: Provide underline AttributedText
    public func provideUnderlineAttributedText( text:String, font: UIFont, _ color: UIColor)->NSMutableAttributedString{
        return NSMutableAttributedString(string: "\(text)", attributes:[.font: font, .foregroundColor :color, NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    
    //TODO: Open drop down
    public func openDownOnView(dropDown:DropDown,array:[String],anchor:UIView,callBack:((_ dropDown:DropDown)->())){
        dropDown.anchorView = anchor
        dropDown.width = anchor.frame.size.width
        dropDown.dataSource = array
        /* dropDown.backgroundColor = AppColor.bgColor
         dropDown.textColor = AppColor.whiteColor */
        dropDown.bottomOffset = CGPoint(x: 0, y:anchor.bounds.height)
        dropDown.direction = .any
        dropDown.show()
        
        callBack(dropDown)
    }
    
    //TODO: Open drop down bottom direction
    public func openDownOnViewBottomDirection(dropDown:DropDown,array:[String],anchor:UIView,callBack:((_ dropDown:DropDown)->())){
        dropDown.anchorView = anchor
        dropDown.width = anchor.frame.size.width
        dropDown.dataSource = array
        /* dropDown.backgroundColor = AppColor.bgColor
         dropDown.textColor = AppColor.whiteColor */
        dropDown.bottomOffset = CGPoint(x: 0, y:anchor.bounds.height)
        dropDown.direction = .bottom
        dropDown.show()
        
        callBack(dropDown)
    }
    
    
    
    //TODO: Get indexPath for tableview cell
    func getIndexPathFor(view: UIView, tableView: UITableView) -> IndexPath? {
        let point = tableView.convert(view.bounds.origin, from: view)
        let indexPath = tableView.indexPathForRow(at: point)
        return indexPath
    }
    
    //TODO: Get indexPath for collectionview cell
    func getIndexPathForCollectionView(view: UIView, collectionView: UICollectionView) -> IndexPath? {
        let point = collectionView.convert(view.bounds.origin, from: view)
        let indexPath = collectionView.indexPathForItem(at: point)
        return indexPath
    }
    
    
    //MARK: - Methods for coredata
    //TODO: Check entity is empty
    func entityIsEmpty(entity: String) -> Bool{
        let context = kAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            if result.count == 0{
                return true
            }else{
                return false
            }
            
        } catch {
            print("Error: \(error.localizedDescription)")
            return true
        }
        
    }
    
    //TODO: Delete all data
    func deleteAllData( entity:String,success: @escaping () -> ()) {
        
        if USER_DEFAULTS.value(forKey: ConstantTexts.mobile_logo) != nil{
            USER_DEFAULTS.removeObject(forKey: ConstantTexts.mobile_logo)
           
        }
        
      /*  let domain = Bundle.main.bundleIdentifier!
        USER_DEFAULTS.removePersistentDomain(forName: domain)
        USER_DEFAULTS.synchronize() */
        
        let context = kAppDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try context.execute(request)
        } catch {
            print("Detele all data in \(entity) error :", error)
        }
        success()
    }
    
    
    //TODO: Delete all data filters
    func deleteAllDataFilters( entity:String){
        let context = kAppDelegate.persistentContainer.viewContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        
        do {
            try context.execute(request)
        } catch {
            print("Detele all data in \(entity) error :", error)
        }
    }
    
    
    
    
    //TODO: Get user from data base
    func getUser(entity: String) -> User_Data_Model{
        
        let user = User_Data_Model(DeviceId: String(), DeviceType: String(), Email: String(), FirebaseId: String(), Fullname: String(), Id: String(), IpAddress: String(), Mobile: String(), type: String(), Uuid: String(), token: String(),MobileLogo:String(), Version:String(), WebLogo:String(), CouponCode: String())
        
        let context = kAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.fetchLimit = 1
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                user.DeviceId = data.value(forKey: "device_id") as? String ?? String()
                user.DeviceType = data.value(forKey: "device_type") as? String ?? String()
                user.Email = data.value(forKey: "email") as? String ?? String()
                user.FirebaseId = data.value(forKey: "firebase_id") as? String ?? String()
                
                user.Fullname = data.value(forKey: "full_name") as? String ?? String()
                user.Id = data.value(forKey: "id") as? String ?? String()
                user.IpAddress = data.value(forKey: "ip_address") as? String ?? String()
                user.Mobile = data.value(forKey: "mobile") as? String ?? String()
                
                
                user.type = data.value(forKey: "type") as? String ?? String()
                user.Uuid = data.value(forKey: "uuid") as? String ?? String()
                user.token = data.value(forKey: "token") as? String ?? String()
                
                user.MobileLogo = data.value(forKey: "mobile_logo") as? String ?? String()
                user.WebLogo = data.value(forKey: "web_logo") as? String ?? String()
                user.Version = data.value(forKey: "version") as? String ?? String()
                user.CouponCode = data.value(forKey: "coupon_code") as? String ?? String()
                
            }
            
        } catch {
            
            print("Failed")
        }
        
        return user
    }
    
    
    //TODO: Get filter from data base
    func retrive_filter(entity: String,keyName:String,keyId:String) -> [Filter]{
        var filters = [Filter]()
        let context = kAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let filter = Filter(entity: entity, title: String(), id: String(), isSelected: Bool())
                filter.title = data.value(forKey: keyName) as? String ?? String()
                filter.id = data.value(forKey: keyId) as? String ?? String()
                filter.isSelected = data.value(forKey: "is_selected") as? Bool ?? Bool()
                filters.append(filter)
            }
            
        } catch {
            
            print("Failed")
        }
        
        
        return filters
    }
    
    
    //TODO: Update is_select value for filter
    func updateIsSelect(entity: String,primary_key:String,primary_value:String,key:String,value:Bool){
        let context = kAppDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        request.predicate = NSPredicate(format: "\(primary_key) = %@", primary_value)
        do {
            let result = try context.fetch(request)
            if result.count > 0{
                let filterObject = result[0] as! NSManagedObject
                filterObject.setValue(value, forKey: key)
                do{
                    try context.save()
                }catch{
                    print("Failed")
                }
            }
        } catch {
            print("Failed")
        }
    }
    
    
    //TODO: Get table and keys for update
    func getTableAndKeys(entity:String)->String{
        
        switch entity {
        case ConstantTexts.CityLT:
            return "city_id"
            
        case ConstantTexts.ExpertiseLT:
            return "expertise_id"
            
        case ConstantTexts.LanguageLT:
            return "language_id"
            
        case ConstantTexts.ExperienceLT:
            return "experience_id"
            
        default:
            return String()
        }
        
        
    }
    
    //TODO: Call number
     func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
}


//MARK: - Extension for lottie animation
extension CustomMethodClass {
    
    
    
    //MARK: - For progressview
    //TODO: startLoader
    func startLoader(view:UIView) {
        view.isUserInteractionEnabled = false
        animationView.isHidden = false
        
        animationView.frame = CGRect(x: view.frame.size.width/2 - 25, y: view.frame.size.height/2 - 25, width: 50, height: 50)
        
        animationView.center = view.center
        animationView.contentMode = UIView.ContentMode(rawValue: UIView.ContentMode.scaleAspectFit.rawValue * 2)!
        
        animationView.animationSpeed = 1.20
        animationView.loopMode = .loop
        view.addSubview(animationView)
        animationView.play()
    }
    
    //TODO: stopLoader
    func stopLoader(view:UIView) {
        view.isUserInteractionEnabled = true
        view.alpha = 1
        self.animationView.isHidden = true
        self.animationView.stop()
    }
    
    
    
    
    
    //TODO: Run lottie animation
    func showLottieAnimation(_ view: UIView,_ animationName:String, _ loopMode:LottieLoopMode) {
        let animationViewLottie = AnimationView(name: animationName)
        view.isUserInteractionEnabled = false
        animationViewLottie.isHidden = false
        view.clipsToBounds = true
        animationViewLottie.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        animationViewLottie.contentMode = .scaleAspectFit
        animationViewLottie.animationSpeed = 1
        animationViewLottie.loopMode = loopMode
        view.addSubview(animationViewLottie)
        animationViewLottie.play()
    }
    
    
    
    //TODO: Run lottie animation
    func showLottieAnimationFill(_ view: UIView,_ animationName:String, _ loopMode:LottieLoopMode) {
        let animationViewLottie = AnimationView(name: animationName)
        view.isUserInteractionEnabled = false
        animationViewLottie.isHidden = false
        view.clipsToBounds = true
        animationViewLottie.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        animationViewLottie.contentMode = .scaleToFill
        animationViewLottie.animationSpeed = 1
        animationViewLottie.loopMode = loopMode
        view.addSubview(animationViewLottie)
        animationViewLottie.play()
    }
    
    
    //TODO: Setup error view
    func setupError(chidView:ErrorView,message:String,callback: @escaping () -> Void){
        chidView.backgroundColor = AppColor.clearColor
        chidView.viewLottie.backgroundColor = AppColor.clearColor
        chidView.lblDescription.backgroundColor = AppColor.clearColor
        
        chidView.lblDescription.font = AppFont.Bold.size(AppFontName.OpenSans, size: 18)
        chidView.lblDescription.textColor = AppColor.app_gradient_color1
        chidView.lblDescription.textAlignment = .center
        chidView.lblDescription.numberOfLines = 0
        chidView.lblDescription.text = message
        
        chidView.viewLottie.subviews.forEach({ $0.removeFromSuperview() }) // this gets things done
        _ = chidView.viewLottie.subviews.map({ $0.removeFromSuperview() }) // this returns modified array
        
        callback()
        
        
    }
   
    
    
    //TODO: Check subview is available or not
    func isSubviewAdded(parentView:UIView,childView:UIView) -> Bool{
        return childView.isDescendant(of: parentView) ? true : false
    }
    
    //TODO: Add subview
    func addSubView(parentView:UIView,childView:UIView){
        parentView.addSubview(childView)
    }
    
    
    //TODO: Remove subview
    func removeSubView(childView:UIView){
        childView.removeFromSuperview()
    }
    
    //TODO: Get animation name and message
    func getAnimationNameAndMessage(errorCode:Int)->(String,String){
        switch errorCode {
        case 1:
            return (ConstantTexts.search_doc,ConstantTexts.NoDocumentUploadedYetALERT)
        case 1009:
            return (ConstantTexts.NoInternetConnectionEmptyState,ConstantTexts.noInterNet)
            
        case 400:
            return (ConstantTexts.Invalid_URLA,ConstantTexts.Invalid_URL)
            
        default:
            return (ConstantTexts.SomeThingWentWrong,ConstantTexts.somethingWentMessage)
        }
        
        
    }
    
    
}


