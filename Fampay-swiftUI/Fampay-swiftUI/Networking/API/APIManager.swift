//
//  APIManager.swift
//  Fampay-swiftUI
//
//  Created by Anshul on 22/01/20.
//  Copyright © 2020 Anshul Shah. All rights reserved.
//

import Foundation
import Alamofire
import Combine

enum APIError : Error {
    case offline(String)
    case error(String)
    case notParable(String)
}

class APIManager {
    
    /// Custom header field
    var header  = ["Content-Type":"application/json"]
    
    static let shared:APIManager = {
        let instance = APIManager()
        return instance
    }()
    
    let sessionManager:SessionManager
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 600
        configuration.timeoutIntervalForResource = 600    
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func callRequest<Response>(_ router: APIRouter, parseTo: Response.Type) -> AnyPublisher<Response, APIError> where Response: Decodable{
        Future { promise in
            guard Application.reachability.isReachable == true else {
                promise(.failure(.offline("Your internet connection seems to be offline")))
                return
            }
            let path = router.path
            let parameter = router.parameters
            var encoding: ParameterEncoding = JSONEncoding.default
            if router.method == .get {
                encoding = URLEncoding.default
            }
            
            self.sessionManager.request(path, method: router.method, parameters: parameter, encoding: encoding, headers: self.header).responseData { response in
                switch response.result{
                case .success:
                    if let data = response.data{
                        if let responseObj = try? JSONDecoder().decode(Response.self, from: data){
                            return promise(.success(responseObj))
                        }
                    }
                    return promise(.failure(.notParable("Can not parse data")))
                case .failure(let error):
                    DispatchQueue.main.async {
                        return promise(.failure(APIError.error(error.localizedDescription)))
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    //MARK:- Cancel Requests
    
    func cancelAllTasks() {
        self.sessionManager.session.getAllTasks { tasks in
            tasks.forEach {
                $0.cancel()
            }
        }
    }
    
    func cancelRequests(url: String) {
        self.sessionManager.session.getTasksWithCompletionHandler
            {
                (dataTasks, uploadTasks, downloadTasks) -> Void in
                
                self.cancelTasksByUrl(tasks: dataTasks     as [URLSessionTask], url: url)
                self.cancelTasksByUrl(tasks: uploadTasks   as [URLSessionTask], url: url)
                self.cancelTasksByUrl(tasks: downloadTasks as [URLSessionTask], url: url)
        }
    }
    
    private func cancelTasksByUrl(tasks: [URLSessionTask], url: String) {
        
        for task in tasks {
            if task.currentRequest?.url?.absoluteString == url {
                task.cancel()
            }
        }
    }
    
}
