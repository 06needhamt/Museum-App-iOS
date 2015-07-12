//
//  ViewController.swift
//  Risky-Buisiness-Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 11/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        delete(BackgroundImage)
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ButtonClicked(sender: AnyObject) {
        testDatabase()
    }
    
    func testDatabase(){
        copyDatabase()
        let databasehelper: DatabaseLoader = DatabaseLoader()
        databasehelper.openDatabase()
        databasehelper.queryDatabase("SELECT * FROM trail")
        databasehelper.closeDatabase()
        NSLog("Database Working")
    }
    
    func copyDatabase(){
        let storePath : NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last as! String
        let fileManager : NSFileManager = NSFileManager.defaultManager()
        var fileCopyError:NSError? = NSError()
        if !fileManager.fileExistsAtPath((storePath as String) + "/museumDB" as String) {
            NSLog("Copying Database")
            let defaultStorePath : NSString! = NSBundle.mainBundle().pathForResource("museumDB", ofType: "")
            if((defaultStorePath) != nil) {
                fileManager.copyItemAtPath(defaultStorePath as String, toPath: storePath as String, error: &fileCopyError)
            }
        }
        else{
            NSLog("Database Already Exists")
        }
    }
}

