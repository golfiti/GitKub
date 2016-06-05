//
//  RepoDetailViewController.swift
//  KBTGTest
//
//  Created by Kridsanapong Wongthongdee on 6/3/2559 BE.
//  Copyright © 2559 Kridsanapong Wongthongdee. All rights reserved.
//

import UIKit
import Alamofire
import EECellSwipeGestureRecognizer

class RepoDetailViewController: UIViewController{
    
    // MARK:Variable
    @IBOutlet var repoTableView: UITableView!
    @IBOutlet var collectionview: UICollectionView!

    @IBOutlet weak var lbl_repo_name: UILabel!
    @IBOutlet weak var lbl_repo_url: UILabel!

    @IBOutlet weak var txtView_repo_detail: UITextView!

    var cellTrigger:Int = 0;

    // MARK:Init
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = allRepos[0]["owner"]!!["login"] as? String
        
        // Collection appearance
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top:1,left:10,bottom:10,right:10)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 10
        
        collectionview.collectionViewLayout = layout
        collectionview.backgroundColor = UIColor.clearColor()
        self.collectionview.hidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: Table View
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRepos.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.repoTableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        let repo = allRepos[indexPath.row] as AnyObject
        cell.textLabel?.text = repo["name"] as? String

        let slideGestureRecognizer: EECellSwipeGestureRecognizer = EECellSwipeGestureRecognizer()
        
        let rightPushAction: EECellSwipeAction = EECellSwipeAction(fraction: 0.30)
        rightPushAction.icon = UIImage(named: "circle")!
        rightPushAction.activeBackgroundColor = UIColor.myGreenColor()
        rightPushAction.behavior = .Pull
        rightPushAction.didTrigger = { (tableView, indexPath) in
            
            self.lbl_repo_name.text = repo["name"] as? String
            self.lbl_repo_url.text = repo["html_url"] as? String
            self.txtView_repo_detail.text = repo["description"] as? String
            self.cellTrigger = indexPath.row
            self.collectionview.hidden = false
            [self.collectionview .reloadData()]
            
        }
        
        let leftPullAction: EECellSwipeAction = EECellSwipeAction(fraction: -0.30)
        leftPullAction.icon = UIImage(named: "circle")!
        leftPullAction.activeBackgroundColor = UIColor.myGreenColor()
        leftPullAction.behavior = .Pull
        leftPullAction.didTrigger = { (tableView, indexPath) in

            self.lbl_repo_name.text = repo["name"] as? String
            self.lbl_repo_url.text = repo["html_url"] as? String
            self.txtView_repo_detail.text = repo["description"] as? String
            self.cellTrigger = indexPath.row
            self.collectionview.hidden = false
            [self.collectionview .reloadData()]

        }
        
        slideGestureRecognizer.addActions([rightPushAction, leftPullAction])
        cell.addGestureRecognizer(slideGestureRecognizer)
        cell.selectionStyle = .None

        return cell
    }
    
    

    // MARK: CollectionView

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
         let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! CustomCell
        
        // Collection appearance
        let bcolor : UIColor = UIColor( red: 0.2, green: 0.2, blue:0.2, alpha: 0.3 )
        cell.layer.borderColor = bcolor.CGColor
        cell.layer.borderWidth = 0.5
        cell.backgroundColor=UIColor.whiteColor()
        
        let repo = allRepos[self.cellTrigger] as AnyObject
        
        if indexPath.section == 0 {
            
            let starInt : Int = (repo["stargazers_count"] as? Int)!
            let starString = "\(starInt)"
            
            let watchInt : Int = (repo["watchers_count"] as? Int)!
            let watchString = "\(watchInt)"
            
            let forksInt : Int = (repo["forks_count"] as? Int)!
            let forksString = "\(forksInt)"

            cell.layer.cornerRadius = 3
            
            switch indexPath.row {
            case 0:
                cell.value.text = starString
                cell.title.text = "Stars"
                break;
            case 1:
                cell.value.text = watchString
                cell.title.text = "Watchers"
                break
            case 2:
                cell.value.text = forksString
                cell.title.text = "Forks"
                break
            default:
                break
            }
        }else{
            
            let sizeInt : Double = (repo["size"] as? Double)!
            var sizeString:String = ""
            if sizeInt >= 1000 {
                 sizeString = ("\(sizeInt/1000) MB")
            }
            else{
                sizeString = ("\(sizeInt) KB")
            }

            let issueInt : Int = (repo["open_issues"] as? Int)!
            let issueString = "\(issueInt)"
            
            
            switch indexPath.row {
            case 0:
                cell.value.text = repo["language"] as? String
                cell.title.text = "Language"
                break;
            case 1:
                cell.value.text = sizeString
                cell.title.text = "Size"
                break
            case 2:
                var update = repo["updated_at"] as? String
                if let rangeOfZero = update!.rangeOfString("T",options: NSStringCompareOptions.BackwardsSearch) {
                    update = String(update!.characters.prefixUpTo(rangeOfZero.startIndex))
                }
                cell.value.text = update
                cell.title.text = "Updated at"
                break
            case 3:
                cell.value.text = issueString
                cell.title.text = "Open Issues"
            default:
                break
            }

        }
        return cell
    }
    

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 3
        } else {
            return 4
        }
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width:95, height:50)
        default:
            return CGSize(width:(self.collectionview.bounds.width-25)/2, height: 50)
        }
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(CGRectGetWidth(collectionView.bounds),0.0)
    }
    
}

// MARK:Custom Cell
class CustomCell: UICollectionViewCell {
    @IBOutlet var value: UILabel!
    @IBOutlet var title: UILabel!
}
