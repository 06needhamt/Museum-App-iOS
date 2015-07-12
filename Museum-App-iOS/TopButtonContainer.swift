//
//  TopButtonContainer.swift
//  Risky-Buisiness-Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 11/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import Foundation
import UIKit

public class TopButtonContainer : UIViewController {
    
    var TopButtons: [UIButton] = [UIButton]();
    let TopButtonImageNamesBlue = [ "Aquarium Icon Blue", "Bugs Icon Blue", "Ancient World Icon Blue", "World Cultures Icon Blue", "Dinosaurs Icon Blue", "Space Icon Blue"]
    
    let TopButtonImageNamesGreen = [ "Aquarium Icon Green", "Bugs Icon Green", "Ancient World Icon Green", "World Cultures Icon Green", "Dinosaurs Icon Green", "Space Icon Green"]
    
    var parent: HomeViewController?
    let NUM_BUTTONS:CGFloat = 6
    var map = false
    
    required public init(coder aDecoder: NSCoder) {
        parent = HomeViewController(coder: aDecoder)
        super.init(coder: aDecoder);
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        parent = getParent() as? HomeViewController;
        for var i:CGFloat = 0; i < NUM_BUTTONS; i++
        {
            self.view.addSubview(CreateButton(i)) // create and add the buttons to the screen
        }
        
        //Cont.addSubview(CreateButton(CGFloat(1)))
        NSLog("Top buttons Loaded")
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func CreateButton(index:CGFloat) -> UIButton{
        let Viewwidth: CGFloat = self.view.bounds.width // get the width of the screen
        let Viewheight: CGFloat = CGFloat(self.view.bounds.height / 8) // get the height of the screen and divide it by eight because the buttons take up an eighth of the screen
        var i:Int = Int(index) // convert index to an int
        var value:String = TopButtonImageNamesBlue[i]
        var button = UIButton(frame: CGRect(x: Viewwidth / NUM_BUTTONS * index, y:CGFloat(0.0), width: Viewwidth / NUM_BUTTONS, height: Viewheight)) // create the button with a size and location
        var image:UIImage? = (UIImage(named: TopButtonImageNamesBlue[i])) // load the image from assets
        if(image == nil){
            NSLog("Image is NIL")
        }
        else{
            NSLog("Image Loaded %@", TopButtonImageNamesBlue[i])
        
        button.setBackgroundImage(image, forState: UIControlState.Normal) // set the bacground image for the button
        button.addTarget(self, action:"ButtonClicked:", forControlEvents: UIControlEvents.TouchDown) // add the on click listener to the button
        
        TopButtons.append(button);
        }
        return button
    }
    func ButtonClicked(sender: UIButton){
        for var i:Int = 0; i < TopButtons.count; i++
        {
            if(TopButtons[i] == sender){
                NSLog("Button %i Was Pressed", i)
                switch(i){
                    // TODO implement button clicks
                case 0 :
                    break
                case 1:
                    break
                case 2:
                    break
                case 3:
                    break
                case 4:
                    break
                case 5:
                    break
                default:
                    NSLog("Invalid Button Index: %i", i)
                    return
                }
                updateButtons(i, maps: map) // update the button images
            }
        }
        
    }
    
    public func getParent() -> UIViewController?{
        // TODO find how to get the parent view controller
        return self.presentingViewController as? HomeViewController
    }
    
    internal func LoadMapButtons(){
        for var i = 0; i < self.TopButtons.count; i+=1 {
            sleep(1000)
        }
        // TODO load map buttons
        
    }
    
    public func updateButtons(index:Int, maps:Bool){
        for var i = 0; i < TopButtons.count; i+=1{
            map = maps
            if(maps){
                // TODO add map buttons
            }
            else{
                if(i == index){
                    TopButtons[i].setBackgroundImage(UIImage(named: TopButtonImageNamesGreen[i]), forState: UIControlState.Normal) // we clicked this button so load the green image
                }
                else{
                    TopButtons[i].setBackgroundImage(UIImage(named: TopButtonImageNamesBlue[i]), forState: UIControlState.Normal) // otherwise load the blue image
                }
            }
        }
    }
}