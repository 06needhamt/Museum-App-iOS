//
//  HomeViewController.swift
//  Risky-Buisiness-Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 11/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import UIKit

public class HomeViewController : UIViewController {
    
    var contentController: HomePageContentContainer?
    var TopButtonsController : TopButtonContainer?
    var BottomButtonsController : BottomButtonContainer?
    
    @IBOutlet weak var AquariumContentController: UIView!
    @IBOutlet weak var MainContentContainer: UIView!
    @IBOutlet weak var TopButtonsContentContainer: UIView!
    @IBOutlet weak var BottomButtonsContentContainer: UIView!
    
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.childViewControllers
        let controllers = self.childViewControllers // get references to the child view controllers
        for var i = 0; i < controllers.count; i+=1{
            NSLog("i = : %i", i)
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
        NSLog("Home View Controller Loaded")
        self.MainContentContainer.hidden = false
        self.AquariumContentController.hidden = true;
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        delete(contentController)
        delete(TopButtonsController)
        delete(BottomButtonsController)
    }
}
