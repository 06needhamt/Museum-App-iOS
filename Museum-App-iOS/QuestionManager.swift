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
        return true
//        switch(question.getQuestionType().rawValue.value){
//        case QuestionType.Normal.rawValue.value:
//            // FIXME call single answer
//            break
//            
//        case QuestionType.MultiChoice:
//            // FIXME call milti choice
//            break
//        }
    }
}

