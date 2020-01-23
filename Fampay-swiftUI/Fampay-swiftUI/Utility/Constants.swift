//
//  Constants.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import UIKit

//MARK:- Global Variables
let Application                         = UIApplication.shared.delegate as! AppDelegate
var AppName: String {return Bundle.main.infoDictionary!["CFBundleName"] as! String}
var AppDisplayName: String {return Bundle.main.infoDictionary!["CFBundleDisplayName"] as! String}

var AppVersion: String {return Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String}

var AppBuildVersion: String {return Bundle.main.infoDictionary!["CFBundleVersion"] as! String}


//MARK:- UIDevice Static Constants

let IS_IPHONE_5             = 568.0
let IPHONE6_PLUS_WIDTH      = 414.0
let IPHONE6_PLUS_HEIGHT     = 736.0
let IPHONE6_WIDTH           = 375.0
let IPHONE6_HEIGHT          = 667.0
let IPHONEX_HEIGHT          = 812.0

let isIpad = UIDevice.current.userInterfaceIdiom == .pad

let Screen                  = UIScreen.main.bounds.size
