//
//  TrailInfo.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 16/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation

class TrailInfo: NSObject {
    private let Trailid:Int
    private let Exhibitid:Int
    private let Trailname: String
    private let Traildescription:String
    private let Trailtype: TrailType
    
    required init(data: FMResultSet){
        Trailid = data.stringForColumn("_id").toInt()!
        Exhibitid = data.stringForColumn("tra_exhibitID").toInt()!
        Trailname = data.stringForColumn("tra_name")
        Traildescription = data.stringForColumn("tra_description")
        Trailtype = TrailType(rawValue: data.stringForColumn("tra_type").toInt()!)!
        data.close()
        super.init()
    }
    
    internal func getTrailID() -> Int{
        return Trailid
    }
    
    internal func getExhibitID() -> Int{
        return Exhibitid
    }
    
    internal func getTrailName() -> String{
        return Trailname
    }
    
    internal func getTrailDescription() -> String{
        return Traildescription
    }
    
    internal func getTrailtype() -> TrailType{
        return Trailtype
    }
}
