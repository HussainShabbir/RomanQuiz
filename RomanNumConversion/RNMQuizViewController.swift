//
//  RNMQuizViewController.swift
//  RomanNumConversion
//
//  Created by Hussain  on 18/4/16.
//  Copyright © 2016 HussainCode. All rights reserved.
//

import UIKit

let kEASY = "Level : Easy"
let kMEDIUM = "Level : Medium"
let kHARD = "Level : Hard"


enum answersIndex : UInt32{
    case firstOption = 1
    case secondOption
    case thirdOption
    case fourthOption
}

typealias answerOption = answersIndex

class RNMQuizViewController: UIViewController {
    
    @IBOutlet weak var time : UILabel?
    @IBOutlet weak var level : UILabel?
    @IBOutlet weak var question : UILabel?
    @IBOutlet weak var questionLimit : UILabel?
    @IBOutlet weak var score : UILabel?
    @IBOutlet weak var target : UILabel?
    @IBOutlet weak var ansBtnVw : UIView?
    
    @IBOutlet weak var firstOption : UIButton?
    @IBOutlet weak var secondOption : UIButton?
    @IBOutlet weak var thirdOption : UIButton?
    @IBOutlet weak var fourOption : UIButton?
    @IBOutlet weak var statusDescription : UILabel?
    @IBOutlet weak var bestTimeLbl : UILabel?
    
    var timer : NSTimer? = nil
    var timerCount = 180
    var questionCount = 0
    var scoreCount = 0
    var targetCount = 0
    var itemName : String?
    var answerValue : String?
    var questionArr = [AnyObject]()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.level?.text = self.itemName
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.decrementTimer), userInfo: nil, repeats: true)
        self.firstOption?.layer.cornerRadius = 5.0
        self.secondOption?.layer.cornerRadius = 5.0
        self.thirdOption?.layer.cornerRadius = 5.0
        self.fourOption?.layer.cornerRadius = 5.0
        updateTarget()
        getAnswerIndex()
        self.statusDescription?.text = kEmpty
        let userDefault = NSUserDefaults.standardUserDefaults()
        let previousBestTm = userDefault.integerForKey(self.itemName!)
