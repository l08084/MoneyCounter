//
//  MonthHistoryViewController.swift
//  MoneyCounter
//
//  Created by 中安拓也 on 2016/05/04.
//  Copyright © 2016年 l08084. All rights reserved.
//

import UIKit

class MonthHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var myTableView: UITableView!
    private var myButton = UIButton()
    
    private var moneyList: [String] = ["1月", "2月", "3月","4月", "5月", "6月",
                                       "7月", "8月", "9月", "10月", "11月", "12月"]
    
    private var moneyMonth: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    var repo: Repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let barHeight: CGFloat = UIApplication.sharedApplication().statusBarFrame.size.height
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        
        // Cell名の登録をおこなう
        myTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        // DataSourceの設定をする.
        myTableView.dataSource = self
        
        // Delegateを設定する.
        myTableView.delegate = self
        
        // Viewに追加する
        self.view.addSubview(myTableView)
        
        myButton = UIButton()
        
        // ボタンを生成する.
        myButton.frame = CGRectMake(0, 0, 60, 60)
        myButton.backgroundColor = UIColor.redColor()
        myButton.setTitle("Back", forState: .Normal)
        myButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        myButton.layer.masksToBounds = true
        myButton.layer.cornerRadius = 30.0
        myButton.layer.position = CGPointMake(self.view.frame.width/2, self.view.frame.height-100)
        myButton.addTarget(self, action: #selector(ListViewController.onClickMyButton(_:)), forControlEvents: .TouchUpInside)
        
        // ボタンを追加する.
        self.view.addSubview(myButton)
        
        repo = Repository()
        
        let spends = repo.findSpendList()
        
        // NSCalendarインスタンス
        let cal = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
        
        var month: Int = 0
        
        for spend in spends {
            month = cal.component(.Month, fromDate: spend.spdendDate)
            
            switch month {
            case 1:
                moneyMonth[1] += spend.spendMoney
            case 2:
                moneyMonth[2] += spend.spendMoney
            case 3:
                moneyMonth[3] += spend.spendMoney
            case 4:
                moneyMonth[4] += spend.spendMoney
            case 5:
                moneyMonth[5] += spend.spendMoney
            case 6:
                moneyMonth[6] += spend.spendMoney
            case 7:
                moneyMonth[7] += spend.spendMoney
            case 8:
                moneyMonth[8] += spend.spendMoney
            case 9:
                moneyMonth[9] += spend.spendMoney
            case 10:
                moneyMonth[10] += spend.spendMoney
            case 11:
                moneyMonth[11] += spend.spendMoney
            case 12:
                moneyMonth[12] += spend.spendMoney
            default: break
                
            }
        }
 
    }
    
    /*
     ボタンのアクション時に設定したメソッド.
     */
    internal func onClickMyButton(sender: UIButton){
        performSegueWithIdentifier("HistoryToMain", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    
    /*
     Cellが選択された際に呼び出されるデリゲートメソッド.
     */
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        performSegueWithIdentifier("HistoryToMain", sender: nil)
    }
    
    /*
     Cellの総数を返すデータソースメソッド.
     (実装必須)
     */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moneyList.count
    }
    
    /*
     Cellに値を設定するデータソースメソッド.
     (実装必須)
     */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell", forIndexPath: indexPath)
        
        // Cellに値を設定する.
        cell.textLabel!.text = "\(moneyList[indexPath.row]):\(moneyMonth[indexPath.row])円"
        
        return cell
    }
    
}
