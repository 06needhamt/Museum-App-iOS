//
//  QuestionManager.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 16/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import UIKit

class QuestionManager: NSObject {
    var steps:[TrailStepInfo!] = []
    var question: TrailStepInfo!
    var questionNum:Int = 0
    var answerNum:Int = 0
    var trailEnded:Bool = false
    var maincontroller:HomeViewController!
    private var multiChoiceController:MultiChoiceController!
    private let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)

    
    required init(trailSteps:[TrailStepInfo!],home:HomeViewController!){
        steps = trailSteps
        maincontroller = home
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
            callMultiChoice("multiChoiceController")
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
    
    internal func callMultiChoice(identifier:String){ // now thats what i call a call bridge
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        multiChoiceController = (storyBoard.instantiateViewControllerWithIdentifier(identifier)) as! MultiChoiceController?
        if(multiChoiceController == nil){
            NSLog("Multi Choice Controller = NIL")
            return
        }
        let sourceViewController = maincontroller
        if(sourceViewController == nil){
            NSLog("Source view controller == NIL")
            return
        }
        multiChoiceController!.setParentController(sourceViewController)
        multiChoiceController.setQuestionManager(self)
        sourceViewController.presentViewController(multiChoiceController!, animated: true, completion: nil)
        appDelegate.window?.rootViewController = multiChoiceController        
        
    }
    
    internal func dismiss(controller:UIViewController){
        controller.dismissViewControllerAnimated(true, completion: nil)
        appDelegate.window?.rootViewController = maincontroller
        
    }
    
}
