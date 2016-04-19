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
    
    var timer : NSTimer? = nil
    var timerCount = 180
    var questionCount = 0
    var scoreCount = 0
    var targetCount = 0
    var itemName : String?
    var answerValue : String?
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.level?.text = self.itemName
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(self.decrementTimer), userInfo: nil, repeats: true)
        self.firstOption?.layer.cornerRadius = 5.0
        self.secondOption?.layer.cornerRadius = 5.0
        self.thirdOption?.layer.cornerRadius = 5.0
        self.fourOption?.layer.cornerRadius = 5.0
        getAnswerIndex()
        self.statusDescription?.text = ""
        updateTarget()
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
        self.time?.text = String(format: "Time : %d", self.timerCount) as String
    }
    
    
    func itemName(itemName : String)
    {
        self.itemName = String(format: "Level : %@",itemName) as String
    }
    
    
    @IBAction func answerClicked(sender : UIButton)
    {
        
        if sender.titleLabel?.text == self.answerValue{
            UIView.animateWithDuration(1, animations: {
                self.statusDescription?.alpha = 0.0
                self.statusDescription?.text = "Correct answer!"
                self.statusDescription?.alpha = 1.0
            })
            
            scoreCount += 1
            self.score?.text = String(format: "Score : %d",scoreCount)
        }
        else{
            UIView.animateWithDuration(1, animations: {
            self.statusDescription?.alpha = 0.0
            self.statusDescription?.text = "Wrong answer!"
            self.statusDescription?.alpha = 1.0
            })
        }
        getAnswerIndex()
    }
    
    
    func getAnswerIndex()
    {
        questionCount += 1
        self.questionLimit?.text = String(format: "Question : %d/60",questionCount) as String
        let ansValue = generateRandomQuestion()
        var ansIndex = arc4random_uniform(4);
        if  ansIndex <= 0
        {
            ansIndex += 1
        }
        if let answerOption = answerOption (rawValue : ansIndex)
        {
            switch answerOption {
            case .firstOption:
                self.firstOption?.setTitle(ansValue, forState: UIControlState.Normal)
                self.secondOption?.setTitle(updateAnswerOption(2, ansValue: ansValue), forState: UIControlState.Normal)
                self.thirdOption?.setTitle(updateAnswerOption(3, ansValue: ansValue), forState: UIControlState.Normal)
                self.fourOption?.setTitle(updateAnswerOption(4, ansValue: ansValue), forState: UIControlState.Normal)
            case .secondOption:
                self.secondOption?.setTitle(ansValue, forState: UIControlState.Normal)
                self.firstOption?.setTitle(updateAnswerOption(1, ansValue: ansValue), forState: UIControlState.Normal)
                self.thirdOption?.setTitle(updateAnswerOption(3, ansValue: ansValue), forState: UIControlState.Normal)
                self.fourOption?.setTitle(updateAnswerOption(4, ansValue: ansValue), forState: UIControlState.Normal)
            case .thirdOption:
                self.thirdOption?.setTitle(ansValue, forState: UIControlState.Normal)
                self.firstOption?.setTitle(updateAnswerOption(1, ansValue: ansValue), forState: UIControlState.Normal)
                self.secondOption?.setTitle(updateAnswerOption(2, ansValue: ansValue), forState: UIControlState.Normal)
                self.fourOption?.setTitle(updateAnswerOption(4, ansValue: ansValue), forState: UIControlState.Normal)
            case .fourthOption:
                self.fourOption?.setTitle(ansValue, forState: UIControlState.Normal)
                self.firstOption?.setTitle(updateAnswerOption(1, ansValue: ansValue), forState: UIControlState.Normal)
                self.secondOption?.setTitle(updateAnswerOption(2, ansValue: ansValue), forState: UIControlState.Normal)
                self.thirdOption?.setTitle(updateAnswerOption(3, ansValue: ansValue), forState: UIControlState.Normal)
            }
        }
        if self.questionCount >= 60{
            validateResult()
            return
        }
        
    }
    
    func updateAnswerOption(value : Int, ansValue : String) -> String
    {
        let incrementValue = Int(ansValue)! + value
        return String(format: "%d",incrementValue) as String
    }
    
    func generateRandomQuestion() -> String
    {
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
        
        
        let value = romanNumeral(question!)
        UIView.animateWithDuration(1, animations: {
            self.question?.alpha = 0.0
            self.question?.text = String(format: "%d) %@ ?", self.questionCount,value)
            self.question?.alpha = 1.0
        })
        self.answerValue = String(format: "%d",question!)
        return self.answerValue!
    }
    
    func romanNumeral(value : Int) -> String{
        var n = value
        let numerals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        let valueCount = 13
        let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1];
        var numeralString = ""
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
            value = rand() % (10) + 25
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
            value = rand() % (10) + 45
            if value > 60{
                value = 45
            }
        }
        self.targetCount = Int(value!)
        self.target?.text = String(format: "Target : %d",self.targetCount) as String
    }
    
    
    func validateResult(){
        if self.scoreCount >= self.targetCount{
            self.statusDescription?.text = "Congratulations! You won."
        }
        else{
            let diff = self.targetCount - self.scoreCount
            let suffValue = diff > 1 ? "points" : "point"
            self.statusDescription?.text = String(format: "Sorry! You lost by %d %@", diff,suffValue)
        }
        self.ansBtnVw!.userInteractionEnabled = false
        self.ansBtnVw!.alpha = 0.5
        self.timer?.invalidate()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
