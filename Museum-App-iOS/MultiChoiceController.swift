//
//  MultiChoiceController.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 21/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import UIKit

class MultiChoiceController: UIViewController {
    
    private var parent:HomeViewController!
    private var manager:QuestionManager!
    
    @IBOutlet weak var Dismiss: UIButton!

    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parent = getParentController()
        NSLog("MultiChoiceController Loaded")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func getParentController() -> HomeViewController{
        return parent
    }
    
    internal func setParentController(controller:HomeViewController){
        parent = controller
    }
    @IBAction func DismissClicked(sender: UIButton) {
        manager.dismiss(self as UIViewController)
        NSLog("Controller Dismissed")
    }
    
    internal func setQuestionManager(manager:QuestionManager!){
        self.manager = manager
    }
    
    internal func getQuestionManager() -> QuestionManager!{
        return manager
    }
}
