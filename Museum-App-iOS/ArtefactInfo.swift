//
//  ArtefactInfo.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 16/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation

class ArtefactInfo: NSObject {
    let artefactID:Int
    let artefactName:String
    let artefactDescription:String
    let artefactImageName:String
    let artefactNo:String
    let artefactExhibitID:Int
    var artefactTrailStatus:Int = 0
    var artefactFloor:Int = 0
    
    required init(data: FMResultSet) {
        artefactID = Int(data.stringForColumn("_id"))!
        artefactName = data.stringForColumn("art_name")
        artefactDescription = data.stringForColumn("art_description")
        artefactImageName = data.stringForColumn("art_image")
        artefactNo = data.stringForColumn("art_museumNo")
        artefactExhibitID = Int(data.stringForColumn("art_exhibitID"))!
        data.close()
        super.init()
    }
    
    internal func getArtefactID() -> Int{
        return artefactID
    }
    
    internal func getArtefactName() -> String{
        return artefactName
    }
    
    internal func getArtefactDescription() -> String{
        return artefactDescription
    }
    
    internal func getArtefactImageName() -> String{
        return artefactImageName
    }
    
    internal func getArtefactMuseumNumber() -> String{
        return artefactNo
    }
    
    internal func getExhibitID() -> Int{
        return artefactExhibitID
    }
    
    internal func getTrailStatus() -> Int{
        return artefactTrailStatus
    }
    internal func getFloor() -> Int{
        return artefactFloor
    }
    
    internal func setTrailStatus(status: Int){
        artefactTrailStatus = status
    }
    
    internal func setFloor(status: Int){
        artefactTrailStatus = status
    }
}
