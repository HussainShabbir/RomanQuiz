//
//  RNMHintViewController.swift
//  RomanNumConversion
//
//  Created by Hussain  on 18/4/16.
//  Copyright © 2016 HussainCode. All rights reserved.
//

import UIKit



class RNMHintViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var colletionView : UICollectionView?
    
    
    
    let numerals = ["I", "IV", "V", "IX", "X", "XL", "L", "XC", "C", "CD", "D", "CM", "M"]
    let valueCount = 13
    let values = [1, 4, 5, 9, 10, 40, 50, 90, 100, 400, 500, 900, 1000];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool
    {
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    @IBAction func dismissViewController(sender : AnyObject)
    {
        self.dismissViewControllerAnimated(true) {
        }
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return valueCount
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        
        let cell : RNMColVwCell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! RNMColVwCell
        let formatterValue = String(format: "%@ = %d", self.numerals[indexPath.row],self.values[indexPath.row]) as String
        cell.formattedLabel?.text = formatterValue
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let size : CGSize  = CGSizeMake(100, 60)
        return size
    }
    
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
//    {
//        let layout : UICollectionViewFlowLayout = colletionView?.collectionViewLayout as! UICollectionViewFlowLayout
//        layout.scrollDirection=size.width > size.height ? UICollectionViewScrollDirection.Horizontal : UICollectionViewScrollDirection.Vertical
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
