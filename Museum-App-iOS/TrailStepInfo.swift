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
        stepID = data.stringForColumn("_id").toInt()!
        trailID = data.stringForColumn("stp_trailID").toInt()!
        questionType = QuestionType(rawValue: data.stringForColumn("stp_questionType").toInt()!)!
        question = data.stringForColumn("stp_question")
        answer = data.stringForColumn("stp_answer")
        QRCode = data.stringForColumn("stp_qrCode").toInt()!
        imageName = data.stringForColumn("stp_image")
        multiChoiceAnswers = TrailStepInfo.parseMultiChoiceAnswers(answer as NSString)
        super.init()
    }
    
    private class func parseMultiChoiceAnswers(answerString:NSString) -> [String]{
        var answers:[String]
        answers = answerString.componentsSeparatedByString(",") as! [String]
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
