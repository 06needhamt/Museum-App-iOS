//
//  TrailManager.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 14/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import UIKit

internal class TrailManager: NSObject {
    static var activeInstance: TrailManager! = nil
    var database:DatabaseLoader
    var mode:Modes
    var currentTrail:TrailInfo! = nil
    var currentArtefact:ArtefactInfo! = nil
    var onTrail:Bool = false
    var trailList:[TrailInfo!] = []
    var trailSteps:[TrailStepInfo!] = []
    
    private override init() {
        database = DatabaseLoader()
        database.openDatabase()
        mode = Modes.Browse
        
        super.init()
    }
    
    class internal func getInstance() -> TrailManager! {
        if(TrailManager.activeInstance == nil){
            TrailManager.activeInstance = TrailManager()
        }
        return TrailManager.activeInstance
    }
    
    internal func clearData(){
        mode = Modes.Browse
        currentTrail = nil
        trailList = []
        trailSteps = []
        
    }
    
    internal func browseArtefactID(id:Int) -> ArtefactInfo!{
        var artefact:ArtefactInfo!
        //TrailType(rawValue: Int(artefact.getTrailStatus() | Int(t.getTrailtype().rawValue.value)))
        artefact = getDatabaseArtefact(id)
        if(getArtefactTrails(id, trailtype: TrailType.NormalAndExplorer) != NSNull()){
            for t in trailList{
                artefact.setTrailStatus(Int(TrailType(rawValue: Int(artefact.getTrailStatus()) | Int(t.getTrailtype().rawValue.value))!.rawValue.value))
                NSLog("%i Trails Found", trailList.count)
            }
        }
        else{
            NSLog("No Trails found")
        }
        currentArtefact = artefact
        return currentArtefact
    }
    
    internal func checkArtefact(id:Int) -> Int{
        if(mode != Modes.OnTrail){
            return 0
        }
        
        for s in trailSteps{
            if(s.QRCode == id){
                return 1
            }
        }
        return -1
    }
    
    internal func isArtefactInExhibit(id:Int) -> Bool{
        let artefact:ArtefactInfo! = browseArtefactID(id)
        
        if(mode != Modes.OnTrail){
            return false
        }
        
        if(artefact.getExhibitID() == currentTrail.getExhibitID()){
            return true
        }
        return false
    }
    
    internal func setTrail(id:Int) -> Bool{
        //clearData()
        currentTrail = nil
        mode = Modes.Browse
        var trailFound:Bool = false
        
        if(trailList.count != 0){
            for var t = 0; t < trailList.count; t+=1{
                if(trailList[t].getTrailID() == id){
                    currentTrail = trailList[t]
                    trailFound = true
                }
            }
        }
        
        if(!trailFound){
            clearData()
        }
        
        if(getTrail(id)){
            currentTrail = trailList[0]
        }
        else{
            return false
        }
        
        mode = Modes.OnTrail
        trailFound = getTrailSteps(id)
        return trailFound
    }
    internal func getTrailSteps(id:Int) -> Bool{
        var results:FMResultSet!
        var resultString:String
        
        trailSteps = []
        
        let query:String = "SELECT _id AS stp_trailStepID, * FROM trailStep WHERE stp_trailID = " + String(id)
        database.openDatabase()
        results = database.queryDatabase(query)
        
        if(results == nil){
            NSLog("No trail steps found for trail: %i" ,id)
            return false
        }
        
        repeat{
            trailSteps.append(TrailStepInfo(data: results))
            
        } while(results.next())
        results.close()
        database.closeDatabase()
        return true
    }
    internal func getTrail(id:Int) -> Bool{
        var trail:TrailInfo! = nil
        
        let queryString:String = "SELECT _id AS tra_trailID FROM trail WHERE tra_trailID = " + String(id)
        
        if(!getDatabaseTrails(queryString)){
            NSLog("No Trail Found with ID: %i", id)
            return false
        }
        return true
    }
    internal func getDatabaseArtefact(id:Int) -> ArtefactInfo!{
        var results:FMResultSet!
        var artefact:ArtefactInfo!
        let queryString:String = "SELECT _id as art_artefactID, * FROM artefact WHERE artefact._id = " + String(id)
        results = database.queryDatabase(queryString)
        
        if(results == nil){
            NSLog("Query Failed or no such artefact %i", id)
        }
        else{
            artefact = ArtefactInfo(data: results)
        }
        results.close()
        return artefact
        
    }
    
    internal func getArtefactTrails(id:Int, trailtype:TrailType) -> [TrailInfo!]{
        var querystring:String = "SELECT trail._id as " + "tra_trailID" + ", * FROM trail " +
            "JOIN trailstep ON trail._id = trailStep.stp_trailID AND trailStep.stp_qrCode = " + String(id)
        
        if(trailtype == TrailType.Normal){
            querystring += " and trail.tra_trailType = 0"
        }
        else if(trailtype == TrailType.Explorer){
            querystring += "and trail.tra_trailType = 1"
        }
        
        if(!getDatabaseTrails(querystring)){
            NSLog("Query Failed or no trails Found of type %i", id)
            trailList = []
        }
        return trailList
    }
    
    internal func getDatabaseTrails(query:String) -> Bool{
        //var database:DatabaseLoader
        var results:FMResultSet!
        var resultString:String
        
        trailList = []
        //database = DatabaseLoader()
        database.openDatabase()
        results = database.queryDatabase(query);
        
        if(results == nil){
            return false
        }
        
        repeat{
            let trail:TrailInfo = TrailInfo(data: results)
            trailList.append(trail)
        } while(results.next())
        results.close()
        database.closeDatabase()
        return true
    }
    
}
