//
//  ViewController.swift
//  KBTGTest
//
//  Created by Kridsanapong Wongthongdee on 6/3/2559 BE.
//  Copyright © 2559 Kridsanapong Wongthongdee. All rights reserved.
//

import UIKit
import PKHUD

let GitHubBaseURL = "https://api.github.com/users/"

public var allRepos:AnyObject = []

class ViewController: UIViewController {
    
    @IBOutlet weak var txt_gitUsername: UITextField!
    @IBOutlet weak var btn_getRepo: UIButton!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        txt_gitUsername.becomeFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btn_getRepo.backgroundColor = UIColor.myGreenColor();
        btn_getRepo.layer.cornerRadius = 6
        
    }
    
    @IBAction func getRepo(sender: AnyObject) {
        
        if self.txt_gitUsername.text?.characters.count == 0{
            showAlert("Please enter GitHub username")
            return;
        }
        txt_gitUsername.resignFirstResponder()
        HUD.show(.Progress)
        Singleton.sharedInstance.fetchGitRepo(txt_gitUsername.text) { (result) in
            
            allRepos = result
            
            // go profile detail (nav)
            if let repoDetailVC = self.storyboard?.instantiateViewControllerWithIdentifier("RepoDetailViewController") as? RepoDetailViewController {
                self.navigationController!.pushViewController(repoDetailVC, animated: true)
                HUD.flash(.Progress)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

