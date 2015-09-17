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
    private var singleAnswerController:SingleAnswerController!
    private var pictureQuestionController:PictureQuestionController!
    private var pictureMultiChoiceController:PictureMultiChoiceController!
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
            callSingleAnswer("singleAnswerController")
            break
            
        case Int(QuestionType.MultiChoice.rawValue.value):
            callMultiChoice("multiChoiceController")
            break
        case Int(QuestionType.Picture.rawValue.value):
            callPictureQuestion("pictureQuestionController")
            break
        case Int(QuestionType.PictureMultiChoice.rawValue.value):
            
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
        multiChoiceController = (storyBoard.instantiateViewControllerWithIdentifier(identifier)) as! MultiChoiceController
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
    
    internal func callSingleAnswer(identifier:String){
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        singleAnswerController = (storyBoard.instantiateViewControllerWithIdentifier(identifier)) as! SingleAnswerController
        if(singleAnswerController == nil){
            NSLog("Single Answer Controller == NIL")
            return
        }
        let sourceViewController = maincontroller
        if(sourceViewController == nil){
            NSLog("Source View Controller == NIL")
            return
        }
        singleAnswerController!.SetParent(sourceViewController)
        singleAnswerController.SetQuestionManager(self)
        sourceViewController.presentViewController(singleAnswerController!, animated: true, completion: nil)
        appDelegate.window?.rootViewController = singleAnswerController
    }
    
    internal func callPictureQuestion(identifier:String){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        pictureQuestionController = (storyboard.instantiateViewControllerWithIdentifier(identifier)) as! PictureQuestionController
        if(pictureQuestionController == nil){
            NSLog("PictureQuestionController == NIL")
            return
        }
        let sourceViewController = maincontroller
        if(sourceViewController == nil){
            NSLog("PictureQuestionController == NIL")
            return
        }
        pictureQuestionController!.SetParent(sourceViewController)
        pictureQuestionController.setQuestionManager(self)
        sourceViewController.presentViewController(pictureQuestionController!, animated: true, completion: nil)
        appDelegate.window?.rootViewController = pictureQuestionController
        
    }
    
    internal func callPictureMultiChoice(identifier:String){
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        pictureMultiChoiceController = (storyboard.instantiateViewControllerWithIdentifier(identifier)) as! PictureMultiChoiceController
        if(pictureMultiChoiceController == nil){
            NSLog("pictureMultiChoiceController == NIL")
            return
        }
        let sourceViewController = maincontroller
        if(sourceViewController == nil){
            NSLog("pictureMultiChoiceController == NIL")
            return
        }
        pictureMultiChoiceController!.SetParent(sourceViewController)
        pictureMultiChoiceController.setQuestionManager(self)
        sourceViewController.presentViewController(pictureMultiChoiceController!, animated: true, completion: nil)
        appDelegate.window?.rootViewController = pictureMultiChoiceController
    }


    internal func dismiss(controller:UIViewController){
        controller.dismissViewControllerAnimated(true, completion: nil)
        appDelegate.window?.rootViewController = maincontroller

    }
}