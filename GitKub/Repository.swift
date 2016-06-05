//
//  Repository.swift
//  KBTGTest
//
//  Created by golfiti on 6/3/2559 BE.
//  Copyright © 2559 Kridsanapong Wongthongdee. All rights reserved.
//

import Foundation
import Alamofire
import PKHUD

public class Singleton {
    
    class var sharedInstance: Singleton {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Singleton? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Singleton()
        }
        return Static.instance!
    }
    
    func fetchGitRepo(gitUsername:String!,completion: (result: AnyObject)->Void){
        Alamofire.request(.GET, GitHubBaseURL + gitUsername + "/repos", parameters:nil)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    if response.result.value?.count == 0{
                        HUD.flash(.Progress)
                        showAlert("No Repository")
                        return
                    }
                    else if let JSON = response.result.value {
                        completion(result: JSON)
                    }
                case .Failure(let error):
                    HUD.flash(.Progress)
                    showAlert("\(error.localizedDescription)")
                    print(error)
                }
        }
    }
}


