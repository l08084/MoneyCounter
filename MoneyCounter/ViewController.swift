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
    @IBOutlet weak var sumLabel: UILabel!
    
    var spendMoneys: [Int] = []
    
    /// 金額保存ボタン押下後に呼び出し
    @IBAction func saveSpend(sender: AnyObject) {
        print("金額入力:¥\(moneyTextField.text!)")
        
        // 既存IDの最大値を取得
        let maxId = repo.findMaxId()
        
        let spend = Spend()
        
        // 既存データのID最大値+1
        spend.id = maxId + 1
        spend.currency = "YEN"
        spend.location = "Tokyo"
        spend.memo = "タリーズ"
        
        // 金額入力欄が空欄の場合、金額を代入しない
        if !((moneyTextField.text?.isEmpty)!) {
            spend.spendMoney = Int(moneyTextField.text!)!
        }
        
        repo.saveSpend(spend)
    }
    
    // DBアクセスクラスをインスタンス化
    var repo: Repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        repo = Repository()
        
        let sum = sumSpendMoneyInMonth()
        print("金額合計:\(sum)")
        sumLabel.text = String(sum)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sumSpendMoney() -> Int {
        let spends = repo.findSpendList()
        
        for spend in spends {
            spendMoneys.append(spend.spendMoney)
        }
        // 消費金額の合計を返却
        return spendMoneys.reduce(0, combine: { $0 + $1 })
    }
    
    func sumSpendMoneyInMonth() -> Int {
        
        let spends = repo.findSpendList()
        
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        
        var equalMonth = true
        
        for spend in spends {
            
            // 今月の支出の場合はtrue
            equalMonth = calendar.isDate(spend.spdendDate, equalToDate: NSDate(), toUnitGranularity: .NSMonthCalendarUnit)
            
            print(spend.spdendDate)
            print(equalMonth)
            // 今月分の支出のみ集計
            if equalMonth {
                spendMoneys.append(spend.spendMoney)
            }
        }
        // 消費金額の合計を返却
        return spendMoneys.reduce(0, combine: { $0 + $1 })
    }

}

