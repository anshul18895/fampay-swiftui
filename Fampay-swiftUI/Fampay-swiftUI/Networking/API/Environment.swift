//
//  Environment.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 22/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation

enum Server {
    case developement
    case staging
    case production
}

class Environment {
    
    static let server:Server    =   .developement
    
    // To print the log set true.
    static let debug:Bool       =   true
    
    class func APIBasePath() -> String {
        switch self.server {
            case .developement:
                return "https://www.mocky.io/"
            case .staging:
                return "https://www.mocky.io/"
            case .production:
                return "https://www.mocky.io/"
        }
    }
    
    class func APIVersionPath() -> String {
        switch self.server {
        case .developement:
            return "v2/"
        case .staging:
            return "v2/"
        case .production:
            return "v2/"
        }
    }
    
}



