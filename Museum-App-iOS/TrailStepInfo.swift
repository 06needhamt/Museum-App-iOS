//
//  TrailStepInfo.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 16/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation

class TrailStepInfo: NSObject {
    let stepID:Int
    let trailID:Int
    let questionType:QuestionType
    let question:String
    let answer: String
    let QRCode:Int
    let imageName:String
    let multiChoiceAnswers:[String]
    
    required init(data: FMResultSet) {
        stepID = Int(data.stringForColumn("_id"))!
        trailID = Int(data.stringForColumn("stp_trailID"))!
        questionType = QuestionType(rawValue: Int(data.stringForColumn("stp_questionType"))!)!
        question = data.stringForColumn("stp_question")
        answer = data.stringForColumn("stp_answer")
        QRCode = Int(data.stringForColumn("stp_qrCode"))!
        imageName = data.stringForColumn("stp_image")
        multiChoiceAnswers = TrailStepInfo.parseMultiChoiceAnswers(answer as NSString)
        super.init()
    }
    
    private class func parseMultiChoiceAnswers(answerString:NSString) -> [String]{
        var answers:[String]
        answers = answerString.componentsSeparatedByString(",") 
        return answers
    }
    
    internal func getStepID() -> Int{
        return stepID
    }
    
    internal func getTrailID() -> Int{
        return trailID
    }
    
    internal func getQuestionType() -> QuestionType{
        return questionType
    }
    
    internal func getQuestion() -> String{
        return question
    }
    
    internal func getAnswer() -> String{
        return answer
    }
    
    internal func getQRCode() -> Int{
        return QRCode
    }
    
    internal func getImageName() -> String{
        return imageName
    }
    
    internal func getMultiChoiceAnswers() -> [String]{
        return multiChoiceAnswers
    }
}
