//
//  ViewController.swift
//  Risky-Buisiness-Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 11/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var BackgroundImage: UIImageView!
    @IBOutlet weak var Button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        delete(BackgroundImage)
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func ButtonClicked(sender: AnyObject) {
        
    }
}

