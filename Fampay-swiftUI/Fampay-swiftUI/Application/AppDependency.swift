//
//  AppDependency.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import SwiftUI

protocol HasWindow {
    var window: UIWindow { get }
}

protocol HasAPI {
    var api: APIManager { get }
}



class AppDependency: HasWindow, HasAPI {
    
    let window: UIWindow
    let api: APIManager
    
    init(window: UIWindow) {
        self.window = window
        self.api = APIManager()
    }
    
}

