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
    let BottomButtonNamesBlue:[String] = ["Trail Icon Blue", "Explorer Trail Icon Blue", "QR Icon Blue", "Map Icon Blue", "Information Icon Blue"]
    let BottomButtonNamesGreen:[String] = ["Trail Icon Green", "Explorer Trail Icon Green", "QR Icon Green", "Map Icon Green", "Information Icon Green"]
    
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
        let Viewheight: CGFloat = CGFloat(self.view.bounds.height / 8)
        let i:Int = Int(index);
        var button = UIButton(frame: CGRect(x: Viewwidth / NUM_BUTTONS * index, y:CGFloat(0.0), width: Viewwidth / NUM_BUTTONS, height: Viewheight))
        let image:UIImage? = UIImage(named: BottomButtonNamesBlue[i])
        if(image == nil){
            NSLog("Image is NIL")
        }
        else{
            NSLog("Image Loaded %@", BottomButtonNamesBlue[i])
        }
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        button.addTarget(self, action:"ButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        BottomButtons.append(button);
        return button
    }
    func ButtonClicked(sender: UIButton){
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
                    parent = getParent() as? HomeViewController
                    if(parent == nil){
                        NSLog("Parent is NIL")
                    }
                    parent!.TopButtonsController!.LoadMapButtons();
                    parent!.TopButtonsController!.updateButtons(-1, maps: true)
                    break
                case 4:
                    break
                default:
                    NSLog("Invalid Button Index: %i", i)
                    return
                }
                updateButtons(i)
            }
        }
        
    }
    
    public func getParent() -> UIViewController?{
        return self.presentingViewController
    }
    public func updateButtons(index:Int){
        for var i = 0; i < BottomButtons.count; i+=1{
            if(i == index){
                BottomButtons[i].setBackgroundImage(UIImage(named: BottomButtonNamesGreen[i]), forState: UIControlState.Normal)
            }
            else{
                BottomButtons[i].setBackgroundImage(UIImage(named: BottomButtonNamesBlue[i]), forState: UIControlState.Normal)
            }
        }
    }
}
