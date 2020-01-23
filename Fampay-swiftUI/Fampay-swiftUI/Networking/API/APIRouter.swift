//
//  APIRouter.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 22/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import Alamofire
public typealias APIParameters = [String: Any]

protocol Routable {
    var path       : URL { get }
    var method     : HTTPMethod { get }
    var parameters : [String: Any]? { get }
}

// This the all objects of the all the routes

public enum APIRouter: Routable {
    case getUIComponent(Parameters)
}



extension APIRouter {
    var path: URL {
        
        // Add base url for the request
        let baseURL:String = {
            return Environment.APIBasePath()
        }()
        
        let apiVersion: String? = {
            return Environment.APIVersionPath()
        }()
        
        // build up and return the URL for each endpoint
        let relativePath: String? = {
            switch self {
                case .getUIComponent: return "5e2703792f00000d00a4f91d"
            }
        }()
        
        var urlWithAPIVersion = baseURL
        if let apiVersion = apiVersion {
            urlWithAPIVersion = urlWithAPIVersion + apiVersion
        }
        
        var url = URL(string: urlWithAPIVersion)!
        if let relativePath = relativePath {
            url = url.appendingPathComponent(relativePath)
        }
        return url
    }
}



extension APIRouter {
    var method: HTTPMethod {
        switch self {
        case .getUIComponent:
            return .get
        }
    }
}

extension APIRouter {
    var parameters: [String: Any]? {
        switch self {
        case .getUIComponent(let parameters):
            return parameters
        default:
            return [:]
        }
    }
}


