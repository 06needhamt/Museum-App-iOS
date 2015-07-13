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
        let databasehelper: DatabaseLoader = DatabaseLoader() // create an instance of the database loader class to preform operations on the database
        databasehelper.copyDatabase() // copy the database to the documents folder which thanks to the ba****ds at apple moves evry time the app is installed in the emulator so need to find a permenent home done

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
    

    
}

