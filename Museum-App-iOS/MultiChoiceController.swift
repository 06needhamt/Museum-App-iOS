//
//  MultiChoiceController.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 21/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import UIKit

class MultiChoiceController: UIViewController {
    
    var parent:HomeViewController!
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parent = getParentController()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    internal func getParentController() -> HomeViewController{
        return parent
    }
    
    internal func setParentController(controller:HomeViewController){
        parent = controller
    }
}
