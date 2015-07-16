//
//  QuestionManager.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 16/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation

class QuestionManager: NSObject {
    var steps:[TrailStepInfo!] = []
    var question: TrailStepInfo!
    var questionNum:Int = 0
    var answerNum:Int = 0
    var trailEnded:Bool = false
    
    required init(trailSteps:[TrailStepInfo!]){
        steps = trailSteps
    }
    
    internal func nextQuestion() -> Bool{
        if(trailEnded){
            if(questionNum == steps.count){
                //FIXME Load Result Screen
            }
            return true
        }
        question = steps[questionNum]
        
        switch(Int(question.getQuestionType().rawValue.value)){ // wtf why cant we use Int64 in switch case so we have to pointlessly cast to int first what the f**k
        case Int(QuestionType.Normal.rawValue.value):
            // FIXME call single answer
            break
            
        case Int(QuestionType.MultiChoice.rawValue.value):
            // FIXME call multi choice
            break
        case Int(QuestionType.Picture.rawValue.value):
            // FIXME call picture
            break
        case Int(QuestionType.PictureMultiChoice.rawValue.value):
            //FIXME call Picture Multi Choice
            break
        default:
            NSLog("Invalid Question Type")
        }
        questionNum += 1
        if(questionNum >= steps.count){
            trailEnded = true
        }
        return trailEnded
    }
    
    internal func recieveData(score: Int) -> Int{
        return score
    }
    
    internal func hasTrailEnded() -> Bool{
        return trailEnded
    }
    
    internal func setHasTrailEnded(ended:Bool){
        trailEnded = ended
    }
    
    internal func getTrailSteps() -> [TrailStepInfo!]{
        return steps
    }
    
    internal func setTrailSteps(steps:[TrailStepInfo!]){
        self.steps = steps
    }
    
    internal func getQuestionNumber() -> Int{
        return questionNum
    }
    
    internal func setQuestionNumber(num:Int){
        questionNum = num
    }
    
}

public func -=(left: Int64,right: Int64) -> Int64{
        var result = left
        result = result - right
        return result
    }

