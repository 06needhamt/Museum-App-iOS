//
//  TrailManager.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 14/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import UIKit

internal class TrailManager: NSObject {
    var activeInstance: TrailManager! = nil
    private override init() {
        super.init()
    }
    
    class internal func getInstance() -> TrailManager! {
        return TrailManager()
    }
}
