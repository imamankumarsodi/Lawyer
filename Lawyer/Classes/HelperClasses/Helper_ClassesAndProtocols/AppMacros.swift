//
//  AppMacros.swift
//  Lawyer
//
//  Created by Aman Kumar on 18/07/20.
//  Copyright © 2020 Hephateus. All rights reserved.
//

import Foundation
import UIKit

let NOTIFICATION_CENTER = NotificationCenter.default
let FILE_MANAGER = FileManager.default
let MAIN_BUNDLE = Bundle.main
let MAIN_THREAD = Thread.main
let MAIN_SCREEN = UIScreen.main
let MAIN_SCREEN_WIDTH = UIScreen.main.bounds.width
let MAIN_SCREEN_HEIGHT = UIScreen.main.bounds.height
let USER_DEFAULTS = UserDefaults.standard
let APPLICATION = UIApplication.shared
let CURRENT_DEVICE = UIDevice.current
let MAIN_RUN_LOOP = RunLoop.main
let GENERAL_PASTEBOARD = UIPasteboard.general
let CURRENT_LANGUAGE = NSLocale.current.languageCode
let kAppDelegate = UIApplication.shared.delegate as! AppDelegate
var newProfile = Bool()
let STATUS_BAR_DEFAULT_HEIGHT = 20
let NAVIGATION_BAR_DEFAULT_HEIGHT = 44
let NAVIGATION_BAR_BUTTON_DEFAULT_WIDTH = 40.0
let EDGE_INSET = CGFloat(10.0)
let TOOLBAR_DEFAULT_HEIGHT = 44
let TABBAR_DEFAULT_HEIGHT = 49
let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "

//TODO: Network
let kNoInterNet = "No internet"

//TODO: Application informations

let APP_BUNDLE_NAME = MAIN_BUNDLE.infoDictionary?[kCFBundleNameKey as String]
let APP_NAME = "All India Legal"
let APP_LINK = "https://www.hackingwithswift.com/articles/118/uiactivityviewcontroller-by-example"
let APP_VERSION = MAIN_BUNDLE.object(forInfoDictionaryKey: "CFBundleVersion")
let IN_SIMULATOR = (TARGET_IPHONE_SIMULATOR != 0)
let IS_NEW_CODE = false


var SCREEN_NAME:String =  String()
