//
//  ViewController.swift
//  MoneyCounter
//
//  Created by 中安拓也 on 2016/05/02.
//  Copyright © 2016年 l08084. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var moneyTextField: UITextField!
    
    // DBアクセスクラスをインスタンス化
    var repo: Repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        repo = Repository()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

