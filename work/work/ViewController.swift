//
//  ViewController.swift
//  work
//
//  Created by Kevin Hagan on 5/22/18.
//  Copyright © 2018 Kevin Hagan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var label: UILabel!
    
    @IBAction func button(_ sender: Any) {
        label.text = String(Int(label.text!)!+1)
    }
}

