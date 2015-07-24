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
    var containerViews:[(UIView!,String)] = [(nil,"")]
    var questionManager:QuestionManager! = nil
    var trailManager:TrailManager! = nil
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
//         containerViews.removeAll(keepCapacity: true)
//         containerViews.append((AquariumContentController,"Aquarium")) // what the f**k apple why cant we add protocol object optionals to an array ???
        }
        TopButtonsController?.parent = self
        BottomButtonsController?.parent = self
        questionManager = instantiateQuestionManager()
        trailManager = instantiateTrailManager()
        NSLog("Home View Controller Loaded")
        self.MainContentContainer.hidden = false
        self.AquariumContentController.hidden = true
        self.QRContentContainer.hidden = true
        self.BugsContentController.hidden = true
        //questionManager.callMultiChoice("multiChoiceController")
        questionManager.callSingleAnswer("singleAnswerController")
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
    
   
}
