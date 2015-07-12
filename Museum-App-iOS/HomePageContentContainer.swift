//
//  ContentContainer.swift
//  Risky-Buisiness-Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 11/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import UIKit

class HomePageContentContainer: UIViewController {
    
    var imageview: UIImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
    var image:UIImage? = UIImage(named: "Dinosaurs Icon Blue")
    override func viewDidLoad() {
        super.viewDidLoad()
        imageview.image = image
        self.view.addSubview(imageview)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
