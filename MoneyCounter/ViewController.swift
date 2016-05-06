//
//  ViewController.swift
//  MoneyCounter
//
//  Created by 中安拓也 on 2016/05/02.
//  Copyright © 2016年 l08084. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //
    @IBOutlet weak var moneyTextField: UITextField!
    
    // 今月の支出合計を表示するラベル
    @IBOutlet weak var sumLabel: UILabel!
    
    var spendMoneys: [Int] = []
    
    /// 金額保存ボタン押下後に呼び出し
    @IBAction func saveSpend(sender: AnyObject) {
        
        var inputTextField: UITextField?
        
        let alertController = UIAlertController(title: "メモ", message: "支出の用途について記入してください", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "記録する", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        alertController.addTextFieldWithConfigurationHandler { textField -> Void in
            inputTextField = textField
            textField.placeholder = "メモ"
        }
        
        presentViewController(alertController, animated: true, completion: nil)
        
        // 既存IDの最大値を取得
        let maxId = repo.findMaxIdInSpend()
        
        let spend = Spend()
        
        // 既存データのID最大値+1
        spend.id = maxId + 1
        spend.currency = "YEN"
        spend.location = "Tokyo"
        spend.memo = (inputTextField?.text)!
        
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
        sumLabel.text = "\(sum)円"
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
        
        var equalYear = true
        var equalMonth = true
        
        for spend in spends {
            
            // 今年の支出の場合はtrue
            equalYear = calendar.isDate(spend.spendDate, equalToDate:  NSDate(), toUnitGranularity: .NSYearCalendarUnit)
            
            // 今月の支出の場合はtrue
            equalMonth = calendar.isDate(spend.spendDate, equalToDate: NSDate(), toUnitGranularity: .NSMonthCalendarUnit)
            
            // 今月分の支出のみ集計
            if equalYear && equalMonth {
                spendMoneys.append(spend.spendMoney)
            }
        }
        // 消費金額の合計を返却
        return spendMoneys.reduce(0, combine: { $0 + $1 })
    }

}

