//
//  ViewController.swift
//  RomanNumConversion
//
//  Created by Hussain  on 16/4/16.
//  Copyright © 2016 HussainCode. All rights reserved.
//

import UIKit
import StoreKit
import MessageUI

class RNMViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MFMailComposeViewControllerDelegate {
    @IBOutlet weak var easyBtn : UIButton?
    @IBOutlet weak var mediumBtn : UIButton?
    @IBOutlet weak var hardBtn : UIButton?
    @IBOutlet weak var hintBtn : UIButton?
    @IBOutlet weak var shareBtn : UIButton?
    @IBOutlet weak var rateUsBtn : UIButton?
    @IBOutlet weak var feedBackBtn : UIButton?
    
    var buttonTitle : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.easyBtn?.layer.cornerRadius = 5.0
        self.mediumBtn?.layer.cornerRadius = 5.0
        self.hardBtn?.layer.cornerRadius = 5.0
        self.hintBtn?.layer.cornerRadius = 5.0
        self.shareBtn?.layer.cornerRadius = 5.0
        self.rateUsBtn?.layer.cornerRadius = 5.0
        self.feedBackBtn?.layer.cornerRadius = 5.0
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
    
    @IBAction func doShare(sender : UIButton){
        let texttoshare = kmsgToShareOnSociaL
        var activityVC : UIActivityViewController? = nil
        let activityProvider1 = WFActivitySpecificItemProvider(placeholderItem: [WFActivitySpecificItemProviderTypeDefault : texttoshare, UIActivityTypePostToFacebook : texttoshare, UIActivityTypePostToTwitter : texttoshare, UIActivityTypeMessage : texttoshare])
        
        let activityProvider2 = WFActivitySpecificItemProvider(placeholderItem: nil, block : {(activityType) -> AnyObject! in
            if (activityType == kWhatsAppUrl){
                activityVC?.dismissViewControllerAnimated(false, completion: nil)
                let msg = kWhatsAppMsg
                let url = NSURL(string: msg)
                UIApplication.sharedApplication().openURL(url!)
            }
            return texttoshare
        })
        activityVC = UIActivityViewController(activityItems: [activityProvider1, activityProvider2], applicationActivities: nil)
        activityVC!.excludedActivityTypes = [UIActivityTypeAddToReadingList,UIActivityTypeCopyToPasteboard,UIActivityTypePostToFlickr,UIActivityTypePostToWeibo,UIActivityTypeAssignToContact,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypePrint,UIActivityTypeSaveToCameraRoll,UIActivityTypeAirDrop]
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Phone){
            self.presentViewController(activityVC!, animated: true, completion: nil)
        }
        else{
            let popOver = UIPopoverController(contentViewController: activityVC!)
            popOver.presentPopoverFromRect(self.shareBtn!.bounds, inView: self.shareBtn!, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
        }
        

        
    }
    
    
    @IBAction func doRateUs(sender : UIButton)
    {
        let appUrl = NSURL(string: kItunesAppUrl)
        UIApplication.sharedApplication().openURL(appUrl!)
    }
    
    @IBAction func giveFeedBack(sender : UIButton){
        if MFMailComposeViewController.canSendMail(){
        let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setSubject(kAppNm)
            mail.setToRecipients([kFeedBackEml])
            self.presentViewController(mail, animated: true, completion: {
            })
        }
        else{
            print(kMailAppErr)
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?){
        switch result{
        case MFMailComposeResultSent:
            self.dismissViewControllerAnimated(true, completion: { 
                controller.dismissViewControllerAnimated(true, completion: nil)
            })
        case MFMailComposeResultSaved:
            self.dismissViewControllerAnimated(true, completion: {
                controller.dismissViewControllerAnimated(true, completion: nil)
            })
        case MFMailComposeResultCancelled:
            self.dismissViewControllerAnimated(true, completion: {
                controller.dismissViewControllerAnimated(true, completion: nil)
            })
        default:
            print(kMailSentFailed)
        }
    }
    
    func productViewControllerDidFinish(viewController : SKStoreProductViewController){
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVwController : RNMQuizViewController = segue.destinationViewController as? RNMQuizViewController{
        destinationVwController.itemName(self.buttonTitle!)
        }
    }
    
}