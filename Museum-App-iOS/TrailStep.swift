//
//  TrailStep.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 16/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation

class TrailStep: NSObject {
    let stepID:Int
    let trailID:Int
    let questionType:QuestionType
    let question:String
    let answer:String
    let QRCode:String
    let image:String
    
    let STEPID_COL:Int32 = 0
    let TRAILID_COL:Int32 = 1
    let QTYPE_COL:Int32 = 2
    let QUESTION_COL:Int32 = 3
    let ANSWER_COL:Int32 = 4
    let QRCODE_COL:Int32 = 5
    let IMAGE_COL:Int32 = 6
    
    required init(data:FMResultSet){
        stepID = Int(data.stringForColumnIndex(STEPID_COL))!
        trailID = Int(data.stringForColumnIndex(TRAILID_COL))!
        questionType = QuestionType(rawValue: Int(data.stringForColumnIndex(QTYPE_COL))!)!
        question = data.stringForColumnIndex(QUESTION_COL)
        answer = data.stringForColumnIndex(ANSWER_COL)
        QRCode = data.stringForColumnIndex(QRCODE_COL)
        image = data.stringForColumnIndex(IMAGE_COL)
        super.init()
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
    
    internal func getQRCode() -> String{
        return QRCode
    }
    
    internal func getImage() -> String{
        return image
    }
    
}
