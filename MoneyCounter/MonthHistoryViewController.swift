//
//  MonthHistoryViewController.swift
//  MoneyCounter
//
//  Created by 中安拓也 on 2016/05/04.
//  Copyright © 2016年 l08084. All rights reserved.
//

import UIKit

class MonthHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // 各月支出額合計を表示するTableView
    private var monthSumTableView: UITableView!
    
    // 前画面に戻るボタン
    private var backButton = UIButton()
    
    // 各月のテキスト
    private var monthText: [String] = ["1月", "2月", "3月","4月", "5月", "6月",
                                       "7月", "8月", "9月", "10月", "11月", "12月"]
    // 各月支出額合計
    private var sumMonth: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    // DBアクセサクラスのインスタンス化
    var repo: Repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        monthSumTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう
        monthSumTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        monthSumTableView.dataSource = self
        
        // Delegateを設定する.
        monthSumTableView.delegate = self
        
        // Viewに追加する
        self.view.addSubview(monthSumTableView)
        
        // 戻るボタンのインスタンス化
        backButton = UIButton()
        
        // 戻るボタンを生成する
        backButton.frame = CGRectMake(0, 0, 60, 60)
        backButton.backgroundColor = UIColor.redColor()
        backButton.setTitle("Back", forState: .Normal)
        backButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        backButton.layer.masksToBounds = true
        backButton.layer.cornerRadius = 30.0
        backButton.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height-100)
        backButton.addTarget(self, action: #selector(MonthHistoryViewController.onClickbackButton(_:)), forControlEvents: .TouchUpInside)
        
        // 戻るボタンを追加する.
        self.view.addSubview(backButton)
        
        // spendを全件取得する
        let spends = repo.findSpendList()
        
        // NSCalendarインスタンス
        let cal = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        
        var month: Int = 0
        
        for spend in spends {
            // 支出が何月かを取得
            month = cal.component(.Month, fromDate: spend.spendDate)
            
            // 支出を月ごとに集計
            switch month {
            case 1:
                sumMonth[0] += spend.spendMoney
            case 2:
                sumMonth[1] += spend.spendMoney
            case 3:
                sumMonth[2] += spend.spendMoney
            case 4:
                sumMonth[3] += spend.spendMoney
            case 5:
                sumMonth[4] += spend.spendMoney
            case 6:
                sumMonth[5] += spend.spendMoney
            case 7:
                sumMonth[6] += spend.spendMoney
            case 8:
                sumMonth[7] += spend.spendMoney
            case 9:
                sumMonth[8] += spend.spendMoney
            case 10:
                sumMonth[9] += spend.spendMoney
            case 11:
                sumMonth[10] += spend.spendMoney
            case 12:
                sumMonth[11] += spend.spendMoney
            default: break
                
            }
        }
 
    }
    
    /*
     ボタンのアクション時に設定したメソッド.
     */
    internal func onClickbackButton(sender: UIButton){
        // 金額入力画面に戻る
        performSegueWithIdentifier("HistoryToMain", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    
    /*
     Cellが選択された際に呼び出されるデリゲートメソッド.
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 金額入力画面に戻る
        performSegueWithIdentifier("HistoryToMain", sender: nil)
    }
    
    /*
     Cellの総数を返すデータソースメソッド.
     (実装必須)
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthText.count
    }
    
    /*
     Cellに値を設定するデータソースメソッド.
     (実装必須)
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // 月ごとの支出の合計を表示する
        cell.textLabel!.text = "\(monthText[indexPath.row]):\(sumMonth[indexPath.row])円"
        
        return cell
    }
    
}
