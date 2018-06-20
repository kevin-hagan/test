//
//  page2.swift
//  pages
//
//  Created by Kevin Hagan on 5/31/18.
//  Copyright © 2018 Kevin Hagan. All rights reserved.
//

import UIKit

class page2: UIViewController {
    
    
    @IBOutlet weak var Header2: UILabel!
    
    @IBOutlet weak var spendHeader: UILabel!
    
    @IBOutlet weak var spendLabel: UILabel!
    
    @IBOutlet weak var twoLabel: UILabel!
    
    @IBOutlet weak var threeLabel: UILabel!
    
    var labelText = ""
    //var labelTextCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spendLabel.text = labelText
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func spendButton(_ sender: UIButton) {
        if Int(spendLabel.text!)! > 0{
            labelText = String(Int(labelText)!-1)
            spendLabel.text = labelText
        }
        
        
    }
    
    
    @IBAction func twoButton(_ sender: UIButton) {
        
        if Int(spendLabel.text!)! > 1{
            labelText = String(Int(labelText)!-2)
            spendLabel.text = labelText
        }
        
    }
    
    
    @IBAction func threeButton(_ sender: UIButton) {
        
        if Int(spendLabel.text!)! > 2{
            labelText = String(Int(labelText)!-3)
            spendLabel.text = labelText
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc2 = segue.destination as! ViewController
        vc2.pointsDisplay = Int(self.labelText)!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
