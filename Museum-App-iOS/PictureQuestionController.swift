//
//  PictureQuestionController.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 27/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import UIKit

class PictureQuestionController: UIViewController {
    
    @IBOutlet weak var Background: UIImageView!
    //@IBOutlet weak var text: UITextView!
    var manager:QuestionManager!
    var parent:HomeViewController!
    let MAX_SCORE:Int = 100
    var scoreForThisQuestion:Int = 0
    var totalScore:Int = 0
    var screenHeight:CGFloat = 0.0
    var screenWidth:CGFloat = 0.0
    var QRButton:UIButton!
    var skipButton:UIButton!
    var questionField:UIImageView!
    var scoreField:UITextView!
    var trailPositionField:UITextView!
    var validatedContent:String = ""
    var format:String = ""
    var endTrail:Bool = false
    var hasBeenSkipped:Bool = false
    var correctAnswer:String = ""
    var trailManager:TrailManager!
    var trailDecision:Int = 0
    var scannedArtefact:Int = 0
    var currentPosition:Int = 0
    var trailLength:Int = 0
    var trailScore:Int = 0
    var skipped:Bool = false
    var trailEnded:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreForThisQuestion = MAX_SCORE
        screenHeight = self.view.bounds.height
        screenWidth = self.view.bounds.width
        if(!setupViews()){
            fatalError("Could Not load Question")
        }
        
        NSLog("Picture Question controller loaded")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func setupViews() -> Bool{
        QRButton = UIButton(frame: CGRect(x: screenWidth / 2, y: screenHeight / 2, width: screenWidth, height: screenHeight))
        QRButton.setTitle("", forState: UIControlState.Normal)
        QRButton.backgroundColor = UIColor(white: 1, alpha: 0)
        QRButton.setBackgroundImage(UIImage(named: "QR Icon Transparent"), forState: UIControlState.Normal)
        QRButton.sizeToFit()
        QRButton.addTarget(self, action: "QRButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(QRButton)
        //-----------------------------------
        skipButton = UIButton(frame: CGRect(x: screenWidth * 0.8, y: screenHeight * 0.9, width: screenWidth * 0.15, height: screenHeight * 0.05))
        skipButton.setTitle("Skip", forState: UIControlState.Normal)
        skipButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        skipButton.backgroundColor = UIColor.whiteColor()
        skipButton.titleLabel?.textAlignment = NSTextAlignment.Center
        skipButton.addTarget(self, action: "SkipButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(skipButton)
        //----------------------------------
        questionField = UIImageView(frame: CGRect(x: screenWidth * 0.25, y: screenHeight * 0.1, width: screenWidth, height: screenHeight))
        let imagePath = NSBundle.mainBundle().pathForResource("images/46_rocks", ofType: ".jpg")!
        questionField.image = imageResize(image: UIImage(contentsOfFile: imagePath)!, sizeChange: CGSize(width: 200, height: 200))
        if(questionField.image == nil){
            NSLog("Image == NIL")
        }
        questionField.backgroundColor = UIColor(white: 1, alpha: 0)
        questionField.sizeToFit()
        self.view.addSubview(questionField)
        //----------------------------------
        trailPositionField = UITextView(frame:CGRect(x: screenWidth * 0.4, y: CGFloat(10.0), width: screenWidth, height: screenHeight))
        let trailPosition = String("Question : ").stringByAppendingString(String(currentPosition).stringByAppendingString(" Of ").stringByAppendingString(String(trailLength)))
        trailPositionField.text = trailPosition
        trailPositionField.sizeToFit()
        trailPositionField.editable = false
        trailPositionField.textColor = UIColor.whiteColor()
        trailPositionField.backgroundColor = UIColor(white: 1, alpha: 0)
        self.view.addSubview(trailPositionField)
        //----------------------------------
        scoreField = UITextView(frame: CGRect(x: screenWidth * 0.7, y: CGFloat(10.0), width: screenWidth * 0.2, height: screenHeight * 0.05))
        scoreField.text = String("Score: ").stringByAppendingString(String(trailScore))
        scoreField.editable = false
        scoreField.textColor = UIColor.whiteColor()
        scoreField.backgroundColor = UIColor(white: 1, alpha: 0)
        self.view.addSubview(scoreField)
        //----------------------------------
        return true
    }
    
    internal func getParent() -> HomeViewController!{
        return self.parent
    }
    
    internal func SetParent(parent:HomeViewController!){
        self.parent = parent
    }
    
    internal func getQuestionManager() -> QuestionManager!{
        return self.manager
    }
    
    internal func setQuestionManager(manager:QuestionManager!){
        self.manager = manager
    }
    
    func imageResize (image image:UIImage, sizeChange:CGSize)-> UIImage{
        
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }
    
    func SkipButtonClicked(){
        NSLog("Skipping Question")
        skipped = true
        if(currentPosition == trailLength){
            trailEnded = true
        }
        else{
            trailEnded = false
        }
        passData()
        manager.nextQuestion()
    }
    
    func NextButtonClicked(sender:UIButton!){
        skipped = false
        if(currentPosition == trailLength){
            trailEnded = true
        }
        else{
            trailEnded = false
        }
        passData()
        manager.nextQuestion()
        
    }
    
    private func passData(){
        let result:QuestionResult! = QuestionResult(score: scoreForThisQuestion, endofTrail: trailEnded, skipped: skipped)
        parent.SetLastQuestionResult(result)
    }
    
    
}
