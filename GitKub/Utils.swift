//
//  Utils.swift
//  KBTGTest
//
//  Created by golfiti on 6/4/2559 BE.
//  Copyright © 2559 Kridsanapong Wongthongdee. All rights reserved.
//

import UIKit

extension UIColor {
    class func myGreenColor() -> UIColor {
        return UIColor(red:0.01, green:0.70, blue:0.35, alpha:1.00)
    }
}

func showAlert(alert : String) -> Void {

    let alertController = UIAlertController(title: "GitKub", message: alert, preferredStyle: .Alert)
    let okButtonOnAlertAction = UIAlertAction(title: "Done", style: .Default)
    { (action) -> Void in }
    alertController.addAction(okButtonOnAlertAction)
    UIApplication.sharedApplication().windows.first!.rootViewController?.presentViewController(alertController, animated: true, completion: nil)
}

