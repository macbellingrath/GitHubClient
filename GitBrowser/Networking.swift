//
//  Networking.swift
//  Github Browser
//
//  Created by Mac Bellingrath on 1/21/16.
//  Copyright © 2016 Mac Bellingrath. All rights reserved.
//

import Foundation
import ReactiveCocoa
import Alamofire


//struct Owner {
//    let name: String
//    
//}
//struct Repo {
//    var name: String
//    var owner: Owner
//}

class NetworkManager {
    private let baseURL = "https://api.github.com/"
    
    static let sharedManager = NetworkManager()
    
    func fetchActivity(forUser user: User) -> SignalProducer<[Activity], NSError> {

        return SignalProducer { observer, disposable in
         

            Alamofire.request(.GET, self.baseURL + "users/\(user.username)/received_events", parameters: nil, encoding: ParameterEncoding.URL, headers: nil).responseJSON(options: .MutableContainers, completionHandler: { response in
                print(response.request)
                switch response.result {
                case .Failure(let error): observer.sendFailed(error); print(error)
                case .Success(let jsonDict):
                    guard let activityArray = jsonDict as? [[String:AnyObject]] else { return observer.sendFailed(NSError(domain: "networking", code: 01, userInfo: nil) )}
                    let activities = activityArray.flatMap{
                        Activity(fromDictionary: $0)
                    }
                 
                    observer.sendNext(activities)
                    observer.sendCompleted()


                }
            })
            
        }
    }
    
    
    func getImageFromURL(str
        : String) -> SignalProducer<UIImage, NSError> {
            return SignalProducer { observer, disposable in
        Alamofire.request(.GET, str).responseData { (response) in
            switch response.result {
            case .Failure(let error): observer.sendFailed(error)
            case .Success(let v):
                guard let img = UIImage(data: v) else { return observer.sendFailed(NSError(domain: "networkimage", code: 1, userInfo: nil))}
                observer.sendNext(img)
                observer.sendCompleted()
                
                }
            }
        }
    }
    
    
}