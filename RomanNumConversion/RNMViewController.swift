//
//  ViewController.swift
//  RomanNumConversion
//
//  Created by Hussain  on 16/4/16.
//  Copyright © 2016 HussainCode. All rights reserved.
//

import UIKit

class RNMViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var firstButton : UIButton?
    @IBOutlet weak var secondButton : UIButton?
    @IBOutlet weak var thirdButton : UIButton?
    @IBOutlet weak var fourthButton : UIButton?
    
    var buttonTitle : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstButton?.layer.cornerRadius = 5.0
        self.secondButton?.layer.cornerRadius = 5.0
        self.thirdButton?.layer.cornerRadius = 5.0
        self.fourthButton?.layer.cornerRadius = 5.0
        // Do any addvaronal setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return kRomannumeralsconversion
    }
    
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String?{
        return kTableViewFooterMessage
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier(kReuseIdentifier) as! RNMCustomInputTableViewCell
        cell.representedObject = self
        return cell
    }
    
    @IBAction func buttonClicked(sender : UIButton)
    {
        if sender.titleLabel?.tag == 3{
            
        }
        self.buttonTitle = sender.titleLabel?.text
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVwController : RNMQuizViewController = segue.destinationViewController as? RNMQuizViewController{
        destinationVwController.itemName(self.buttonTitle!)
        }
    }
}