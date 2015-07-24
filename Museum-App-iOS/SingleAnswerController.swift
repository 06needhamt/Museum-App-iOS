//
//  SingleAnswerController.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 24/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import UIKit

class SingleAnswerController: UIViewController {

    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var Text: UITextView!
    var parent:HomeViewController!
    var manager:QuestionManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSLog("Single Answer controller loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    internal func SetParent(parent:HomeViewController){
        self.parent = parent
    }
    
    internal func GetParent() -> HomeViewController!{
        return self.parent
    }
    
    internal func GetQuestionManager() -> QuestionManager!{
        return self.manager
    }
    
    internal func SetQuestionManager(manager:QuestionManager){
        self.manager = manager
    }

}
