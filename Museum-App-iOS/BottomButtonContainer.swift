//
//  BottomButtonContainer.swift
//  Risky-Buisiness-Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 11/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import UIKit

public class BottomButtonContainer : UIViewController  {
    var BottomButtons: [UIButton] = [UIButton]();
    var parent: HomeViewController?
    let NUM_BUTTONS:CGFloat = 5
    
    required public init(coder aDecoder: NSCoder) {
        //parent = HomeViewController(coder: aDecoder)
        super.init(coder: aDecoder);
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        parent = getParent() as? HomeViewController
        for var i:CGFloat = 0; i < NUM_BUTTONS; i++
        {
            self.view.addSubview(CreateButton(i))
        }
        
        //Cont.addSubview(CreateButton(CGFloat(1)))
        NSLog("Bottom buttons Loaded")
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func CreateButton(index:CGFloat) -> UIButton{
        let Viewwidth: CGFloat = self.view.bounds.width
        let Viewheight: CGFloat = self.view.bounds.height
        
        var button = UIButton(frame: CGRect(x: Viewwidth / NUM_BUTTONS * index, y:CGFloat(0.0), width: Viewwidth / NUM_BUTTONS, height: Viewheight))
        if(index % 2 == 0){
            button.backgroundColor = UIColor.blueColor()
        }
        else
        {
            button.backgroundColor = UIColor.whiteColor()
        }
        button.addTarget(self, action:"ButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        BottomButtons.append(button);
        return button
    }
    private func ButtonClicked(sender: UIButton){
        for var i:Int = 0; i < BottomButtons.count; i++
        {
            if(BottomButtons[i] == sender){
                NSLog("Button %i Was Pressed", i)
                switch(i){
                case 0 :
                    break
                case 1:
                    break
                case 2:
                    break
                case 3:
                    parent!.TopButtonsController!.LoadMapButtons();
                    break
                case 4:
                    break
                default:
                    NSLog("Invalid Button Index: %i", i)
                    break
                }
            }
        }
        
    }
    
    public func getParent() -> UIViewController?{
        return self.presentingViewController
    }
    public func resetButtons(index:Int){
        for var i = 0; i < BottomButtons.count; i+=1{
            if(i == index){
                continue
            }
            else{
                // todo reset button images
            }
        }
    }
}
