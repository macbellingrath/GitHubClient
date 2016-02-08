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


enum NetworkError: ErrorType {
    case FailedToParse, Error(NSError)
}
class NetworkManager {
    
    private let baseURL = "https://api.github.com/"
    static let sharedManager = NetworkManager()
    
    func fetchActivity(forUser user: User) -> SignalProducer<[Activity], NetworkError> {

        return SignalProducer { observer, disposable in
         

            Alamofire.request(.GET, self.baseURL + "users/\(user.username)/received_events", parameters: nil, encoding: ParameterEncoding.URL, headers: nil).responseJSON(options: .MutableContainers, completionHandler: { response in
                print(response.request)
                switch response.result {
                case .Failure(let error): observer.sendFailed(.Error(error)); print(error)
                case .Success(let jsonDict):
                    guard let activityArray = jsonDict as? [[String:AnyObject]] else { return observer.sendFailed(NetworkError.FailedToParse )}
                    let activities = activityArray.flatMap {
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
    
    func getRepoDetail(forRepo repo: Repo) -> SignalProducer<RepoDetail, NetworkError> {
        return SignalProducer { observer, disposable in
            guard let url = NSURL(string: repo.url) else { return observer.sendFailed(NetworkError.FailedToParse)}
            Alamofire.request(.GET, url).responseJSON(options: NSJSONReadingOptions.MutableContainers, completionHandler: { response in
                switch response.result {
                case .Success(let jsonDict):
                    guard let repoDeets = jsonDict as? [String:AnyObject] else { return observer.sendFailed(NetworkError.FailedToParse)}
                    let repoDetail = RepoDetail(fromDictionary: repoDeets)
                    observer.sendNext(repoDetail)
                    observer.sendCompleted()
                
                case .Failure(let error):
                    observer.sendFailed(.Error(error)
                    )
                }
            })
        }
    }
    
}