//        self.bestTimeLbl?.text = String(format: "Best Time : %d Sec",previousBestTm) as String
        self.bestTimeLbl?.text = "\(kBestTime) \(previousBestTm) \(kSecond)"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    
    @IBAction func dismissViewController(sender : AnyObject)
    {
        self.dismissViewControllerAnimated(true) {
        }
    }
    
    
    func decrementTimer()
    {
        guard self.timerCount > 0
            else
            {
                validateResult()
                return
            }
        self.timerCount -= 1
//        self.time?.text = String(format: "Time : %d", self.timerCount) as String
        self.time?.text = "\(kTime) \(self.timerCount)"
    }
    
    
    func itemName(itemName : String)
    {
//        self.itemName = String(format: "Level : %@",itemName) as String
        self.itemName =  "\(kLevel) \(itemName)"
    }
    
    
    @IBAction func answerClicked(sender : UIButton)
    {
        
        if sender.titleLabel?.text == self.answerValue{
            UIView.animateWithDuration(1, animations: {
                self.statusDescription?.alpha = 0.0
                self.statusDescription?.text = kCorrectAns
                self.statusDescription?.alpha = 1.0
            })
            
            scoreCount += 1
//            self.score?.text = String(format: "Score : %d",scoreCount)
            self.score?.text = "\(kScore) \(scoreCount)"
        }
        else{
            UIView.animateWithDuration(1, animations: {
            self.statusDescription?.alpha = 0.0
            self.statusDescription?.text = kWrongAns
            self.statusDescription?.alpha = 1.0
            })
        }
        getAnswerIndex()
    }
    
    
    func getAnswerIndex()
    {
        questionCount += 1
//        self.questionLimit?.text = String(format: "Question : %d/60",questionCount) as String
        self.questionLimit?.text = "\(kQuestion) \(questionCount)"
        let ansValue = generateRandomQuestion()
        var ansIndex = arc4random_uniform(4);
        if  ansIndex <= 0
        {
            ansIndex += 1
        }
        if let answerOption = answerOption (rawValue : ansIndex)
        {
            let randomVal = arc4random_uniform(10);
            let tempAnsVal = Int(ansValue)!
            var shouldIncrement = false
            if (tempAnsVal < 10){
                shouldIncrement = true
            }
            else{
                if randomVal < 5{
                    shouldIncrement = false
                }
                else{
                    shouldIncrement = true
                }
            }
            switch answerOption {
            case .firstOption:
                self.firstOption?.setTitle(ansValue, forState: UIControlState.Normal)
                self.secondOption?.setTitle(updateAnswerOption(5, ansValue: ansValue,shouldIncrement: shouldIncrement), forState: UIControlState.Normal)
                self.thirdOption?.setTitle(updateAnswerOption(5, ansValue: ansValue,shouldIncrement: !shouldIncrement), forState: UIControlState.Normal)
                self.fourOption?.setTitle(updateAnswerOption(10, ansValue: ansValue,shouldIncrement: true), forState: UIControlState.Normal)
            case .secondOption:
                self.secondOption?.setTitle(ansValue, forState: UIControlState.Normal)
                self.firstOption?.setTitle(updateAnswerOption(10, ansValue: ansValue,shouldIncrement: shouldIncrement), forState: UIControlState.Normal)
                self.thirdOption?.setTitle(updateAnswerOption(5, ansValue: ansValue,shouldIncrement: shouldIncrement), forState: UIControlState.Normal)
                self.fourOption?.setTitle(updateAnswerOption(5, ansValue: ansValue,shouldIncrement: !shouldIncrement), forState: UIControlState.Normal)
            case .thirdOption:
                self.thirdOption?.setTitle(ansValue, forState: UIControlState.Normal)
                self.firstOption?.setTitle(updateAnswerOption(5, ansValue: ansValue,shouldIncrement: shouldIncrement), forState: UIControlState.Normal)
                self.secondOption?.setTitle(updateAnswerOption(10, ansValue: ansValue,shouldIncrement: !shouldIncrement), forState: UIControlState.Normal)
                self.fourOption?.setTitle(updateAnswerOption(10, ansValue: ansValue,shouldIncrement: shouldIncrement), forState: UIControlState.Normal)
            case .fourthOption:
                self.fourOption?.setTitle(ansValue, forState: UIControlState.Normal)
                self.firstOption?.setTitle(updateAnswerOption(10, ansValue: ansValue,shouldIncrement: shouldIncrement), forState: UIControlState.Normal)
                self.secondOption?.setTitle(updateAnswerOption(5, ansValue: ansValue,shouldIncrement: true), forState: UIControlState.Normal)
                self.thirdOption?.setTitle(updateAnswerOption(10, ansValue: ansValue,shouldIncrement: !shouldIncrement), forState: UIControlState.Normal)
            }
        }
            validateResult()
    }
    
    func updateAnswerOption(value : Int, ansValue : String, shouldIncrement : Bool) -> String
    {
        var incrementValue = Int(ansValue)! - value
        var incrementValueStr = String(incrementValue)
        guard !shouldIncrement else{
            incrementValue = Int(ansValue)! + value
//            return String(format: "%d",incrementValue) as String
            incrementValueStr = String(incrementValue)
            return incrementValueStr
        }
//        return String(format: "%d",incrementValue) as String
        return incrementValueStr
    }
    
    func generateRandomQuestion() -> String
    {
        var question : Int!
        question = validateQuestion()
        while (question <= 0){
            question = validateQuestion()
        }
        
        let value = romanNumeral(question)
        UIView.animateWithDuration(1, animations: {
            self.question?.alpha = 0.0
//            self.question?.text = String(format: "%d) %@ ?", self.questionCount,value)
            self.question?.text = "\(self.questionCount)) \(value) ?"
            self.question?.alpha = 1.0
        })
//        self.answerValue = String(format: "%d",question)
        self.answerValue = String(question)
        return self.answerValue!
    }
    
    
    func validateQuestion()-> Int{
        var question = randomNumber()
        if (questionArr.count == 0){
            questionArr.append(question)
        }
        else{
            let predicate = NSPredicate(format: "SELF == %d",question)
            let isquestionRepeat = questionArr.filter{predicate.evaluateWithObject($0)}
            if (isquestionRepeat.count == 0){
                questionArr.append(question)
            }
            else{
                question = 0
            }
        }
        return question
    }
    
    func randomNumber() -> Int{
        var question : Int?
        if self.itemName == kEASY{
            question = Int(arc4random_uniform(100))
            if question == 0
            {
                question = 100
            }
        }
        else if self.itemName == kMEDIUM{
            question = Int(arc4random_uniform(1000))
            if question == 0
            {
                question = 1000
            }
        }
        else if self.itemName == kHARD{
            question = Int(arc4random_uniform(5000))
            if question == 0
            {
                question = 5000
            }
        }
        return question!
    }
    
    func romanNumeral(value : Int) -> String{
        var n = value
        let numerals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let valueCount = 13
        let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        var numeralString = kEmpty
        for j in (0..<valueCount){
            while (n >= values[j])
            {
                n = n - values[j];
                numeralString.appendContentsOf(numerals[j])
            }
        }
        return numeralString;
    }
    
    func updateTarget()
    {
        var value : Int32?
        if self.itemName == kEASY{
            value = rand() % (10) + 30
            if value > 60{
                value = 25
            }
        }
        else if self.itemName == kMEDIUM{
            value = rand() % (10) + 35
            if value > 60{
                value = 35
            }
        }
        else if self.itemName == kHARD{
            value = rand() % (10) + 40
            if value > 60{
                value = 45
            }
        }
        self.targetCount = Int(value!)
//        self.target?.text = String(format: "Target : %d",self.targetCount) as String
        self.target?.text = "\(kTarget) \(self.targetCount)"
    }
    
    
    func validateResult(){
        
        var isStopped = false
        if self.scoreCount >= self.targetCount{
            let bestTime = (180 - self.timerCount)
            let userDefault = NSUserDefaults.standardUserDefaults()
            let previousBestTm = userDefault.integerForKey(self.itemName!)
            if (bestTime > previousBestTm || previousBestTm == 0)
            {
                userDefault.setInteger(bestTime, forKey: self.itemName!)
                userDefault.synchronize()
//                self.bestTimeLbl?.text = String(format: "Best Time : %d Sec",bestTime) as String
                self.bestTimeLbl?.text = "\(kBestTime) \(bestTime) \(kSecond)"
//                let msg = String(format: "Created the new best record %d Sec",bestTime) as String
                let msg = "\(kCreatedBestRec) \(bestTime) \(kSecond)"
                displayAlert(kWonMessage, message: msg)
            }
            else
            {
                self.statusDescription?.text = kWonMessage
            }
            isStopped = true
        }
        else if (self.timerCount == 0){
            let diff = self.targetCount - self.scoreCount
            let suffValue = diff > 1 ? kPoints : kPoint
//            self.statusDescription?.text = String(format: "Sorry! You lost by %d %@", diff,suffValue)
            self.statusDescription?.text = "\(kSorryYouLost) by \(diff) \(suffValue)"
            isStopped = true
        }
        else if ((self.scoreCount + (60 - self.questionCount)) < self.targetCount){
            displayAlert(kSorryYouLost, message: kLostMessage)
            isStopped = true
        }
        guard (isStopped == false)
            else
            {
                self.ansBtnVw!.userInteractionEnabled = false
                self.ansBtnVw!.alpha = 0.5
                self.timer?.invalidate()
                return
            }
    }
    
    func displayAlert(title : String, message : String){
     let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: kOkBtn, style: UIAlertActionStyle.Cancel, handler: { (UIAlertAction) in
            self.dismissViewController(self)
        }))
        self.presentViewController(alertController, animated: true) {
        }
    }
}

