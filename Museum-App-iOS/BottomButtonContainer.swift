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
        parent = getParent()
        for var i:CGFloat = 0; i < NUM_BUTTONS; i++
        {
            self.view.addSubview(CreateButton(i)) // create and add the buttons to the screen
        }
        
        //Cont.addSubview(CreateButton(CGFloat(1)))
        NSLog("Bottom buttons Loaded")
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func CreateButton(index:CGFloat) -> UIButton{
        let Viewwidth: CGFloat = self.view.bounds.width // get the width of the screen
        let Viewheight: CGFloat = CGFloat(self.view.bounds.height / 8) // get the height of the screen and divide it by 8 because the buttons use an eighth of the screen
        let i:Int = Int(index); // convert index to an int
        var button = UIButton(frame: CGRect(x: Viewwidth / NUM_BUTTONS * index, y:CGFloat(0.0), width: Viewwidth / NUM_BUTTONS, height: Viewheight)) // create the button with a size and location
        let image:UIImage? = UIImage(named: BottomButtonNamesBlue[i]) // load the image from the assets
        if(image == nil){
            NSLog("Image is NIL")
        }
        else{
            //NSLog("Image Loaded %@", BottomButtonNamesBlue[i])
        
        button.setBackgroundImage(image, forState: UIControlState.Normal) // set the image as the background of the button
        button.addTarget(self, action:"ButtonClicked:", forControlEvents: UIControlEvents.TouchDown) // add the on click listener to the button
        BottomButtons.append(button); // add the button to the array of buttons
        }
        return button
    }
    func ButtonClicked(sender: UIButton){
        for var i:Int = 0; i < BottomButtons.count; i++
        {
            if(BottomButtons[i] == sender){ // find which button was pressed
                NSLog("Bottom Button %i Was Pressed", i)
                switch(i){
                case 0 :
                    parent!.TopButtonsController?.updateButtons(-1, type: ButtonType.Trail)
                    break
                case 1:
                    break
                case 2:
                    parent?.QRContentContainer.hidden = false
                    
                    break
                case 3:
                    parent!.TopButtonsController?.LoadMapButtons()
                    parent!.TopButtonsController!.updateButtons(-1, type:ButtonType.Map)
                    break
                case 4:
                    parent?.TopButtonsController?.updateButtons(-1, type: ButtonType.Information)
                    break
                default:
                    NSLog("Invalid Button Index: %i", i)
                    return
                }
                updateButtons(i) // update the button images
            }
        }
        
    }
    
    public func getParent() -> HomeViewController?{
        return (self.presentingViewController as? HomeViewController)
    }
    public func updateButtons(index:Int){
        for var i = 0; i < BottomButtons.count; i+=1{
            if(i == index){
                BottomButtons[i].setBackgroundImage(UIImage(named: BottomButtonNamesGreen[i]), forState: UIControlState.Normal) // we clicked this button so show the green image
            }
            else{
                BottomButtons[i].setBackgroundImage(UIImage(named: BottomButtonNamesBlue[i]), forState: UIControlState.Normal) // otherwise show the blue image
            }
        }
    }
}
