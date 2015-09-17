//
//  DatabaseLoader.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 12/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//
//  This class uses the FMDB libary from https://github.com/ccgus/fmdb 
//  Which is licenced under the MIT Licence
//  Copyright (c) 2008-2014 Flying Meat Inc.

import Foundation
import UIKit

internal class DatabaseLoader: NSObject {

    var resourcesFolder:NSURL
    var path:String
    var database:FMDatabase!
    
    internal override init(){
        //resourcesFolder = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        do{
                self.resourcesFolder = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("museumDB", ofType: "")!)
                self.path = try String(contentsOfURL: self.resourcesFolder)
                self.database = FMDatabase(path: self.path)
        }
        catch let error as NSError{
            NSLog("%@", error.description)
            self.path = "ERROR"
            self.database = nil
        }
        super.init()
    }
  
    internal func openDatabase() -> Bool{
        // try to open the database
        if(!database.open()){
            NSLog("Database Not Opened")
            return false
        }
        else{
            NSLog("Database Opened Successfully YAY")
            //NSLog("DB Path %@", self.getDatabasePath())
            return true
        }

    }
    
    internal func closeDatabase() -> Bool{
        // try to close the database
        if(!database.close()){
            NSLog("Database Not Closed")
            return false
        }
        else{
            NSLog("Database Closed Successfully YAY")
            return true
        }
    }
    
    internal func queryDatabase(query: String) -> FMResultSet!{
        // try to open the database
        if(!openDatabase()){
            NSLog("Database could not be opened for queries")
            return nil
        }
        else{
            NSLog("Database opened for queries")
            // try to begin a transaction with the database
            if(!database.beginTransaction()){
                NSLog("Could not begin a database transaction")
                return nil
            }
            else{
                // try to query the database
                NSLog("Database transaction started succesfully")
                let results = database.executeQuery(query)
                if(results == nil){
                NSLog("Query Failed")
                    return nil
                }
                else{
                    // if the query was successful return the results
                    NSLog("Query Successful")
                    return results
                }
            }
        }
    }
    
    internal func getDatabasePath() -> NSString{
        return database.databasePath()!
    }
    
    func copyDatabase(){
        let storePath : NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last! // get the location of the documents directory
        let fileManager : NSFileManager = NSFileManager.defaultManager() // get the file manager
        var fileCopyError:NSError? = NSError(domain: "Local", code: 0, userInfo: nil) // create an error pointer
        if !fileManager.fileExistsAtPath((storePath as String) + "/museumDB" as String) { // check if the database already exists
            NSLog("Copying Database")
            let defaultStorePath : NSString! = NSBundle.mainBundle().pathForResource("museumDB", ofType: "") // get the default location of the database when the app was first installed
            if((defaultStorePath) != nil) { // if the database exists within the original location
                do {
                    try fileManager.copyItemAtPath(defaultStorePath as String, toPath: storePath as String)
                } catch let error as NSError {
                    fileCopyError = error
                } // copy it to the documents folder
            }
        }
        else{
            NSLog("Database Already Exists")
        }
    
}
}