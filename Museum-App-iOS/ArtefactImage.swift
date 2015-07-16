//
//  ArtefactImage.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 16/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import UIKit
import Foundation

class ArtefactImage: NSObject {
    let name:String
    let image:UIImage!
    let path:String
    required init(name:String) {
        self.name = name
        path = NSBundle.mainBundle().pathForResource(name, ofType: ".jpg")!
        image = UIImage(contentsOfFile: path)
    }
    
    internal func getName() -> String{
        return name
    }
    
    internal func getImage() -> UIImage!{
        return image
    }
}
