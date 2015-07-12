//
//  DatabaseLoader.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 12/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import UIKit

public class DatabaseLoader: NSObject {

    let resourcesFolder:String
    let path:String
    let database:FMDatabase
    
    public override init(){
        resourcesFolder = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0] as! String
        path = resourcesFolder.stringByAppendingPathComponent("museumDB")
        database = FMDatabase(path: path)
        super.init()
    }
  
    public func openDatabase() -> Bool{
        if(!database.open()){
            NSLog("Database Not Opened")
            return false
        }
        else{
            NSLog("Database Opened Successfully YAY")
            return true
        }

    }
    
    public func closeDatabase() -> Bool{
        if(!database.close()){
            NSLog("Database Not Closed")
            return false
        }
        else{
            NSLog("Database Closed Successfully YAY")
            return true
        }
    }
    
    public func queryDatabase(query: String) -> FMResultSet!{
        if(!openDatabase()){
            NSLog("Database could not be opened for queries")
            return nil
        }
        else{
            NSLog("Database opened for queries")
            if(!database.beginTransaction()){
                NSLog("Could not begin a database transaction")
                return nil
            }
            else{
                NSLog("Database transaction started succesfully")
                let results = database.executeQuery(query)
                if(results == nil){
                NSLog("Query Failed")
                    return nil
                }
                else{
                    NSLog("Query Successful")
                    return results
                }
            }
        }
    }
    
}
