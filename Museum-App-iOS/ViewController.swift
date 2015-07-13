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
        testDatabase() // this code executes when before the seague is executed
    }
    
    func testDatabase(){
        copyDatabase() // copy the database to the documents folder which thanks to the ba****ds at apple moves evry time the app is installed in the emulator so need to find a permenent home
        let databasehelper: DatabaseLoader = DatabaseLoader() // create an instance of the database loader class to preform operations on the database
        databasehelper.openDatabase() // open the database
        let results = databasehelper.queryDatabase("SELECT * FROM trail") // run a query on the database
        while(results.next()){
            let data = results.stringForColumn("tra_name")
            NSLog("%@", data!)
        }
        results.close()
        databasehelper.closeDatabase() // close the database

        NSLog("Database Working") // if we didnt have an error here the database is working
    }
    
    func copyDatabase(){
        let storePath : NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last as! String // get the location of the documents directory
        let fileManager : NSFileManager = NSFileManager.defaultManager() // get the file manager
        var fileCopyError:NSError? = NSError() // create an error pointer
        if !fileManager.fileExistsAtPath((storePath as String) + "/museumDB" as String) { // check if the database already exists
            NSLog("Copying Database")
            let defaultStorePath : NSString! = NSBundle.mainBundle().pathForResource("museumDB", ofType: "") // get the default location of the database when the app was first installed
            if((defaultStorePath) != nil) { // if the database exists within the original location
                fileManager.copyItemAtPath(defaultStorePath as String, toPath: storePath as String, error: &fileCopyError) // copy it to the documents folder
            }
        }
        else{
            NSLog("Database Already Exists")
        }
    }
}

