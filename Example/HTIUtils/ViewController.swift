//
//  ViewController.swift
//  HTIUtils
//
//  Created by muslin@hytexts.com on 03/04/2020.
//  Copyright (c) 2020 muslin@hytexts.com. All rights reserved.
//

import UIKit
import HTIUtils

class ViewController: UIViewController {

    let papa = "Strui"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(String.deviceModel)
        
        print(UIColor.white.hexString)
        
//        ExtString().hexString(color: UIColor.white.cgColor)
//        HelloWorld().hello(to: "yyy")
//        HelloWorld().helloColor
//        UIColor.hex
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

