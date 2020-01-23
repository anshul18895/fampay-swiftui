//
//  AppCordinator.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 23/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import SwiftUI

class AppCoordinator{
    typealias Dependencies = HasAPI & HasWindow
    var dependencies: Dependencies
    
    init(window: UIWindow){
        self.dependencies = AppDependency.init(window: window)
        window.rootViewController = UIHostingController(rootView: HomeView(viewModel: HomeViewModel(dependecies: self.dependencies)))
    }
    
}
