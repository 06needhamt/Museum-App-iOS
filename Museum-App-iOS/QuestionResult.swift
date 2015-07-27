//
//  QuestionResult.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 27/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation

class QuestionResult: NSObject {

    private let Score:Int
    private let EndofTrail:Bool
    private let Skipped:Bool
    
    required init(score:Int, endofTrail:Bool, skipped:Bool){
        self.Score = score
        self.EndofTrail = endofTrail
        self.Skipped = skipped
    }
    
    internal func getScore() -> Int{
        return self.Score
    }
    
    internal func getEndOfTrail() -> Bool{
        return self.EndofTrail
    }
    
    internal func getSkipped() -> Bool{
        return self.Skipped
    }
}
