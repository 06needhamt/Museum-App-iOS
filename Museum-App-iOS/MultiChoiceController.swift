//
//  MultiChoiceController.swift
//  Museum-App-iOS
//
//  Created by THOMAS NEEDHAM on 21/07/2015.
//  Copyright (c) 2015 THOMAS NEEDHAM. All rights reserved.
//

// uses https://github.com/tejas123/implement-Toast-Message-in-iOS-using-Swift

import UIKit

class MultiChoiceController: UIViewController {
    
    private var parent:HomeViewController!
    private var manager:QuestionManager!
    private var screenHeight:CGFloat = 0
    private var screenWidth:CGFloat = 0
    private var buttonA:UIButton!
    private var buttonB:UIButton!
    private var buttonC:UIButton!
    private var buttonD:UIButton!
    private var answerButtons:[UIButton!] = []
    private var questionField:UITextView!
    private var ScoreField:UITextView!
    private var trailPositionField:UITextView!
    private let MAX_SCORE:Int = 100
    private var endTrail:Bool = false
    private var scoreForThisQuestion:Int = 100
    private var totalScore:Int = 0
    private var question = ""
    private var answers:[String] = []
    private var correctAnswer:String = ""
    private var hasBeenSkipped:Bool = false
    private var currentPosition:Int = 0
    private var trailLength = 0
    private var skipButton:UIButton!
    private var skipped:Bool = false
    private var trailEnded:Bool = false
    
    @IBOutlet weak var BackgroundImage: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parent = getParentController()
        applyAnswers("Correct Answer")
        theOldSwitcheroo()
        if(!setupViews()){
            fatalError("Unable To Load Question " + String(currentPosition))
        }
        else{
            
            NSLog("MultiChoiceController Loaded")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    internal func getParentController() -> HomeViewController{
        return parent
    }
    
    internal func setParentController(controller:HomeViewController){
        parent = controller
    }
//    @IBAction func DismissClicked(sender: UIButton) {
//        manager.dismiss(self as UIViewController)
//        NSLog("Controller Dismissed")
//    }
    
    internal func setQuestionManager(manager:QuestionManager!){
        self.manager = manager
    }
    
    internal func getQuestionManager() -> QuestionManager!{
        return manager
    }
    
    internal func setupViews() -> Bool{
        screenHeight = self.view.bounds.height
        screenWidth = self.view.bounds.width
        questionField = UITextView(frame: CGRect(x: CGFloat(0.0), y: screenHeight * 0.1, width: screenWidth, height: screenHeight))
        questionField.text = "sampleQuestion"
        questionField.textAlignment = NSTextAlignment.Center
        questionField.sizeToFit()
        questionField.frame = CGRect(x: CGFloat(0.0), y: screenHeight * 0.1, width: screenWidth, height: questionField.frame.height) // reset the width to the screenwidth
        questionField.editable = false
        questionField.textColor = UIColor.whiteColor()
        questionField.backgroundColor = UIColor(white: 1, alpha: 0.0) // transparent colour
        //-------------------------------------
        trailPositionField = UITextView(frame: CGRect(x: screenWidth * 0.4, y: CGFloat(10.0), width: screenWidth, height: screenHeight))
        let trailposition = String("Question : ").stringByAppendingString(String(currentPosition)).stringByAppendingString(" Of ").stringByAppendingString(String(trailLength))
        trailPositionField.text = trailposition
        trailPositionField.sizeToFit()
        trailPositionField.editable = false
        trailPositionField.textColor = UIColor.whiteColor()
        trailPositionField.backgroundColor = UIColor(white: 1, alpha: 0.0) // transparent colour
        //------------------------------------
        ScoreField = UITextView(frame: CGRect(x: screenWidth * 0.7, y: CGFloat(10.0), width: screenWidth * 0.2, height: screenHeight * 0.05))
        ScoreField.text = String("Score: ").stringByAppendingString(String(totalScore))
        ScoreField.editable = false
        ScoreField.textColor = UIColor.whiteColor()
        ScoreField.backgroundColor = UIColor(white: 1, alpha: 0.0) // transparent colour
        //------------------------------------
        self.view.addSubview(trailPositionField)
        self.view.addSubview(questionField)
        self.view.addSubview(ScoreField)
        //------------------------------------
        buttonA = UIButton(frame: CGRect(x: screenWidth * 0.1, y: screenHeight * 0.4, width: screenWidth * 0.8, height: screenHeight * 0.05))
        buttonA.tag = 0
        buttonA.setTitle(answers[0], forState: UIControlState.Normal)
        buttonA.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        buttonA.backgroundColor = UIColor.whiteColor()
        buttonA.titleLabel?.textAlignment = NSTextAlignment.Center
        buttonA.addTarget(self, action: "AnswerButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(buttonA)
        answerButtons.append(buttonA)
        //------------------------------------
        
        buttonB = UIButton(frame: CGRect(x: screenWidth * 0.1, y: screenHeight * 0.5, width: screenWidth * 0.8, height: screenHeight * 0.05))
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
        buttonC = UIButton(frame: CGRect(x: screenWidth * 0.1, y: screenHeight * 0.6, width: screenWidth * 0.8, height: screenHeight * 0.05))
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
        buttonD = UIButton(frame: CGRect(x: screenWidth * 0.1, y: screenHeight * 0.7, width: screenWidth * 0.8, height: screenHeight * 0.05))
        buttonD.tag = 3
        buttonD.setTitle(answers[3], forState: UIControlState.Normal)
        buttonD.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        buttonD.backgroundColor = UIColor.whiteColor()
        buttonD.titleLabel?.textAlignment = NSTextAlignment.Center
        buttonD.addTarget(self, action: "AnswerButtonClicked:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(buttonD)
        answerButtons.append(buttonD)
        //------------------------------------
        skipButton = UIButton(frame: CGRect(x: screenWidth * 0.8, y: screenHeight * 0.9, width: screenWidth * 0.15, height: screenHeight * 0.05))
        skipButton.setTitle("Skip", forState: UIControlState.Normal)
        skipButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        skipButton.backgroundColor = UIColor.whiteColor()
        skipButton.titleLabel?.textAlignment = NSTextAlignment.Center
        skipButton.addTarget(self, action: "ShowSkipDialog:", forControlEvents: UIControlEvents.TouchDown)
        self.view.addSubview(skipButton)
        //------------------------------------
        NSLog("All Views Constructed Sucessfully")

        return true
        
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
        ScoreField.text = String("Score: ").stringByAppendingString(String(score))
    }
    
    internal func updateTrailPosition(currentPosition:Int, MAX:Int){
        trailPositionField.text = String("Question: ").stringByAppendingString(String(currentPosition)).stringByAppendingString(" Of ").stringByAppendingString(String(MAX))
    }
    
    private func applyAnswers(tempy:String){
        var templist:[String] = tempy.componentsSeparatedByString(",")
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

