//
//  HomeViewController.swift
//  Risky-Buisiness-Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 11/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import UIKit

internal class HomeViewController : UIViewController {
    
    var contentController: HomePageContentContainer?
    var TopButtonsController : TopButtonContainer?
    var BottomButtonsController : BottomButtonContainer?
    
    @IBOutlet weak var AquariumContentController: UIView!
    @IBOutlet weak var MainContentContainer: UIView!
    @IBOutlet weak var TopButtonsContentContainer: UIView!
    @IBOutlet weak var BottomButtonsContentContainer: UIView!
    @IBOutlet weak var QRContentContainer: UIView!
    @IBOutlet weak var BugsContentController: UIView!
    @IBOutlet weak var AppInfoContentController: UIView!
    
    //var containerViews:[(UIView!,String)] = [(nil,"")]
    var Topcontainers = [UIView]()
    var BottomContainers = [UIView]()
    var MapContainers = [UIView]()
    var InformationContainers = [UIView]()
    var questionManager:QuestionManager! = nil
    var trailManager:TrailManager! = nil
    var lastQuestionResult:QuestionResult! = nil
    var questionResults:[QuestionResult!] = []
    
    required internal init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override internal func viewDidLoad() {
        super.viewDidLoad()
        self.childViewControllers
        let controllers = self.childViewControllers // get references to the child view controllers
        for var i = 0; i < controllers.count; i+=1{
            //NSLog("i = : %i", i)
            if(controllers[i].isKindOfClass(TopButtonContainer)){
                TopButtonsController = controllers[i] as? TopButtonContainer
            }
            else if(controllers[i].isKindOfClass(BottomButtonContainer)){
                BottomButtonsController = controllers[i] as? BottomButtonContainer
            }
            else if(controllers[i].isKindOfClass(HomePageContentContainer)){
                contentController = controllers[i] as? HomePageContentContainer
            }
            else{
                //NSLog("Unknown view Controller Type: %s", controllers[i].kind!!)
                continue
            }
        }
        questionManager = instantiateQuestionManager()
        trailManager = instantiateTrailManager()
        Topcontainers.append(AquariumContentController)
        Topcontainers.append(BugsContentController)
        BottomContainers.append(MainContentContainer)
        BottomContainers.append(MainContentContainer)
        BottomContainers.append(QRContentContainer)
        InformationContainers.append(AppInfoContentController)
        
        NSLog("Home View Controller Loaded")
        TopButtonsController?.parent = self
        BottomButtonsController?.parent = self

        for var i = 0; i < Topcontainers.count; i+=1{
            Topcontainers[i].hidden = true
        }
        for var i = 0; i < BottomContainers.count; i+=1{
            BottomContainers[i].hidden = true
        }
        for var i = 0; i < InformationContainers.count; i+=1{
            InformationContainers[i].hidden = true
        }
        self.MainContentContainer.hidden = false
        //questionManager.callMultiChoice("multiChoiceController")
        //questionManager.callSingleAnswer("singleAnswerController")
        //questionManager.callPictureQuestion("pictureQuestionController")
        //questionManager.callPictureMultiChoice("pictureMultiChoiceController")
    }
    
    override internal func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        delete(contentController)
        delete(TopButtonsController)
        delete(BottomButtonsController)
    }
    
    internal func instantiateQuestionManager() -> QuestionManager!{
        return QuestionManager(trailSteps: [], home: self);
    }
    
    internal func instantiateTrailManager() -> TrailManager!{
        return TrailManager.getInstance()
    }
    
    internal func SetLastQuestionResult(result:QuestionResult!){
        lastQuestionResult = result
        questionResults.append(result)
    }
    
    internal func getLastQuestionResult() -> QuestionResult!{
        return lastQuestionResult
    }
    
    internal func SetQuestionResults(results:[QuestionResult!]){
        questionResults = results
    }
    
    internal func getQuestionResults() -> [QuestionResult!]{
        return questionResults
    }
    
   
}
