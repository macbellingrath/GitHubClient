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


struct Owner {
    let name: String
    
}
struct Repo {
    var name: String
    var owner: Owner
}

class NetworkManager {
    private let baseURL = "https://api.github.com/"
    
    static let sharedManager = NetworkManager()
    
    func search(s: String) -> SignalProducer<[Repo], NSError> {

        return SignalProducer { observer, disposable in
           
            let params = [
                "q":s
            ]
            print(params)
            
            Alamofire.request(.GET, self.baseURL + "search/repositories", parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseJSON(options: .MutableContainers, completionHandler: { response in
                print(response.request)
                switch response.result {
                case .Failure(let error): observer.sendFailed(error); print(error)
                case .Success(let jsonDict):

        

                    guard let items = jsonDict["items"] as? [[String: AnyObject]] else { print("couldn't create repo");return observer.sendFailed(NSError(domain: "Network Manager", code: 400, userInfo: nil))}
                  
                
                    let repos = items.flatMap{ repoDict -> Repo? in
                        if let name = repoDict["name"] as? String,
                            let owner = repoDict["owner"] as? [String:AnyObject]? {
                        let r = Repo(name: name, owner: Owner(name: owner?["login"] as? String ?? "Mac"))
                            print("repo created: \(r)")
                        return r
                        }
                        return nil
                    }
                    observer.sendNext(repos)
                    observer.sendCompleted()
                }
            })
            
        }
    }
    
    
}