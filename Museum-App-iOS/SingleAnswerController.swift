//
//  SingleAnswerController.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 24/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

import UIKit

class SingleAnswerController: UIViewController {

    @IBOutlet weak var BackgroundImage: UIImageView!
    var parent:HomeViewController!
    var manager:QuestionManager!
    let MAX_SCORE:Int = 100
    var scoreForThisQuestion:Int = 0
    var totalScore:Int = 0
    var screenHeight:CGFloat = 0.0
    var screenWidth:CGFloat = 0.0
    var QRButton:UIButton!
    var skipButton:UIButton!
    var questionField:UITextView!
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
    
    required init(coder aDecoder:NSCoder){
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreForThisQuestion = MAX_SCORE
        screenHeight = self.view.bounds.height
        screenWidth = self.view.bounds.width
        if(!setupViews()){
            fatalError("Could Not load Question")
        }
        
        NSLog("Single Answer controller loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        questionField = UITextView(frame: CGRect(x: CGFloat(0.0), y: screenHeight * 0.1, width: screenWidth, height: screenHeight))
        questionField.text = "Sample Question"
        questionField.textAlignment = NSTextAlignment.Center
        questionField.sizeToFit()
        questionField.frame = CGRect(x: CGFloat(0.0), y: screenHeight * 0.1, width: screenWidth, height: questionField.frame.height)
        questionField.editable = false
        questionField.textColor = UIColor.whiteColor()
        questionField.backgroundColor = UIColor(white: 1, alpha: 0)
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
    
    func NextButtonClicked(){
        //NSLog("Skipping Question")
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
    
    func showSkipDialog(sender:UIButton!){
        let dialog = UIAlertController(title: "Skip This Question?", message: "Are You Sure You Want To Skip This Question?", preferredStyle: UIAlertControllerStyle.Alert)
        
        dialog.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {
            action in
            self.SkipButtonClicked()
        }))
        dialog.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Default, handler: {
            action in
            NSLog("Not Skipping Question")
        }))
        self.presentViewController(dialog, animated: true, completion: nil)
    }
    private func createNextButton(){
        skipButton.setTitle("Next", forState: UIControlState.Normal)
        skipButton.removeTarget(self, action: "SkipButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        skipButton.addTarget(self, action: "NextButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
    }
    func QRButtonClicked(sender:UIButton!){
        NSLog("QR Button Clicked")
    }
    internal func SetParent(parent:HomeViewController){
        self.parent = parent
    }
    
    internal func GetParent() -> HomeViewController!{
        return self.parent
    }
    
    internal func GetQuestionManager() -> QuestionManager!{
        return self.manager
    }
    
    internal func SetQuestionManager(manager:QuestionManager){
        self.manager = manager
    }
    
    private func passData(){
        let result:QuestionResult! = QuestionResult(score: scoreForThisQuestion, endofTrail: trailEnded, skipped: skipped)
        parent.SetLastQuestionResult(result)
    }

}
