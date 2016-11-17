//
//  ViewController.swift
//  Swift-RunLoopView
//
//  Created by aa on 16/11/17.
//  Copyright © 2016年 aa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _loopView = RunLoopView.init(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 200))
        _loopView.imgAry = ["01.jpg","02.jpg","03.jpg","04.jpg","05.jpg",]
        self.view.addSubview(_loopView)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

