//
//  AppInfoController.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 28/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import UIKit

class AppInfoController: UIViewController {
    
    @IBOutlet weak var WebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let webPagePath = NSBundle.mainBundle().pathForResource("webpages/AppInfo-4", ofType: ".html")!
        let url:NSURL! = NSURL(fileURLWithPath: webPagePath)
        if(url == nil){
            NSLog("URL == NIL")
            return
        }
        let request:NSURLRequest! = NSURLRequest(URL: url!)
        if(request == nil){
            NSLog("Request == NIL")
        }
        WebView.backgroundColor = UIColor(white: 1, alpha: 0)
        WebView.loadRequest(request!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
