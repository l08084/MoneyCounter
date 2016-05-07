//
//  ViewController.swift
//  MoneyCounter
//
//  Created by 中安拓也 on 2016/05/02.
//  Copyright © 2016年 l08084. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 使用した金額を入力するテキストフィールド
    @IBOutlet weak var moneyTextField: UITextField!
    
    // 今月の支出合計を表示するラベル
    @IBOutlet weak var sumLabel: UILabel!
    
    var spendMoneys: [Int] = []
    
    /// 金額保存ボタン押下後に呼び出し
    @IBAction func saveSpend(sender: AnyObject) {
        
        var inputTextField: UITextField?
        
        let alertController = UIAlertController(title: "メモ", message: "支出の用途について記入してください", preferredStyle: .Alert)
        
        // 既存IDの最大値を取得
        let maxId = repo.findMaxIdInSpend()
        
        let spend = Spend()
        
        let defaultAction = UIAlertAction(title: "記録する", style: .Default, handler: {
            (action: UIAlertAction!) -> Void in
            let textFields: Array<UITextField>? = alertController.textFields as Array<UITextField>?
            if textFields != nil {
                for textField: UITextField in textFields! {
                    
                    // 既存データのID最大値+1
                    spend.id = maxId + 1
                    spend.currency = "YEN"
                    spend.location = "Tokyo"
                    
                    spend.memo = textField.text!
                     self.repo.saveSpend(spend)
                    
                    // 金額TextFieldを空にする234
                    self.moneyTextField!.text = ""
                }
            }
        })
        
        // 記録するのアクションを追加する
        alertController.addAction(defaultAction)
        
        alertController.addTextFieldWithConfigurationHandler { textField -> Void in
            inputTextField = textField
            textField.placeholder = "メモ"
        }
        
        // UIAlertを発動する
        presentViewController(alertController, animated: true, completion: nil)
        
        // 金額入力欄が空欄の場合、金額を代入しない
        if !((moneyTextField.text?.isEmpty)!) {
            spend.spendMoney = Int(moneyTextField.text!)!
        }

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

