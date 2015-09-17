//
//  PictureMultiChoiceController.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 27/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

// uses https://github.com/tejas123/implement-Toast-Message-in-iOS-using-Swift

import UIKit

class PictureMultiChoiceController: UIViewController {

    var manager:QuestionManager!
    var parent:HomeViewController!
    let MAX_SCORE:Int = 100
    var scoreForThisQuestion:Int = 0
    var totalScore:Int = 0
    var screenHeight:CGFloat = 0.0
    var screenWidth:CGFloat = 0.0
    var buttonA:UIButton!
    var buttonB:UIButton!
    var buttonC:UIButton!
    var buttonD:UIButton!
    var answerButtons:[UIButton!] = []
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
    var answers:[String] = []
    var skipped:Bool = false
    var trailEnded:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreForThisQuestion = MAX_SCORE
        screenHeight = self.view.bounds.height
        screenWidth = self.view.bounds.width
        applyAnswers("Correct Answer")
        theOldSwitcheroo()
        if(!setupViews()){
            fatalError("Could Not load Question")
        }
        
        NSLog("Picture Multi Choice Question controller loaded")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    private func setupViews() -> Bool{
        buttonA = UIButton(frame: CGRect(x: screenWidth * 0.1, y: screenHeight * 0.45, width: screenWidth * 0.8, height: screenHeight * 0.05))
        buttonA.tag = 0
        buttonA.setTitle(answers[0], forState: UIControlState.Normal)
        buttonA.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        buttonA.backgroundColor = UIColor.whiteColor()
        buttonA.titleLabel?.textAlignment = NSTextAlignment.Center
        buttonA.addTarget(self, action: "AnswerButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(buttonA)
        answerButtons.append(buttonA)
        //------------------------------------
        
        buttonB = UIButton(frame: CGRect(x: screenWidth * 0.1, y: screenHeight * 0.55, width: screenWidth * 0.8, height: screenHeight * 0.05))
        buttonB.tag = 1
        buttonB.setTitle(answers[1], forState: UIControlState.Normal)
        buttonB.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        buttonB.backgroundColor = UIColor.whiteColor()
        buttonB.titleLabel?.textAlignment = NSTextAlignment.Center
        buttonB.addTarget(self, action: "AnswerButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(buttonB)
        answerButtons.append(buttonB)
        //------------------------------------
        
        //------------------------------------
        buttonC = UIButton(frame: CGRect(x: screenWidth * 0.1, y: screenHeight * 0.65, width: screenWidth * 0.8, height: screenHeight * 0.05))
        buttonC.tag = 2
        buttonC.setTitle(answers[2], forState: UIControlState.Normal)
        buttonC.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        buttonC.backgroundColor = UIColor.whiteColor()
        buttonC.titleLabel?.textAlignment = NSTextAlignment.Center
        buttonC.addTarget(self, action: "AnswerButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(buttonC)
        answerButtons.append(buttonC)
        //------------------------------------
        
        //------------------------------------
        buttonD = UIButton(frame: CGRect(x: screenWidth * 0.1, y: screenHeight * 0.75, width: screenWidth * 0.8, height: screenHeight * 0.05))
        buttonD.tag = 3
        buttonD.setTitle(answers[3], forState: UIControlState.Normal)
        buttonD.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        buttonD.backgroundColor = UIColor.whiteColor()
        buttonD.titleLabel?.textAlignment = NSTextAlignment.Center
        buttonD.addTarget(self, action: "AnswerButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(buttonD)
        answerButtons.append(buttonD)
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

    
    private func theOldSwitcheroo(){ // Name (c) Alex Kiedel
        var tempy:[String] = []
        var roll:Int
        for var i = 0; i < 4; i+=1{
            roll = Int(rand() % (4 - i))
            tempy.append(answers[roll])
            answers.removeAtIndex(roll)
        }
        answers = tempy
    }
    private func checkAnswer(buttonTag:Int){
        let answer:String = answerButtons[buttonTag].currentTitle!
        if(answer == correctAnswer){
            answerButtons[buttonTag].backgroundColor = UIColor.greenColor()
            JLToast.makeText("Correct Answer Well Done").show()
            updateScore(totalScore + scoreForThisQuestion)
            createNextButton()
        }
        else{
            answerButtons[buttonTag].backgroundColor = UIColor.redColor()
            DecrementGuesses(buttonTag)
            JLToast.makeText("Incorrect Answer Try Again").show()
        }
    }
    func AnswerButtonClicked(sender:UIButton!){
        
        NSLog("Button %i clicked", sender.tag)
        checkAnswer(sender.tag)
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
    
    internal func updateScore(score:Int){
        scoreField.text = String("Score: ").stringByAppendingString(String(score))
    }
    
    internal func updateTrailPosition(currentPosition:Int, MAX:Int){
        trailPositionField.text = String("Question: ").stringByAppendingString(String(currentPosition)).stringByAppendingString(" Of ").stringByAppendingString(String(MAX))
    }
    
    private func applyAnswers(tempy:String){
        let templist:[String] = tempy.componentsSeparatedByString(",")
        answers = templist
        correctAnswer = answers[0]
        while(answers.count < 4){
            answers.append("MISSING ANSWER")
        }
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
    
    private func createNextButton(){
        skipButton.setTitle("Next", forState: UIControlState.Normal)
        skipButton.removeTarget(self, action: "ShowSkipDialog:", forControlEvents: UIControlEvents.TouchDown)
        skipButton.addTarget(self, action: "NextButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        self.view.reloadInputViews()
        
    }
    
    func ShowSkipDialog(sender:UIButton!){
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
    
    private func DecrementGuesses(buttonTag:Int){
        scoreForThisQuestion -= MAX_SCORE / 4
        if(scoreForThisQuestion <= 0){
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        answerButtons[buttonTag].enabled = false
    }
    
    private func enableAllButtons(){
        for var i = 0; i < answerButtons.count; i+=1{
            answerButtons[i].enabled = true
        }
        skipButton.enabled = true
    }
    private func disableAllButtons(){
        for var i = 0; i < answerButtons.count; i+=1{
            answerButtons[i].enabled = false
        }
    }
    
    private func passData(){
        let result:QuestionResult! = QuestionResult(score: scoreForThisQuestion, endofTrail: trailEnded, skipped: skipped)
        parent.SetLastQuestionResult(result)
    }
}


