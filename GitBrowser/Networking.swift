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

public class NetworkManager {
   
    private struct GitHubAPI {
        private static let base = "https://api.github.com/"
        private static func activityURL(forUser: User) -> String {
            return base + "users\(forUser.username)/received_events"
        }
    }
    
    public enum NetworkError: ErrorType {
        case ParseFailure, Error(NSError)
    }
    private typealias JSONDictionary = [String:AnyObject]
    
    public static let sharedManager = NetworkManager()
    
    func fetchActivity(forUser user: User) -> SignalProducer<[Activity], NetworkError> {

        return SignalProducer { observer, disposable in
         
            Alamofire.request(.GET, GitHubAPI.activityURL(user), parameters: nil, encoding: ParameterEncoding.URL, headers: nil)
                
                .responseJSON(options: .MutableContainers, completionHandler: { response in
          
                switch response.result {
                case .Failure(let error): observer.sendFailed(.Error(error)); print(error)
                case .Success(let json):
                    
                    guard let activityArray = json as? [JSONDictionary] else { return observer.sendFailed(NetworkError.ParseFailure )}
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
            guard let url = NSURL(string: repo.url) else { return observer.sendFailed(NetworkError.ParseFailure)}
            Alamofire.request(.GET, url).responseJSON(options: NSJSONReadingOptions.MutableContainers, completionHandler: { response in
                switch response.result {
                case .Success(let jsonDict):
                    guard let repoDeets = jsonDict as? [String:AnyObject] else { return observer.sendFailed(NetworkError.ParseFailure)}
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